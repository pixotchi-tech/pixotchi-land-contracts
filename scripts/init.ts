import dotenv from 'dotenv';
import { createWalletClient, getAddress, http, parseEther, publicActions } from 'viem';
import { baseSepolia } from 'viem/chains';
import { privateKeyToAccount } from 'viem/accounts';
import { landAbi } from "./landabi";
import { getContract } from 'viem';

dotenv.config();

const SEPOLIA_RPC_URL = process.env.SEPOLIA_RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const SEPOLIA_LAND_CONTRACT_ADDRESS = process.env.SEPOLIA_LAND_CONTRACT_ADDRESS; 

if (!SEPOLIA_RPC_URL || !PRIVATE_KEY) {
    console.error('Please set SEPOLIA_RPC_URL and PRIVATE_KEY in your .env file');
    process.exit(1);
}

const account = privateKeyToAccount(`0x${PRIVATE_KEY}`);

const client = createWalletClient({
    account,
    chain: baseSepolia,
    transport: http(SEPOLIA_RPC_URL),
}).extend(publicActions);

// Create land contract instance
const landContract = getContract({
    address: getAddress(SEPOLIA_LAND_CONTRACT_ADDRESS!),
    abi: landAbi,
    client: client,
});

async function main(): Promise<void> {
    try {
        // Use the contract instance to simulate the call
        const { request } = await landContract.simulate.initFacet();

        // If simulation is successful, proceed with the actual transaction
        if (request) {
            const hash = await landContract.write.initFacet(request);
            console.log('Transaction hash:', hash);

            // Wait for the transaction receipt
            const receipt = await client.waitForTransactionReceipt({
                hash
            });

            console.log('Transaction receipt:', receipt.status);
            console.log('Transaction status:', receipt.status === 'success' ? 'Success' : 'Failed');
        } else {
            console.error('Simulation failed');
        }
    } catch (error) {
        console.error('Error:', error);
    }
}

main();