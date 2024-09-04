// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

//import { LibLandStorage } from "../libs/LibLandStorage.sol";
//import  "../libs/LibAppStorage.sol";
//import   "../shared/Structs.sol";
import "./LibVillageStorage.sol";
import "../shared/Structs.sol";
import "./LibLand.sol";

/// @title LibLand
/// @notice A library for managing land-related operations in the Pixotchi game
library LibVillage {



    /// @notice Upgrades or builds a village building using leaves
    /// @param landId The ID of the land
    /// @param buildingId The ID of the building to upgrade or build
    function _villageUpgradeWithLeaf(uint256 landId, uint8 buildingId) internal returns (uint256 upgradeCost) {
        LibVillageStorage.Data storage s = _sNB();
        
        // Check if the building type is enabled
        require(s.villageBuildingTypes[buildingId].enabled, "Building type is not enabled");

        // Check if the building is not currently upgrading
        require(!_villageIsUpgrading(landId, buildingId), "Building is already upgrading");

        uint8 currentLevel = s.villageBuildings[landId][buildingId].level;
        uint8 nextLevel = currentLevel + 1;

        // Check if the building can be upgraded
        require(nextLevel <= s.villageBuildingTypes[buildingId].maxLevel, "Building already at max level");

        upgradeCost = s.villageBuildingTypes[buildingId].levelData[nextLevel].levelUpgradeCostLeaf;
        uint256 upgradeBlockInterval = s.villageBuildingTypes[buildingId].levelData[nextLevel].levelUpgradeBlockInterval;

        // Check if the user has enough leaves
        //require(_sA().resources[msg.sender].leaves >= upgradeCost, "Not enough leaves");

        // TODO: Implement safe transfer of leaves
        // _safeTransferLeaves(msg.sender, address(this), upgradeCost);

        // If upgrading from level 1 or higher, claim resources first
        if (currentLevel > 0) {
            _villageClaimProduction(landId, buildingId);
        }

        // Set upgrade details
        uint256 upgradeCompletionBlock = block.number + upgradeBlockInterval;
        s.villageBuildings[landId][buildingId].blockHeightUpgradeInitiated = block.number;
        s.villageBuildings[landId][buildingId].blockHeightUntilUpgradeDone = upgradeCompletionBlock;
        s.villageBuildings[landId][buildingId].claimedBlockHeight = upgradeCompletionBlock;
        s.villageBuildings[landId][buildingId].level = nextLevel;

        // TODO: Emit an event for the upgrade initiation
        // emit VillageUpgradeInitiated(landId, buildingId, nextLevel, block.number, upgradeCompletionBlock);

        return upgradeCost;
    }



    /// @notice Speeds up a village building upgrade using a seed
    /// @param landId The ID of the land
    /// @param buildingId The ID of the building to speed up
    function _villageSpeedUpWithSeed(uint256 landId, uint8 buildingId) internal returns (uint256 speedUpCost) {
        LibVillageStorage.Data storage s = _sNB();
        
        // Check if the building is currently upgrading
        require(_villageIsUpgrading(landId, buildingId), "Building is not upgrading");
        
        uint8 currentLevel = s.villageBuildings[landId][buildingId].level;
        speedUpCost = s.villageBuildingTypes[buildingId].levelData[currentLevel].levelUpgradeCostSeedInstant;
        
        // Check if the user has enough seeds
        //require(_sA().resources[msg.sender].seeds >= speedUpCost, "Not enough seeds");
        
        // Deduct seeds and complete the upgrade instantly
        //_sA().resources[msg.sender].seeds -= speedUpCost;
        //s.villageBuildings[landId][buildingId].blockHeightUpgradeInitiated = 0;
        s.villageBuildings[landId][buildingId].blockHeightUntilUpgradeDone = block.number;
        //s.villageBuildings[landId][buildingId].level++;
        s.villageBuildings[landId][buildingId].claimedBlockHeight = block.number;
        
        // TODO: Update production rates or other relevant data

        return speedUpCost;
    }

    /// @notice Claims production from a village building
    /// @param landId The ID of the land
    /// @param buildingId The ID of the building to claim production from
    function _villageClaimProduction(uint256 landId, uint8 buildingId) internal {
        LibVillageStorage.Data storage s = _sNB();
        
        // Check if the building exists and is not upgrading
        require(s.villageBuildingTypes[buildingId].enabled, "Building type is not enabled");
        require(!_villageIsUpgrading(landId, buildingId), "Building is currently upgrading");
        
        // Check if the building produces plant lifetime
        if (s.villageBuildingTypes[buildingId].isProducingPlantLifetime) {
            uint256 accumulatedLifetime = _villageCalculateAccumulatedLifetime(landId, buildingId);
            if (accumulatedLifetime > 0) {
                LibLand._pushAccumulatedPlantLifetime(landId, accumulatedLifetime);
            }
        }
        
        // Check if the building produces plant points
        if (s.villageBuildingTypes[buildingId].isProducingPlantPoints) {
            uint256 accumulatedPoints = _villageCalculateAccumulatedPoints(landId, buildingId);
            if (accumulatedPoints > 0) {
                LibLand._pushExperiencePoints(landId, accumulatedPoints);
            }
        }

        // Update last claim time
        s.villageBuildings[landId][buildingId].claimedBlockHeight = block.number;
        
        // TODO: Emit an event for the production claim
        // emit ProductionClaimed(landId, buildingId, accumulatedLifetime, accumulatedPoints);
    }

    /// @notice Checks if a village building is currently in the process of upgrading
    /// @dev This function performs two checks:
    ///      1. If the upgrade end block is in the future (upgrade not finished)
    ///      2. If the upgrade start block is in the past (upgrade has started)
    /// @param landId The ID of the land where the building is located
    /// @param buildingId The ID of the building to check
    /// @return isUpgrading True if the building is currently upgrading, false otherwise
    function _villageIsUpgrading(uint256 landId, uint8 buildingId) internal view returns (bool isUpgrading) {
        LibVillageStorage.Data storage s = _sNB();
        
        // Check if the building exists
        if (s.villageBuildings[landId][buildingId].level == 0) {
            return false;
        }
        
        // Check if the building is currently upgrading
        // Step 1: Check if the upgrade end block is in the future
        bool upgradeNotFinished = s.villageBuildings[landId][buildingId].blockHeightUntilUpgradeDone > block.number;
        
        // Step 2: Check if the upgrade start block is in the past
        bool upgradeStarted = s.villageBuildings[landId][buildingId].blockHeightUpgradeInitiated < block.number;
        
        // Step 3: Combine both conditions to determine if the building is currently upgrading
        isUpgrading = upgradeNotFinished && upgradeStarted;

        return isUpgrading;
    }

    /// @notice Retrieves all village buildings for a given land ID
    /// @param landId The ID of the land
    /// @return buildings An array of VillageBuilding structs for the given land ID
    function _villageGetBuildingsByLandId(uint256 landId) internal view returns (VillageBuilding[] memory buildings) {
        LibVillageStorage.Data storage s = _sNB();
        
        buildings = new VillageBuilding[](LibVillageStorage.villageEnabledBuildingTypesCount());
        uint8[] memory enabledBuildingTypes = LibVillageStorage.villageEnabledBuildingTypes();
        
        for (uint8 i = 0; i < LibVillageStorage.villageEnabledBuildingTypesCount(); i++) {
            uint8 buildingId = enabledBuildingTypes[i];
            buildings[i] = _getVillageBuildingInfo(landId, buildingId);
        }
        
        return buildings;
    }

    function _getVillageBuildingInfo(uint256 landId, uint8 buildingId) internal view returns (VillageBuilding memory) {
        LibVillageStorage.Data storage s = _sNB();
        LibVillageStorage.VillageBulding storage storedBuilding = s.villageBuildings[landId][buildingId];
        LibVillageStorage.VillageBuildingType storage buildingType = s.villageBuildingTypes[buildingId];
        
        uint8 currentLevel = storedBuilding.level;
        LibVillageStorage.LevelData storage levelData = buildingType.levelData[currentLevel];
        LibVillageStorage.LevelData storage levelDataNext = buildingType.levelData[currentLevel + 1];

        bool isUpgrading = _villageIsUpgrading(landId, buildingId);

        (uint256 levelUpgradeCostLeaf, uint256 levelUpgradeCostSeedInstant, uint256 levelUpgradeBlockInterval) = 
            isUpgrading ? 
            (levelData.levelUpgradeCostLeaf, levelData.levelUpgradeCostSeedInstant, levelData.levelUpgradeBlockInterval) :
            (levelDataNext.levelUpgradeCostLeaf, levelDataNext.levelUpgradeCostSeedInstant, levelDataNext.levelUpgradeBlockInterval);

        return VillageBuilding({
            id: buildingId,
            level: currentLevel,
            maxLevel: buildingType.maxLevel,
            blockHeightUpgradeInitiated: storedBuilding.blockHeightUpgradeInitiated,
            blockHeightUntilUpgradeDone: storedBuilding.blockHeightUntilUpgradeDone,
            accumulatedPoints: _villageCalculateAccumulatedPoints(landId, buildingId),
            accumulatedLifetime: _villageCalculateAccumulatedLifetime(landId, buildingId),
            isUpgrading: isUpgrading,
            levelUpgradeCostLeaf: levelUpgradeCostLeaf,
            levelUpgradeCostSeedInstant: levelUpgradeCostSeedInstant,
            levelUpgradeBlockInterval: levelUpgradeBlockInterval,
            productionRatePlantLifetimePerBlock: levelData.productionRatePlantLifetimePerBlock,
            productionRatePlantPointsPerBlock: levelData.productionRatePlantPointsPerBlock,
            claimedBlockHeight: storedBuilding.claimedBlockHeight
        });
    }

    /// @notice Internal function to access NFT Building storage
    /// @return data The LibLandBuildingStorage.Data struct
    function _sNB() internal pure returns (LibVillageStorage.Data storage data) {
        data = LibVillageStorage.data();
    }

    /// @notice Calculates the accumulated plant points for a village building
    /// @param landId The ID of the land
    /// @param buildingId The ID of the building
    /// @return accumulatedPoints The accumulated plant points
    function _villageCalculateAccumulatedPoints(uint256 landId, uint8 buildingId) internal view returns (uint256 accumulatedPoints) {
        LibVillageStorage.Data storage s = _sNB();
        LibVillageStorage.VillageBulding storage building = s.villageBuildings[landId][buildingId];
        LibVillageStorage.VillageBuildingType storage buildingType = s.villageBuildingTypes[buildingId];

        if (!buildingType.isProducingPlantPoints || building.level == 0 || _villageIsUpgrading(landId, buildingId)) {
            return 0;
        }

        uint256 lastClaimBlock = building.claimedBlockHeight;
        uint256 currentBlock = block.number;

//        if (_villageIsUpgrading(landId, buildingId)) {
//            currentBlock = building.blockHeightUpgradeInitiated;
//        }

        uint256 blocksPassed = currentBlock - lastClaimBlock;
        uint256 productionRate = buildingType.levelData[building.level].productionRatePlantPointsPerBlock;

        accumulatedPoints = (blocksPassed * productionRate) /*/ 1e12*/; // Adjust for precision
    }

    /// @notice Calculates the accumulated plant lifetime for a village building
    /// @param landId The ID of the land
    /// @param buildingId The ID of the building
    /// @return accumulatedLifetime The accumulated plant lifetime in seconds
    function _villageCalculateAccumulatedLifetime(uint256 landId, uint8 buildingId) internal view returns (uint256 accumulatedLifetime) {
        LibVillageStorage.Data storage s = _sNB();
        LibVillageStorage.VillageBulding storage building = s.villageBuildings[landId][buildingId];
        LibVillageStorage.VillageBuildingType storage buildingType = s.villageBuildingTypes[buildingId];

        if (!buildingType.isProducingPlantLifetime || building.level == 0  || _villageIsUpgrading(landId, buildingId)) {
            return 0;
        }

        uint256 lastClaimBlock = building.claimedBlockHeight;
        uint256 currentBlock = block.number;

//        if (_villageIsUpgrading(landId, buildingId)) {
//            currentBlock = building.blockHeightUpgradeInitiated;
//        }

        uint256 blocksPassed = currentBlock - lastClaimBlock;
        uint256 productionRate = buildingType.levelData[building.level].productionRatePlantLifetimePerBlock;

        accumulatedLifetime = (blocksPassed * productionRate * LibVillageStorage.BLOCK_TIME) /*/ 1e18*/; // Convert to seconds and adjust for precision
    }

//    /// @notice Internal function to access AppStorage
//    /// @return data The AppStorage struct
//    function _sA() internal pure returns (AppStorage storage data) {
//        data = LibAppStorage.diamondStorage();
//    }


}
