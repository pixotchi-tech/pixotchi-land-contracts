import dotenv from 'dotenv';
import { http, createConfig } from '@wagmi/core';
import { baseSepolia } from '@wagmi/core/chains';
import { privateKeyToAccount } from 'viem/accounts';
import { createPublicClient, http as viemHttp } from 'viem';

dotenv.config();

const SEPOLIA_RPC_URL = process.env.SEPOLIA_RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

if (!SEPOLIA_RPC_URL || !PRIVATE_KEY) {
    console.error('Please set SEPOLIA_RPC_URL and PRIVATE_KEY in your .env file');
    process.exit(1);
}

const account = privateKeyToAccount(`0x${PRIVATE_KEY}`);

const publicClient = createPublicClient({
    chain: baseSepolia,
    transport: viemHttp(SEPOLIA_RPC_URL)
});

const config = createConfig({
    chains: [baseSepolia],
    client: publicClient,
    accounts: [account]
});

async function main() {
    //try {
        // Dynamically import the CommonJS module
        const { writeLandInit } = await import('./generated_land_wagmi.mjs');

        const result = await writeLandInit({
            config,
            account,
        });

        console.log('Transaction hash:', result);
    //} catch (error) {
    //    console.error('Error calling init function:', error);
    //}
}

main();