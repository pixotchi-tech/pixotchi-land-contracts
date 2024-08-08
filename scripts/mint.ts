import {landContract, publicClient} from "./viemUtils";

async function main(): Promise<void> {
    const args = BigInt(1);

    const {request} = await landContract.simulate.mint([args]);

    if (!request) throw new Error('Simulation failed');

    const hash = await landContract.write.mint([args], request);
    console.log('Transaction hash:', hash);

    console.log('waiting for transaction to be mined...');
    const receipt = await publicClient.waitForTransactionReceipt({
        hash
    });
    console.log('Transaction receipt status:', receipt.status);

}

main();