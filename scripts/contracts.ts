import { getContract } from 'viem';
import { landAbi } from "./landabi";
import { SEPOLIA_LAND_CONTRACT_ADDRESS } from './config';
import { client } from './client';

export const landContract = getContract({
    address: SEPOLIA_LAND_CONTRACT_ADDRESS,
    abi: landAbi,
    client: client,
});