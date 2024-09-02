// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import "./LibPaymentStorage.sol";
import "../shared/Structs.sol";

/// @title LibLand
/// @notice A library for managing land-related operations in the Pixotchi game
library LibPayment {

    // Constants for token addresses
    address internal constant testnetSeedToken = address(0xc64F740D216B6ec49e435a8a08132529788e8DD0);
    address internal constant testnetLeafToken = address(0x33feeD5a3eD803dc03BBF4B6041bB2b86FACD6C4);
    address internal constant mainnetSeedToken = address(0x546D239032b24eCEEE0cb05c92FC39090846adc7);
    address internal constant mainnetLeafToken = address(0xE78ee52349D7b031E2A6633E07c037C3147DB116);

    // Function to get the seed token address based on the network
    function paymentGetSeedToken() internal view returns (address) {
        if (block.chainid == 84532) { // Testnet chain ID
            return testnetSeedToken;
        } else if (block.chainid == 8453) { // Mainnet chain ID
            return mainnetSeedToken;
        } else {
            revert("Unsupported network");
        }
    }

    // Function to get the leaf token address based on the network
    function paymentGetLeafToken() internal view returns (address) {
        if (block.chainid == 84532) { // Testnet chain ID
            return testnetLeafToken;
        } else if (block.chainid == 8453) { // Mainnet chain ID
            return mainnetLeafToken;
        } else {
            revert("Unsupported network");
        }
    }

    function _sNB() internal pure returns (LibPaymentStorage.Data storage data) {
        data = LibPaymentStorage.data();
    }

}
