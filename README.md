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

## Features, Roadmap, and TODOs

### Core Functionality
- [X] Implement ERC721A for gas-efficient NFT minting
- [X] Utilize diamond pattern for upgradeable smart contracts
- [X] Assign unique coordinates to each LAND token
- [X] Implement quadrant-based minting in a spiral pattern
- [X] Enforce maximum supply of 10,000 LAND tokens
- [X] Set coordinate bounds from -50 to 50 on both X and Y axes
- [X] Develop efficient storage management using LibNFTStorage
- [X] Create version-based initialization system
- [X] Implement coordinate occupation tracking
- [X] Develop clamp function for coordinate boundaries
- [X] Enable batch minting of multiple LAND tokens
- [X] Integrate with existing Pixotchi v2 game ecosystem

### Short-term Goals

#### Migration from ERC-7504 Draft Implementation
- [ ] Migrate upgradable building functionality
- [ ] Implement airdrop logic for early adopters and community rewards

#### New Features
- [ ] Develop marketplace functionality for LAND token trading
- [ ] Implement naming logic for LAND tokens
- [ ] Create pricing logic with currency-based pricing via oracle
- [ ] Design and implement quest logic
  - [ ] Incorporate on-chain random value reading without external oracle
- [ ] Integrate non-tradable LEAF token into LAND ecosystem

### Medium-term Goals

- [ ] Implement LAND staking mechanism for passive rewards
- [ ] Develop inter-LAND interactions and shared boundaries logic
- [ ] Create governance system for LAND owners
- [ ] Design and implement resource generation on LAND parcels
- [ ] Develop crafting system utilizing LAND resources and LEAF tokens

### Long-term Vision

- [ ] Create fully decentralized virtual world built on LAND tokens
- [ ] Establish partnerships for third-party development on LAND platform

### Ongoing Development
- [ ] Continuous refinement of smart contract architecture
- [ ] Regular security audits and optimizations
- [ ] Community feedback integration and feature prioritization
- [ ] Performance optimization for gas-efficient operations
- [ ] Documentation expansion and developer resources creation

## Current Project Status

The LAND project has made significant progress, with core NFT functionality and unique coordinate-based features already implemented. We are now focusing on migrating additional features from the ERC-7504 draft and developing new functionalities to enhance the Pixotchi ecosystem.

Key areas of ongoing work include:
1. Finalizing the upgradable building system for dynamic LAND development
2. Implementing a fair and efficient airdrop mechanism to reward early adopters
3. Designing a robust marketplace for seamless LAND token trading
4. Developing an intuitive naming system for LAND parcels
5. Creating a dynamic pricing system that reflects real-world currency values
6. Implementing an engaging quest system with on-chain randomness
7. Expanding the ecosystem with staking, resource generation, and crafting mechanics
8. Integrating the non-tradable LEAF token into the LAND ecosystem

We welcome community contributions and feedback as we continue to expand and improve the LAND project within the Pixotchi universe. Our goal is to create a rich, interactive, and decentralized virtual world that offers unique opportunities for creativity, ownership, and economic activity.

## License

MIT - see [LICSENSE.md](LICENSE.md)