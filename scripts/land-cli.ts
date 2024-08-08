import { createInterface } from 'readline/promises';
import { executeContractWrite } from "./viem-generics";
import {landContract} from './viemUtils';


// Specific function for minting land
async function mint(quantity: bigint): Promise<void> {
    await executeContractWrite(landContract, 'mint', [quantity]);
}

async function getLandCoordinates(fromTokenId: bigint, toTokenId: bigint): Promise<void> {
    // const contract = getContract({
    //     address: landContract.address,
    //     abi: landAbi,
    //     client: publicClient
    // });

    for (let tokenId = fromTokenId; tokenId <= toTokenId; tokenId++) {
        try {
            const [x, y] = await landContract.read.nftGetLandCoordinates([tokenId]);
            //const [x, y] = await contract.read.nftGetLandCoordinates([tokenId]);
            console.log(`Token ID ${tokenId}: (x: ${x}, y: ${y})`);
        } catch (error) {
            console.error(`Error getting coordinates for Token ID ${tokenId}:`, error);
        }
    }
}

// Add this new function for initializing
async function initialize(): Promise<void> {
    await executeContractWrite(landContract, 'initNFTFacet', {} as const);
}

async function main(): Promise<void> {
    const rl = createInterface({
        input: process.stdin,
        output: process.stdout
    });

    while (true) {
        console.log("\nWhat would you like to do?");
        console.log("1. Mint land");
        console.log("2. Get Land Coordinates");
        console.log("3. Initialize (ERC721A)");
        console.log("4. Exit");

        const action = await rl.question("Enter your choice (1-4): ");

        switch (action) {
            case '1':
                const quantityInput = await rl.question("Enter quantity to mint (default is 1): ");
                const quantity = quantityInput ? BigInt(quantityInput) : BigInt(1);
                await mint(quantity);
                break;
            case '2':
                const rangeInput = await rl.question("Enter token ID range (e.g., 9-22): ");
                const [fromStr, toStr] = rangeInput.split('-').map(s => s.trim());
                const fromTokenId = BigInt(fromStr);
                const toTokenId = BigInt(toStr);
                await getLandCoordinates(fromTokenId, toTokenId);
                break;
            case '3':
                await initialize();
                console.log("Initialization completed.");
                break;
            case '4':
                console.log("Exiting CLI...");
                rl.close();
                return;
            default:
                console.log("Invalid choice. Please try again.");
        }
    }
}

main().catch((error) => {
    console.error("An error occurred:", error);
    process.exit(1);
});