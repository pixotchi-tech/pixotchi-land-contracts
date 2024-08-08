import { createWalletClient, createPublicClient, http, publicActions, Chain } from 'viem';
import { base, baseSepolia } from 'viem/chains';
import { privateKeyToAccount } from 'viem/accounts';
import dotenv from 'dotenv';
import { getAddress } from 'viem';
import { getProxyAddressByChainId } from './getProxyAddress';

dotenv.config();

export const RPC_URL = process.env.RPC_URL;
export const PRIVATE_KEY = process.env.PRIVATE_KEY;
export const CHAIN_ID = process.env.CHAIN_ID ? parseInt(process.env.CHAIN_ID) : undefined;

if (!RPC_URL || !PRIVATE_KEY || !CHAIN_ID) {
    console.error('Please set RPC_URL, PRIVATE_KEY, and CHAIN_ID in your .env file');
    process.exit(1);
}

// Global chain object
export const chain: Chain = (() => {
    switch (CHAIN_ID) {
        case 84532:
            return baseSepolia;
        case 8453:
            return base;
        default:
            throw new Error(`Unsupported chain ID: ${CHAIN_ID}. Only Base Sepolia (84532) and Base Mainnet (8453) are supported.`);
    }
})();

const account = privateKeyToAccount(`0x${PRIVATE_KEY}`);

export const walletClient = createWalletClient({
    account,
    chain,
    transport: http(RPC_URL),
}).extend(publicActions);

export const publicClient = createPublicClient({
    chain,
    transport: http(RPC_URL),
});

import { getContract } from 'viem';
import { landAbi } from "./landabi";

// Get the LAND_CONTRACT_ADDRESS using the getProxyAddressByChainId function
export const LAND_CONTRACT_ADDRESS = getAddress(getProxyAddressByChainId(chain.id));

export const landContract = getContract({
    address: LAND_CONTRACT_ADDRESS,
    abi: landAbi,
    client: walletClient,
});