// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import "./LibConstants.sol";

/// @title LibTownStorage
/// @notice Library for managing LAND building storage
library LibTownStorage {
    /// @notice Block time in seconds
    /// @dev This constant represents the average block time on the network
    uint256 internal constant BLOCK_TIME = LibConstants.BLOCK_TIME;

    /// @notice Storage position for the diamond storage
    /// @dev This constant is used to determine the storage slot for diamond storage
    bytes32 internal constant DIAMOND_STORAGE_POSITION =
        keccak256("eth.pixotchi.land.town.storage");

    /// @notice Returns the diamond storage for LAND-related data
    /// @return ds The Data struct containing LAND storage
    function data() internal pure returns (Data storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }

    /// @notice Initializes the Town storage
    /// @dev This function should only be called once during contract initialization
    function initializeTownStorage() internal initializer(1) {
        Data storage s = data();
        //_initBuildingTypes(s);
    }



    /// @notice Error thrown when trying to initialize with a version lower than or equal to the current one
    /// @param currentVersion The current initialization version
    /// @param newVersion The new version attempting to be initialized
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



    /// @notice Struct containing all the storage variables for LAND buildings
    struct Data {
        /// @notice The current initialization version number
        uint256 initializationNumber;
    }

}
