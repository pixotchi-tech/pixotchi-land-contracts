import fs from 'fs';
import path from 'path';

function getProxyAddress(network: string): string {
  // Read the gemforge.deployments.json file
  const filePath = path.join(__dirname, '..', 'gemforge.deployments.json');
  const deploymentData = JSON.parse(fs.readFileSync(filePath, 'utf-8'));

  // Check if the network exists in the deployment data
  if (!deploymentData[network]) {
    throw new Error(`Network "${network}" not found in deployment data`);
  }

  // Find the DiamondProxy contract in the contracts array
  const proxyContract = deploymentData[network].contracts.find(
    (contract: any) => contract.name === 'DiamondProxy'
  );

  // Check if the DiamondProxy contract was found
  if (!proxyContract) {
    throw new Error(`DiamondProxy contract not found for network "${network}"`);
  }

  // Return the proxy address
  return proxyContract.onChain.address;
}

// Example usage
try {
  const testnetProxyAddress = getProxyAddress('testnet');
  console.log('Testnet Proxy Address:', testnetProxyAddress);
} catch (error) {
  console.error('Error:', (error as Error).message);
}

export default getProxyAddress;
