// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;


/// @title LibLandBuildingStorage
/// @notice Library for managing LAND building storage
library LibLandBuildingStorage {
  /// @notice Storage position for the diamond storage
  bytes32 internal constant DIAMOND_STORAGE_POSITION =
    keccak256("eth.pixotchi.land.building.storage");

  /// @notice Returns the diamond storage for LAND-related data
  /// @return ds The Data struct containing LAND storage
  function data() internal pure returns (Data storage ds) {
    bytes32 position = DIAMOND_STORAGE_POSITION;
    assembly {
      ds.slot := position
    }
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

    /// @notice Mapping of village ID to its buildings
    /// @dev Key is the village ID, value is an array of Building structs
    mapping(uint256 => Building[]) villageBuildings;

    /// @notice Mapping of town ID to its buildings
    /// @dev Key is the town ID, value is an array of Building structs
    mapping(uint256 => Building[]) townBuildings;
  }


  /// @notice Represents a building in the game
/// @dev Contains information about a building's state and progress
  struct Building {
    /// @notice Unique identifier for the building type
    uint8 id;
    /// @notice Current level of the building
    uint8 level;
    /// @notice Block number when the upgrade was initiated
    uint256 blockHeightUpgradeInitiated;
    /// @notice Block number when the upgrade will be completed
    uint256 blockHeightUntilUpgradeDone;
    /// @notice Total points accumulated by this building
  }
}