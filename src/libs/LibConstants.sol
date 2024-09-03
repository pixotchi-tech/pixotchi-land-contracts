// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

library LibConstants {

    uint256 internal constant BLOCK_TIME = 2; //2 seconds

    // Constants for token addresses
    address internal constant TESTNET_SEED_TOKEN = address(0xc64F740D216B6ec49e435a8a08132529788e8DD0);
    address internal constant TESTNET_LEAF_TOKEN = address(0x33feeD5a3eD803dc03BBF4B6041bB2b86FACD6C4);
    address internal constant MAINNET_SEED_TOKEN = address(0x546D239032b24eCEEE0cb05c92FC39090846adc7);
    address internal constant MAINNET_LEAF_TOKEN = address(0xE78ee52349D7b031E2A6633E07c037C3147DB116);

    // Constants for receive addresses
    address internal constant TESTNET_SEED_RECEIVE_ADDRESS = address(0x64cce0f734cF9379cca2Ffa8137ddcFE0D64f67d);
    address internal constant TESTNET_LEAF_RECEIVE_ADDRESS = address(0x64cce0f734cF9379cca2Ffa8137ddcFE0D64f67d);
    address internal constant MAINNET_SEED_RECEIVE_ADDRESS = address(0x64cce0f734cF9379cca2Ffa8137ddcFE0D64f67d); //TODO: Change this
    address internal constant MAINNET_LEAF_RECEIVE_ADDRESS = address(0x64cce0f734cF9379cca2Ffa8137ddcFE0D64f67d); //TODO: Change this

    // Constants for chain IDs
    uint256 internal constant TESTNET_CHAIN_ID = 84532;
    uint256 internal constant MAINNET_CHAIN_ID = 8453;

    error UnsupportedNetwork();

    /// @notice Get the seed token address based on the network
    /// @return The address of the seed token for the current network
    function paymentGetSeedToken() internal view returns (address) {
        if (block.chainid == TESTNET_CHAIN_ID) { // Testnet chain ID
            return TESTNET_SEED_TOKEN;
        } else if (block.chainid == MAINNET_CHAIN_ID) { // Mainnet chain ID
            return MAINNET_SEED_TOKEN;
        } else {
            revert UnsupportedNetwork();
        }
    }

    /// @notice Get the leaf token address based on the network
    /// @return The address of the leaf token for the current network
    function paymentGetLeafToken() internal view returns (address) {
        if (block.chainid == TESTNET_CHAIN_ID) { // Testnet chain ID
            return TESTNET_LEAF_TOKEN;
        } else if (block.chainid == MAINNET_CHAIN_ID) { // Mainnet chain ID
            return MAINNET_LEAF_TOKEN;
        } else {
            revert UnsupportedNetwork();
        }
    }

    /// @notice Get the seed receive address based on the network
    /// @return The seed receive address for the current network
    function paymentGetSeedReceiveAddress() internal view returns (address) {
        if (block.chainid == TESTNET_CHAIN_ID) { // Testnet chain ID
            return TESTNET_SEED_RECEIVE_ADDRESS;
        } else if (block.chainid == MAINNET_CHAIN_ID) { // Mainnet chain ID
            return MAINNET_SEED_RECEIVE_ADDRESS;
        } else {
            revert UnsupportedNetwork();
        }
    }

    /// @notice Get the leaf receive address based on the network
    /// @return The leaf receive address for the current network
    function paymentGetLeafReceiveAddress() internal view returns (address) {
        if (block.chainid == TESTNET_CHAIN_ID) { // Testnet chain ID
            return TESTNET_LEAF_RECEIVE_ADDRESS;
        } else if (block.chainid == MAINNET_CHAIN_ID) { // Mainnet chain ID
            return MAINNET_LEAF_RECEIVE_ADDRESS;
        } else {
            revert UnsupportedNetwork();
        }
    }

}
