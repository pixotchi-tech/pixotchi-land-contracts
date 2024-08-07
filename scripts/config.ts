import dotenv from 'dotenv';
import { getAddress } from 'viem';

dotenv.config();

export const SEPOLIA_RPC_URL = process.env.SEPOLIA_RPC_URL;
export const PRIVATE_KEY = process.env.PRIVATE_KEY;
export const SEPOLIA_LAND_CONTRACT_ADDRESS = getAddress(process.env.SEPOLIA_LAND_CONTRACT_ADDRESS!);

if (!SEPOLIA_RPC_URL || !PRIVATE_KEY || !SEPOLIA_LAND_CONTRACT_ADDRESS) {
    console.error('Please set SEPOLIA_RPC_URL, PRIVATE_KEY, and SEPOLIA_LAND_CONTRACT_ADDRESS in your .env file');
    process.exit(1);
}