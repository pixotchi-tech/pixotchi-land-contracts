// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/// @title Game Structures
/// @notice Defines the main data structures used in the game

/// @notice Stores context for meta-transactions
/// @dev Used for storing trusted forwarder address in EIP-2771 context
struct MetaTxContextStorage {
    /// @notice Address of the trusted forwarder for meta-transactions
    address trustedForwarder;
}

/// @notice Represents a land parcel in the game
/// @dev This struct contains all the essential information about a land
struct Land {
    /// @notice Unique identifier for the land
    uint256 tokenId;
    /// @notice URI for the land's metadata
    string tokenUri;
    /// @notice Timestamp of when the land was minted
    uint256 mintDate;
    /// @notice Address of the land owner
    address owner;
    /// @notice Custom name given to the land
    string name;
    /// @notice X-coordinate of the land on the game map
    int256 coordinateX;
    /// @notice Y-coordinate of the land on the game map
    int256 coordinateY;
    /// @notice Total experience points accumulated on this land
    uint256 experiencePoints;
    /// @notice Cumulative points earned from plants on this land
    uint256 accumulatedPlantPoints;
    /// @notice Total lifetime of all plants grown on this land
    uint256 accumulatedPlantLifetime;
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
    uint256 accumulatedPoints;
    /// @notice Total lifetime of the building
    uint256 accumulatedLifetime;
}

/// @notice Defines the properties of a building type
/// @dev Contains static information about a building type and its upgrade costs
struct BuildingType {
    /// @notice Unique identifier for the building type
    uint8 id;
    /// @notice Name of the building type
    string name;
    /// @notice Maximum level this building type can reach
    uint8 maxLevel;
    /// @notice Whether this building type can be upgraded
    bool upgradable;
    /// @notice Whether this building type comes pre-built
    bool preBuilt;
    /// @notice Leaf cost for upgrading to each level
    uint256[] levelUpgradeCostLeaf;
    /// @notice Seed cost for instant upgrade to each level
    uint256[] levelUpgradeCostSeedInstant;
    /// @notice Block interval required for upgrading to each level
    uint256[] levelUpgradeBlockInterval;
    /// @notice Whether this building type produces plant points
    bool isProducingPlantPoints;
    /// @notice Whether this building type produces plant lifetime
    bool isProducingPlantLifetime;
    /// @notice Production rate of plant lifetime per block for each level
    uint256[] productionRatePlantLifetimePerBlock;
    /// @notice Production rate of plant points per block for each level
    uint256[] productionRatePlantPointsPerBlock;
}