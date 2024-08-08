import {landContract} from "./viemUtils";
import {client} from "../.history/scripts/client_20240807224430";


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