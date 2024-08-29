// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {LibLandStorage} from "../libs/LibLandStorage.sol";
import {LibAppStorage, AppStorage} from "../libs/LibAppStorage.sol";
import {NFTModifiers} from "../libs/LibNFT.sol";
import {LibLand} from "../libs/LibLand.sol";
import "../shared/Structs.sol";

contract VillageFacet is NFTModifiers {


    /// @notice Internal function to access NFT storage
    /// @return data The LibLandStorage.Data struct
    function _sN() internal pure returns (LibLandStorage.Data storage data) {
        data = LibLandStorage.data();
    }

    /// @notice Internal function to access AppStorage
    /// @return data The AppStorage struct
    function _sA() internal pure returns (AppStorage storage data) {
        data = LibAppStorage.diamondStorage();
    }





    /// @notice Get all village buildings for a given land ID
    /// @param landId The ID of the land
    /// @return villageBuildings An array of VillageBuilding structs containing the building information
    function landGetVillageBuildingsByLandId(uint256 landId) public view exists(landId) returns (VillageBuilding[] memory villageBuildings) {
        //TODO: implement actual logic to fetch from storage
        villageBuildings = new VillageBuilding[](3);
        
        villageBuildings[0] = VillageBuilding({
            id: 0, // Solar
            level: 1,
            blockHeightUpgradeInitiated: block.number - 1000,
            blockHeightUntilUpgradeDone: block.number + 1000,
            accumulatedPoints: 1000,
            accumulatedLifetime: 500,
            isUpgrading: false,
            levelUpgradeCostLeaf: 100,
            levelUpgradeCostSeedInstant: 50,
            levelUpgradeBlockInterval: 1000,
            productionRatePlantLifetimePerBlock: 5,
            productionRatePlantPointsPerBlock: 10,
            maxLevel: 5,
            claimedBlockHeight: block.number - 1000
        });

        villageBuildings[1] = VillageBuilding({
            id: 3, // Soil Factory
            level: 1,
            blockHeightUpgradeInitiated: block.number - 900,
            blockHeightUntilUpgradeDone: block.number + 900,
            accumulatedPoints: 800,
            accumulatedLifetime: 400,
            isUpgrading: true,
            levelUpgradeCostLeaf: 120,
            levelUpgradeCostSeedInstant: 60,
            levelUpgradeBlockInterval: 1100,
            productionRatePlantLifetimePerBlock: 6,
            productionRatePlantPointsPerBlock: 12,
            maxLevel: 4,
            claimedBlockHeight: block.number - 900
        });

        villageBuildings[2] = VillageBuilding({
            id: 5, // Bee Farm
            level: 2,
            blockHeightUpgradeInitiated: block.number - 800,
            blockHeightUntilUpgradeDone: block.number + 800,
            accumulatedPoints: 1200,
            accumulatedLifetime: 600,
            isUpgrading: false,
            levelUpgradeCostLeaf: 150,
            levelUpgradeCostSeedInstant: 75,
            levelUpgradeBlockInterval: 1200,
            productionRatePlantLifetimePerBlock: 7,
            productionRatePlantPointsPerBlock: 14,
            maxLevel: 6,
            claimedBlockHeight: block.number - 800
        });

        return villageBuildings;
    }


    function villageUpgradeWithLeaf(uint256 landId, uint8 buildingId) public exists(landId) {
        //TODO: implement actual logic to upgrade village building
    }

    function villageSpeedUpWithSeed(uint256 landId, uint8 buildingId) public exists(landId) {
        //TODO: implement actual logic to upgrade village building
    }

    function townUpgradeWithLeaf(uint256 landId, uint8 buildingId) public exists(landId) {
        //TODO: implement actual logic to upgrade town building
    }

    function townSpeedUpWithSeed(uint256 landId, uint8 buildingId) public exists(landId) {
        //TODO: implement actual logic to upgrade town building
    }
    
    function claimVillageProduction(uint256 landId, uint8 buildingId) public exists(landId) {
        //TODO: implement actual logic to claim village production
    }

    







}