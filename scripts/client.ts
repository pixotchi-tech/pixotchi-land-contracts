import { createWalletClient, createPublicClient, http, publicActions } from 'viem';
import { baseSepolia } from 'viem/chains';
import { privateKeyToAccount } from 'viem/accounts';
import { SEPOLIA_RPC_URL, PRIVATE_KEY } from './config';

const account = privateKeyToAccount(`0x${PRIVATE_KEY}`);

export const walletClient = createWalletClient({
    account,
    chain: baseSepolia,
    transport: http(SEPOLIA_RPC_URL),
}).extend(publicActions);

export const publicClient = createPublicClient({
    chain: baseSepolia,
    transport: http(SEPOLIA_RPC_URL),
});