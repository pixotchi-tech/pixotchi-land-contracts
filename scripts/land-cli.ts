import {landContract} from './contracts';
import {client} from './client';

async function mint(quantity: bigint): Promise<void> {
    const {request} = await landContract.simulate.mint([quantity]);

    if (!request) throw new Error('Simulation failed');

    const hash = await landContract.write.mint([quantity], request);
    console.log('Transaction hash:', hash);

    console.log('waiting for transaction to be mined...');
    const receipt = await client.waitForTransactionReceipt({
        hash
    });
    console.log('Transaction receipt status:', receipt.status);
}

async function main(): Promise<void> {
    const quantity = BigInt(1);
    await mint(quantity);
}

main();