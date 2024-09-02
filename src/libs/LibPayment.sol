// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

//import "./LibPaymentStorage.sol";
import "../shared/Structs.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title LibLand
/// @notice A library for managing land-related operations in the Pixotchi game
library LibPayment {

    // Custom errors
    error UnsupportedNetwork();
    error AmountMustBeGreaterThanZero();
    error InsufficientBalance();
    error InsufficientAllowance();

    // Constants for token addresses
    address internal constant testnetSeedToken = address(0xc64F740D216B6ec49e435a8a08132529788e8DD0);
    address internal constant testnetLeafToken = address(0x33feeD5a3eD803dc03BBF4B6041bB2b86FACD6C4);
    address internal constant mainnetSeedToken = address(0x546D239032b24eCEEE0cb05c92FC39090846adc7);
    address internal constant mainnetLeafToken = address(0xE78ee52349D7b031E2A6633E07c037C3147DB116);

    // Constants for receive addresses
    address internal constant testnetSeedReceiveAddress = address(0x64cce0f734cF9379cca2Ffa8137ddcFE0D64f67d);
    address internal constant testnetLeafReceiveAddress = address(0x64cce0f734cF9379cca2Ffa8137ddcFE0D64f67d);
    address internal constant mainnetSeedReceiveAddress = address(0x64cce0f734cF9379cca2Ffa8137ddcFE0D64f67d); //TODO: Change this
    address internal constant mainnetLeafReceiveAddress = address(0x64cce0f734cF9379cca2Ffa8137ddcFE0D64f67d); //TODO: Change this

    // Constants for chain IDs
    uint256 internal constant testnetChainId = 84532;
    uint256 internal constant mainnetChainId = 8453;

    // Function to get the seed token address based on the network
    function paymentGetSeedToken() internal view returns (address) {
        if (block.chainid == testnetChainId) { // Testnet chain ID
            return testnetSeedToken;
        } else if (block.chainid == mainnetChainId) { // Mainnet chain ID
            return mainnetSeedToken;
        } else {
            revert UnsupportedNetwork();
        }
    }

    // Function to get the leaf token address based on the network
    function paymentGetLeafToken() internal view returns (address) {
        if (block.chainid == testnetChainId) { // Testnet chain ID
            return testnetLeafToken;
        } else if (block.chainid == mainnetChainId) { // Mainnet chain ID
            return mainnetLeafToken;
        } else {
            revert UnsupportedNetwork();
        }
    }

    // Function to get the seed receive address based on the network
    function paymentGetSeedReceiveAddress() internal view returns (address) {
        if (block.chainid == testnetChainId) { // Testnet chain ID
            return testnetSeedReceiveAddress;
        } else if (block.chainid == mainnetChainId) { // Mainnet chain ID
            return mainnetSeedReceiveAddress;
        } else {
            revert UnsupportedNetwork();
        }
    }

    // Function to get the leaf receive address based on the network
    function paymentGetLeafReceiveAddress() internal view returns (address) {
        if (block.chainid == testnetChainId) { // Testnet chain ID
            return testnetLeafReceiveAddress;
        } else if (block.chainid == mainnetChainId) { // Mainnet chain ID
            return mainnetLeafReceiveAddress;
        } else {
            revert UnsupportedNetwork();
        }
    }

    /// @notice Pays with Seed token
    /// @param from The address to transfer the tokens from
    /// @param amount The amount of tokens to transfer
    function paymentPayWithSeed(address from, uint256 amount) internal {
        address tokenAddress = paymentGetSeedToken();
        address receiveAddress = paymentGetSeedReceiveAddress();

        // Checks
        if (amount <= 0) revert AmountMustBeGreaterThanZero();
        if (IERC20(tokenAddress).balanceOf(from) < amount) revert InsufficientBalance();
        if (IERC20(tokenAddress).allowance(from, address(this)) < amount) revert InsufficientAllowance();

        // Effects
        // No state variables to update in this case

        // Interactions
        SafeERC20.safeTransferFrom(IERC20(tokenAddress), from, receiveAddress, amount);
    }

    /// @notice Pays with Leaf token
    /// @param from The address to transfer the tokens from
    /// @param amount The amount of tokens to transfer
    function paymentPayWithLeaf(address from, uint256 amount) internal {
        address tokenAddress = paymentGetLeafToken();
        address receiveAddress = paymentGetLeafReceiveAddress();

        // Checks
        if (amount <= 0) revert AmountMustBeGreaterThanZero();
        if (IERC20(tokenAddress).balanceOf(from) < amount) revert InsufficientBalance();
        if (IERC20(tokenAddress).allowance(from, address(this)) < amount) revert InsufficientAllowance();

        // Effects
        // No state variables to update in this case

        // Interactions
        SafeERC20.safeTransferFrom(IERC20(tokenAddress), from, receiveAddress, amount);
    }

    // function _sNB() internal pure returns (LibPaymentStorage.Data storage data) {
    //     data = LibPaymentStorage.data();
    // }

}
