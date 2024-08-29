// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

//import { LibLandStorage } from "../libs/LibLandStorage.sol";
//import  "../libs/LibAppStorage.sol";
//import   "../shared/Structs.sol";
import "./LibVillageStorage.sol";

/// @title LibLand
/// @notice A library for managing land-related operations in the Pixotchi game
library LibVillage {

    /// @notice Upgrades or builds a village building using leaves
    /// @param landId The ID of the land
    /// @param buildingId The ID of the building to upgrade or build
    function _villageUpgradeWithLeaf(uint256 landId, uint8 buildingId) internal {
        LibVillageStorage.Data storage s = _sNB();
        
        // Check if the building type is enabled
        require(s.villageBuildingTypes[buildingId].enabled, "Building type is not enabled");

        // Check if the building is not currently upgrading
        require(!_villageIsUpgrading(landId, buildingId), "Building is already upgrading");

        uint8 currentLevel = s.villageBuildings[landId][buildingId].level;
        uint8 nextLevel = currentLevel + 1;

        // Check if the building can be upgraded
        require(nextLevel <= s.villageBuildingTypes[buildingId].maxLevel, "Building already at max level");

        uint256 upgradeCost = s.villageBuildingTypes[buildingId].levelData[nextLevel].levelUpgradeCostLeaf;
        uint256 upgradeBlockInterval = s.villageBuildingTypes[buildingId].levelData[nextLevel].levelUpgradeBlockInterval;

        // Check if the user has enough leaves
        //require(_sA().resources[msg.sender].leaves >= upgradeCost, "Not enough leaves");

        // TODO: Implement safe transfer of leaves
        // _safeTransferLeaves(msg.sender, address(this), upgradeCost);

        // If upgrading from level 1 or higher, claim resources first
        if (currentLevel > 0) {
            _villageClaimResources(landId, buildingId);
        }

        // Set upgrade details
        uint256 upgradeCompletionBlock = block.number + upgradeBlockInterval;
        s.villageBuildings[landId][buildingId].blockHeightUpgradeInitiated = block.number;
        s.villageBuildings[landId][buildingId].blockHeightUntilUpgradeDone = upgradeCompletionBlock;
        s.villageBuildings[landId][buildingId].claimedBlockHeight = upgradeCompletionBlock;

        // TODO: Emit an event for the upgrade initiation
        // emit VillageUpgradeInitiated(landId, buildingId, nextLevel, block.number, upgradeCompletionBlock);
    }

    /// @notice Claims resources from a village building
    /// @param landId The ID of the land
    /// @param buildingId The ID of the building to claim resources from
    function _villageClaimResources(uint256 landId, uint8 buildingId) internal {
        // TODO: Implement resource claiming logic
        // This function should calculate and distribute the resources produced since the last claim

        // Example structure:
        // 1. Get the current building data
        // 2. Calculate the time passed since the last claim
        // 3. Calculate the resources produced based on the building's production rate
        // 4. Update the player's resource balance
        // 5. Update the building's last claim time
        // 6. Emit an event for the resource claim
    }

    /// @notice Speeds up a village building upgrade using a seed
    /// @param landId The ID of the land
    /// @param buildingId The ID of the building to speed up
    function _villageSpeedUpWithSeed(uint256 landId, uint8 buildingId) internal {
        LibVillageStorage.Data storage s = _sNB();
        
        // Check if the building is currently upgrading
        require(_villageIsUpgrading(landId, buildingId), "Building is not upgrading");
        
        // Check if the user has enough seeds
        //require(_sA().resources[msg.sender].seeds >= s.speedUpCost, "Not enough seeds");
        
        // Deduct seeds and complete the upgrade instantly
        //_sA().resources[msg.sender].seeds -= s.speedUpCost;
        s.villageBuildings[landId][buildingId].blockHeightUpgradeInitiated = 0;
        s.villageBuildings[landId][buildingId].blockHeightUntilUpgradeDone = block.number;
        s.villageBuildings[landId][buildingId].level++;
        
        // TODO: Update production rates or other relevant data
    }

    /// @notice Claims production from a village building
    /// @param landId The ID of the land
    /// @param buildingId The ID of the building to claim production from
    function _villageClaimProduction(uint256 landId, uint8 buildingId) internal {
        //TODO: split intro 3 functions. we have to check if the building is upgrading. we have to also check if the isProducingPlantPoints and isProducingPlantLifetime.
        LibVillageStorage.Data storage s = _sNB();
        
        // Check if the building exists
        require(s.villageBuildingTypes[buildingId].enabled, "Building type is not enabled");
        
        // Calculate production since last claim
        uint256 timeSinceLastClaim = block.number - s.villageBuildings[landId][buildingId].claimedBlockHeight;
        uint256 production = timeSinceLastClaim * s.villageBuildingTypes[buildingId].levelData[s.villageBuildings[landId][buildingId].level].productionRatePlantLifetimePerBlock;
        

        // Update last claim time
        s.villageBuildings[landId][buildingId].claimedBlockHeight = block.number;
        
        // TODO: Add produced resources to the player's balance
        // This part requires access to the player's resource storage, which might be in a different contract
        // _sA().resources[msg.sender].someResource += production;
        
        // TODO: Emit an event for the production claim
        // emit ProductionClaimed(landId, buildingId, production);
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

    /// @notice Internal function to access NFT Building storage
    /// @return data The LibLandBuildingStorage.Data struct
    function _sNB() internal pure returns (LibVillageStorage.Data storage data) {
        data = LibVillageStorage.data();
    }

//    /// @notice Internal function to access AppStorage
//    /// @return data The AppStorage struct
//    function _sA() internal pure returns (AppStorage storage data) {
//        data = LibAppStorage.diamondStorage();
//    }


}
