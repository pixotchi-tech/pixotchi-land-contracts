import {landContract} from './contracts';
import {client} from './client';

async function main(): Promise<void> {
    const args = BigInt(1);

    const {request} = await landContract.simulate.mint([args]);

    if (!request) throw new Error('Simulation failed');

    const hash = await landContract.write.mint([args], request);
    console.log('Transaction hash:', hash);

    console.log('waiting for transaction to be mined...');
    const receipt = await client.waitForTransactionReceipt({
        hash
    });
    console.log('Transaction receipt status:', receipt.status);

}

main();