// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import "./LibTownStorage.sol";
import "../shared/Structs.sol";

/// @title LibTown
/// @notice A library for managing town-related operations in the Pixotchi game
library LibTown {
    /// @notice Get all town buildings for a given land ID
    /// @param landId The ID of the land
    /// @return townBuildings An array of TownBuilding structs containing the building information
    function _getBuildingsByLandId(uint256 landId) internal view returns (TownBuilding[] memory townBuildings) {
        LibTownStorage.Data storage s = LibTownStorage.data();
        
        townBuildings = new TownBuilding[](LibTownStorage.townEnabledBuildingTypesCount());
        uint8[] memory enabledBuildingTypes = LibTownStorage.townEnabledBuildingTypes();
        
        for (uint8 i = 0; i < LibTownStorage.townEnabledBuildingTypesCount(); i++) {
            uint8 buildingId = enabledBuildingTypes[i];
            townBuildings[i] = _getTownBuildingInfo(s, landId, buildingId);
        }
        
        return townBuildings;
    }

    function _getTownBuildingInfo(LibTownStorage.Data storage s, uint256 landId, uint8 buildingId) internal view returns (TownBuilding memory) {
        LibTownStorage.TownBuilding storage storedBuilding = s.townBuildings[landId][buildingId];
        LibTownStorage.TownBuildingType storage buildingType = s.townBuildingTypes[buildingId];
        
        uint8 currentLevel = storedBuilding.level;
        LibTownStorage.LevelData storage levelData = buildingType.levelData[currentLevel];
        LibTownStorage.LevelData storage levelDataNext = buildingType.levelData[currentLevel + 1];

        bool isUpgrading = storedBuilding.blockHeightUntilUpgradeDone > block.number;

        return TownBuilding({
            id: buildingId,
            level: currentLevel,
            maxLevel: buildingType.maxLevel,
            blockHeightUpgradeInitiated: storedBuilding.blockHeightUpgradeInitiated,
            blockHeightUntilUpgradeDone: storedBuilding.blockHeightUntilUpgradeDone,
            isUpgrading: isUpgrading,
            levelUpgradeCostLeaf: isUpgrading ? levelData.levelUpgradeCostLeaf : levelDataNext.levelUpgradeCostLeaf,
            levelUpgradeCostSeedInstant: isUpgrading ? levelData.levelUpgradeCostSeedInstant : levelDataNext.levelUpgradeCostSeedInstant,
            levelUpgradeBlockInterval: isUpgrading ? levelData.levelUpgradeBlockInterval : levelDataNext.levelUpgradeBlockInterval
        });
    }

    /// @notice Upgrade a town building using leaves
    /// @param landId The ID of the land
    /// @param buildingId The ID of the building to upgrade
    /// @return upgradeCost The cost of the upgrade in leaves
    function _upgradeWithLeaf(uint256 landId, uint8 buildingId) internal returns (uint256 upgradeCost) {
        // Dummy implementation
        upgradeCost = 100;
        // TODO: Implement actual upgrade logic
    }

    /// @notice Speed up a town building upgrade using seeds
    /// @param landId The ID of the land
    /// @param buildingId The ID of the building to speed up
    /// @return speedUpCost The cost of speeding up the upgrade in seeds
    function _speedUpWithSeed(uint256 landId, uint8 buildingId) internal returns (uint256 speedUpCost) {
        // Dummy implementation
        speedUpCost = 10;
        // TODO: Implement actual speed up logic
    }
}
