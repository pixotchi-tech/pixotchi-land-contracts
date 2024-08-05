# LAND - Pixotchi v3

This project is an extension of the Pixotchi v2 game, introducing a new NFT (ERC721A) component called LAND. It leverages the diamond pattern for upgradeable smart contracts and uses [Gemforge](https://gemforge.xyz) with [Foundry](https://github.com/foundry-rs/foundry) for development and deployment.

## Project Overview

LAND is an NFT project built on the ERC721A standard, which allows for gas-efficient minting of multiple NFTs in a single transaction. The main token of the Pixotchi ecosystem remains SEED, while LAND introduces a new dimension to the game.

Key features of the LAND contract:

- Utilizes the diamond pattern for upgradeability
- Implements ERC721A for efficient minting
- Assigns unique coordinates to each minted NFT
- Manages a maximum supply of 10,000 LANDs
- Coordinates range from -50 to 50 on both X and Y axes

## Smart Contract Structure

The project consists of two main components:

1. `NFTFacet.sol`: Implements the core NFT functionality
   - Minting of LAND tokens
   - Coordinate assignment for each token
   - Utilizes ERC721AUpgradeable for gas-efficient operations

2. `LibNFTStorage.sol`: Manages the storage for the NFT contract
   - Defines the structure for storing token data and coordinates
   - Implements initialization and storage access functions

## Development and Deployment

This project uses Gemforge for streamlined development and deployment:

- Build and deploy commands are pre-configured
- Includes a pre-configured config file
- Features a post-deploy hook for Etherscan verification

## Requirements

* [Node.js 20+](https://nodejs.org)
* [PNPM](https://pnpm.io/) _(NOTE: `yarn` and `npm` can also be used)_
* [Foundry](https://github.com/foundry-rs/foundry/blob/master/README.md)

## Installation

In an empty folder:

```
npx gemforge scaffold
```

Change into the folder and run in order:

```
$ foundryup  # On OS X you may first need to run: brew install libusb
$ pnpm i
$ git submodule update --init --recursive
```

Create `.env` and set the following within:

```
LOCAL_RPC_URL=http://localhost:8545
SEPOLIA_RPC_URL=<your infura/alchemy endpoint for spolia>
ETHERSCAN_API_KEY=<your etherscan api key>
MNEMONIC=<your deployment wallet mnemonic>
```

## Usage

Run a local dev node in a separate terminal:

```
pnpm devnet
```

To build the code:

```
$ pnpm build
```

To run the tests:

```
$ pnpm test
```

To deploy to the local target:

```
$ pnpm dep local
```

To deploy to the testnet target (sepolia):

```
$ pnpm dep testnet
```

For verbose output simply add `-v`:

```
$ pnpm build -v
$ pnpm dep -v
```

## LAND Specific Features

- **Coordinate System**: Each LAND token is assigned unique X and Y coordinates.
- **Quadrant-based Minting**: Tokens are minted in a spiral pattern across four quadrants.
- **Supply Limit**: A maximum of 10,000 LAND tokens can be minted.
- **Coordinate Bounds**: X and Y coordinates are limited to the range of -50 to 50.

## Integration with Pixotchi v2

LAND extends the existing Pixotchi v2 game, adding a new dimension of gameplay and asset ownership. While SEED remains the primary token, LAND introduces new possibilities for territorial gameplay and asset management within the Pixotchi ecosystem.

## License

MIT - see [LICSENSE.md](LICENSE.md)