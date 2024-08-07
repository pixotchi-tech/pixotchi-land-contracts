import { createInterface } from 'readline/promises';
import { landContract } from './contracts';
import { client } from './client';
import { parseEventLogs } from 'viem';

async function mint(quantity: bigint): Promise<void> {
    const { request } = await landContract.simulate.mint([quantity]);

    if (!request) throw new Error('Simulation failed');

    const hash = await landContract.write.mint([quantity], request);
    console.log('Transaction hash:', hash);

    console.log('waiting for transaction to be mined...');
    const receipt = await client.waitForTransactionReceipt({
        hash
    });
    console.log('Transaction receipt status:', receipt.status);

    // Parse and log all events
    const logs = parseEventLogs({
        abi: landContract.abi,
        logs: receipt.logs
    });

    console.log('Event logs:');
    logs.forEach(log => {
        console.log(`- Event: ${log.eventName}`);
        console.log(`  Arguments:`, log.args);
    });
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