// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

//import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
//import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

/// @title LibPaymentStorage
/// @notice Library for managing Payment storage in the Pixotchi game
/// @dev This library provides functions and structures for Payment-related data storage
library LibPaymentStorage {
    bytes32 internal constant DIAMOND_STORAGE_POSITION = keccak256("eth.pixotchi.land.payment.storage");

    /// @notice Returns the diamond storage for Payment-related data
    /// @return ds The PaymentStorage struct
    function data() internal pure returns (Data storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }

    /// @notice Initializes the Payment storage with default values
    /// @dev This function can only be called once
    function initializePaymentStorage() internal initializer(1) {
        Data storage s = data();

        s.seedToken = address(0xc64F740D216B6ec49e435a8a08132529788e8DD0); //testnet
        s.leafToken = address(0x33feeD5a3eD803dc03BBF4B6041bB2b86FACD6C4); //testnet



//        s.maxSupply = 20000;
//        s.minX = -112;
//        s.maxX = 112;
//        s.minY = -112;
//        s.maxY = 112;
    }

    /// @dev Error thrown when trying to initialize with a version lower than or equal to the current version
    /// @param currentVersion The current initialization version
    /// @param newVersion The new version attempted to initialize
    error AlreadyInitialized(uint256 currentVersion, uint256 newVersion);

    /// @notice Modifier to ensure initialization is done only once per version
    /// @param version The version number of the initializer
    modifier initializer(uint256 version) {
        Data storage s = data();
        if (s.initializationNumber >= version) {
            revert AlreadyInitialized(s.initializationNumber, version);
        }
        _;
        s.initializationNumber = version;
    }

//    /// @notice Struct to represent coordinates of a Payment
//    /// @param x The x-coordinate
//    /// @param y The y-coordinate
//    /// @param occupied Whether the coordinate is occupied
//    struct Coordinates {
//        int256 x;
//        int256 y;
//        bool occupied;
//    }

    /// @notice Main data structure for Payment storage
    struct Data {
        /// @notice The initialization version number
        uint256 initializationNumber;

        address seedToken;

        address leafToken;



    }
}