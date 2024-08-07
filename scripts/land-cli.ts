import { createInterface } from 'readline/promises';
import { landContract } from './contracts';
import {executeContractWrite} from "./viem-generics";


// Specific function for minting land
async function mint(quantity: bigint): Promise<void> {
    await executeContractWrite(landContract, 'mint', [quantity]);
}

function helloWorld(): void {
    console.log('Hello, World!');
}

async function main(): Promise<void> {
    const rl = createInterface({
        input: process.stdin,
        output: process.stdout
    });

    while (true) {
        console.log("\nWhat would you like to do?");
        console.log("1. Mint land");
        console.log("2. Say Hello World");
        console.log("3. Exit");

        const action = await rl.question("Enter your choice (1-3): ");

        switch (action) {
            case '1':
                const quantityInput = await rl.question("Enter quantity to mint (default is 1): ");
                const quantity = quantityInput ? BigInt(quantityInput) : BigInt(1);
                await mint(quantity);
                break;
            case '2':
                helloWorld();
                break;
            case '3':
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