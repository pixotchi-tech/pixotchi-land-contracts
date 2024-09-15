// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

//import {LibLandStorage} from "../libs/LibLandStorage.sol";
//import {LibAppStorage, AppStorage} from "../libs/LibAppStorage.sol";
import {NFTModifiers} from "../libs/LibNFT.sol";
//import {LibLand} from "../libs/LibLand.sol";
import "../shared/Structs.sol";
//import {LibVillage} from "../libs/LibVillage.sol";
//import {LibPayment} from "../libs/LibPayment.sol";
//import {LibXP} from "../libs/LibXP.sol";
import {LibQuest} from "../libs/LibQuest.sol";

contract QuestFacet is NFTModifiers {


    // enum QuestDifficultyLevel { EASY, MEDIUM, HARD }

    // struct QuestDifficulty {
    // QuestDifficultyLevel difficulty;
    // uint256 duration;
    // }

    // struct Quest {
    // QuestDifficulty difficulty;
    // uint256 startBlock;
    // uint256 endBlock;
    // }


    function questGetByLandId(uint256 landId) public view returns (Quest[] memory quests) {
        return LibQuest.getQuests(landId);
    }

    function questStart(uint256 landId, QuestDifficultyLevel difficultyLevel, uint256 farmerSlotId) public {
        LibQuest.startQuest(landId, difficultyLevel, farmerSlotId);
    }

    function questCommit(uint256 landId, uint256 farmerSlotId) public {
        LibQuest.commitQuest(landId, farmerSlotId);
    }

    function questFinalize(uint256 landId, uint256 farmerSlotId) public returns (bool success) {
        return LibQuest.finalizeQuest(landId, farmerSlotId);
    }

    













//     /// @notice Get all village buildings for a given land ID
//     /// @param landId The ID of the land
//     /// @return villageBuildings An array of VillageBuilding structs containing the building information
//     function villageGetVillageBuildingsByLandId(uint256 landId) public view exists(landId) returns (VillageBuilding[] memory villageBuildings) {
//         return LibVillage._villageGetBuildingsByLandId(landId);
//     }

//     /// @notice Upgrade a village building using leaves
//     /// @param landId The ID of the land
//     /// @param buildingId The ID of the building to upgrade
//     function villageUpgradeWithLeaf(uint256 landId, uint8 buildingId) public exists(landId) {
//         (uint256 upgradeCost, uint256 xp) = LibVillage._villageUpgradeWithLeaf(landId, buildingId);
//         LibXP.pushExperiencePoints(landId, xp);
//         LibPayment.paymentPayWithLeaf(msg.sender, upgradeCost);
//     }

//     /// @notice Speed up a village building upgrade using seeds
//     /// @param landId The ID of the land
//     /// @param buildingId The ID of the building to speed up
//     function villageSpeedUpWithSeed(uint256 landId, uint8 buildingId) public exists(landId) {
//         (uint256 speedUpCost, uint256 xp) = LibVillage._villageSpeedUpWithSeed(landId, buildingId);
//         LibXP.pushExperiencePoints(landId, xp);
//         LibPayment.paymentPayWithSeed(msg.sender, speedUpCost);
//     }

//     /// @notice Claim production from a village building
//     /// @param landId The ID of the land
//     /// @param buildingId The ID of the building to claim production from
//     function villageClaimProduction(uint256 landId, uint8 buildingId) public exists(landId) {
//         LibVillage._villageClaimProduction(landId, buildingId);
//         LibXP.pushExperiencePointsVillageClaimProduction(landId, buildingId);
//     }

// //    function townUpgradeWithLeaf(uint256 landId, uint8 buildingId) public exists(landId) {
// //        //TODO: implement actual logic to upgrade town building
// //    }
// //
// //    function townSpeedUpWithSeed(uint256 landId, uint8 buildingId) public exists(landId) {
// //        //TODO: implement actual logic to upgrade town building
// //    }
// //
// //    function claimVillageProduction(uint256 landId, uint8 buildingId) public exists(landId) {
// //        //TODO: implement actual logic to claim village production
// //    }

    







}