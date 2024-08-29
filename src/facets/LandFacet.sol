// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {LibLandStorage} from "../libs/LibLandStorage.sol";
import {LibAppStorage, AppStorage} from "../libs/LibAppStorage.sol";
import {NFTModifiers} from "../libs/LibNFT.sol";
import {LibLand} from "../libs/LibLand.sol";
import "../shared/Structs.sol";

contract LandFacet is NFTModifiers {

    /// @notice Get the coordinates of a specific land token
    /// @param tokenId The ID of the token to get coordinates for
    /// @return x The x-coordinate of the land
    /// @return y The y-coordinate of the land
    function landGetCoordinates(uint256 tokenId) public view exists(tokenId) returns (int256 x, int256 y, bool occupied) {
        LibLandStorage.Coordinates memory coords = _sN().tokenCoordinates[tokenId];
        //require(coords.occupied, "Coordinates not assigned");
        return (coords.x, coords.y, coords.occupied);
    }

    /// @notice Get the land boundaries
    /// @return minX The minimum x-coordinate
    /// @return maxX The maximum x-coordinate
    /// @return minY The minimum y-coordinate
    /// @return maxY The maximum y-coordinate
    function landGetBoundaries() public view returns (int256 minX, int256 maxX, int256 minY, int256 maxY) {
        LibLandStorage.Data storage s = _sN();
        return (s.minX, s.maxX, s.minY, s.maxY);
    }

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

    /// @notice Get land information by token ID
    /// @param tokenId The ID of the land token
    /// @return land The Land struct containing the land information
    function landGetById(uint256 tokenId) public view exists(tokenId) returns (Land memory land) {
        return LibLand._getLand(tokenId);

    }

    /// @notice Get the token ID of a land by its coordinates
    /// @param x The x-coordinate of the land
    /// @param y The y-coordinate of the land
    /// @return tokenId The token ID of the land at the given coordinates
    function landGetTokenIdByCoordinates(int256 x, int256 y) public view returns (uint256 tokenId) {
        LibLandStorage.Data storage s = _sN();
        tokenId = s.coordinateToTokenId[x][y];
        //require(tokenId != 0, "Land not found at these coordinates");
        return tokenId;
    }


    /// @notice Get all lands owned by a specific address
    /// @param owner The address of the land owner
    /// @return lands An array of Land structs containing the land information
    function landGetByOwner(address owner) public view returns (Land[] memory lands) {
        uint256[] memory tokenIds = LibLand._getTokenIdsByOwner(owner);
        return LibLand._getLandsByIds(tokenIds);
    }

    //TODO: add authorised function to set name. And owner of land can set name. And for all the other setters
    function landSetName(uint256 tokenId, string memory name) public exists(tokenId) {
        LibLandStorage.Data storage s = _sN();
        require(bytes(name).length >= 3, "Name must be at least 3 characters");
        require(bytes(name).length <= 10, "Name must be at most 10 characters");
        s.name[tokenId] = name;
    }

    /// @notice Get an overview of lands owned by a specific address
    /// @param owner The address of the land owner
    /// @return LandOverview[] An array of LandOverview structs containing basic land information
    function landOverviewByOwner(address owner) public view returns (LandOverview[] memory) {
        uint256[] memory tokenIds = LibLand._getTokenIdsByOwner(owner);
        LandOverview[] memory overview = new LandOverview[](tokenIds.length);
        
        for (uint256 i = 0; i < tokenIds.length; i++) {
            uint256 tokenId = tokenIds[i];
            LibLandStorage.Data storage s = _sN();
            LibLandStorage.Coordinates memory coords = s.tokenCoordinates[tokenId];
            
            overview[i] = LandOverview({
                tokenId: tokenId,
                coordinateX: coords.x,
                coordinateY: coords.y,
                name: s.name[tokenId]
            });
        }
        
        return overview;
    }
//    /// @notice Get all village buildings for a given land ID
//    /// @param landId The ID of the land
//    /// @return villageBuildings An array of VillageBuilding structs containing the building information
//    function landGetVillageBuildingsByLandId(uint256 landId) public view exists(landId) returns (VillageBuilding[] memory villageBuildings) {
//        //TODO: implement actual logic to fetch from storage
//        villageBuildings = new VillageBuilding[](3);
//
//        villageBuildings[0] = VillageBuilding({
//            id: 0, // Solar
//            level: 1,
//            blockHeightUpgradeInitiated: block.number - 1000,
//            blockHeightUntilUpgradeDone: block.number + 1000,
//            accumulatedPoints: 1000,
//            accumulatedLifetime: 500,
//            isUpgrading: false,
//            levelUpgradeCostLeaf: 100,
//            levelUpgradeCostSeedInstant: 50,
//            levelUpgradeBlockInterval: 1000,
//            productionRatePlantLifetimePerBlock: 5,
//            productionRatePlantPointsPerBlock: 10,
//            maxLevel: 5,
//            claimedBlockHeight: block.number - 1000
//        });
//
//        villageBuildings[1] = VillageBuilding({
//            id: 3, // Soil Factory
//            level: 1,
//            blockHeightUpgradeInitiated: block.number - 900,
//            blockHeightUntilUpgradeDone: block.number + 900,
//            accumulatedPoints: 800,
//            accumulatedLifetime: 400,
//            isUpgrading: true,
//            levelUpgradeCostLeaf: 120,
//            levelUpgradeCostSeedInstant: 60,
//            levelUpgradeBlockInterval: 1100,
//            productionRatePlantLifetimePerBlock: 6,
//            productionRatePlantPointsPerBlock: 12,
//            maxLevel: 4,
//            claimedBlockHeight: block.number - 900
//        });
//
//        villageBuildings[2] = VillageBuilding({
//            id: 5, // Bee Farm
//            level: 2,
//            blockHeightUpgradeInitiated: block.number - 800,
//            blockHeightUntilUpgradeDone: block.number + 800,
//            accumulatedPoints: 1200,
//            accumulatedLifetime: 600,
//            isUpgrading: false,
//            levelUpgradeCostLeaf: 150,
//            levelUpgradeCostSeedInstant: 75,
//            levelUpgradeBlockInterval: 1200,
//            productionRatePlantLifetimePerBlock: 7,
//            productionRatePlantPointsPerBlock: 14,
//            maxLevel: 6,
//            claimedBlockHeight: block.number - 800
//        });
//
//        return villageBuildings;
//    }
//
//    /// @notice Get town buildings for a given land ID
//    /// @param landId The ID of the land
//    /// @return townBuildings An array of TownBuilding structs containing the building information
//    function landGetTownBuildingsByLand(uint256 landId) public view exists(landId) returns (TownBuilding[] memory townBuildings) {
//        // TODO: Implement actual logic to fetch from storage
//        townBuildings = new TownBuilding[](2);
//
//        townBuildings[0] = TownBuilding({
//            id: 1,
//            level: 1,
//            blockHeightUpgradeInitiated: block.number - 500,
//            blockHeightUntilUpgradeDone: block.number + 500,
//            isUpgrading: false,
//            levelUpgradeCostLeaf: 50,
//            levelUpgradeCostSeedInstant: 25,
//            levelUpgradeBlockInterval: 500,
//            maxLevel: 3
//        });
//
//        townBuildings[1] = TownBuilding({
//            id: 2,
//            level: 2,
//            blockHeightUpgradeInitiated: block.number - 600,
//            blockHeightUntilUpgradeDone: block.number + 400,
//            isUpgrading: true,
//            levelUpgradeCostLeaf: 75,
//            levelUpgradeCostSeedInstant: 35,
//            levelUpgradeBlockInterval: 600,
//            maxLevel: 4
//        });
//
//        return townBuildings;
//    }
//
//    function villageUpgradeWithLeaf(uint256 landId, uint8 buildingId) public exists(landId) {
//        //TODO: implement actual logic to upgrade village building
//    }
//
//    function villageSpeedUpWithSeed(uint256 landId, uint8 buildingId) public exists(landId) {
//        //TODO: implement actual logic to upgrade village building
//    }
//
//    function townUpgradeWithLeaf(uint256 landId, uint8 buildingId) public exists(landId) {
//        //TODO: implement actual logic to upgrade town building
//    }
//
//    function townSpeedUpWithSeed(uint256 landId, uint8 buildingId) public exists(landId) {
//        //TODO: implement actual logic to upgrade town building
//    }
//
//    function claimVillageProduction(uint256 landId, uint8 buildingId) public exists(landId) {
//        //TODO: implement actual logic to claim village production
//    }

    




    //     function landGetByOwnerWithBuildings(address owner) public view returns (Land[] memory lands) {
    //     uint256[] memory tokenIds = LibLand._getTokenIdsByOwner(owner);
    //     return LibLand._getLandsByIds(tokenIds);
    // }
    //get token ids from owner. get coordinates, get name by id.
    //tokens from owner.
    //land by Id. 
    // get buildings by id (one  array). two different fns for village 
    //GET VILLAGE BUILDINGS BY ID. 
    //GET TOWN BUILDINGS BY ID.

    //landSetName. Min chars 3, max chars 10.

    //BuildingVillageUpgrade(landId, buldingId);
    //BuildingTownUpgrade(landId, buldingId);


    /*
    village ids.
    0 = solar
    3 = soil factory
    5 = bee farm
    */

    /*
    farm town
    7 = farmer house / quest house.
    */

    /*
    after getLand UI has to fetch
    getVillageBuildingsByLandId
    getTownBuildingsByLandId
    */

    /*
    GetBuildingVillageType
    */

    //DONT: getTownBuildingByLandIdAndBuildingId()

    //DONT: getTownBuildingsLevelByLandId()



}