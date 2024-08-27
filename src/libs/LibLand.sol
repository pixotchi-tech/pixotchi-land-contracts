// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibLandStorage } from "../libs/LibLandStorage.sol";
import { LibAppStorage, AppStorage } from "../libs/LibAppStorage.sol";
import { Land, Building, BuildingType } from "../shared/Structs.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
import {LibLandBuildingStorage} from "./LibLandBuildingStorage.sol";

/// @title LibLand
/// @notice A library for managing land-related operations in the Pixotchi game
library LibLand {

    /// @notice Generates coordinates for a given token ID using a quadrant spiral algorithm
    /// @dev This function implements a spiral pattern starting from (0,0) and moving outwards.
    ///      It uses a clockwise spiral pattern to assign unique coordinates to each token ID.
    ///      The spiral starts by moving right, then down, left, and up, repeating this pattern
    ///      with increasing step sizes. This ensures that each token ID gets a unique coordinate
    ///      pair, creating a spiral-like distribution of land plots around the center.
    /// @param tokenId The ID of the token to calculate coordinates for
    /// @return x The calculated X coordinate
    /// @return y The calculated Y coordinate
    function landCalculateCoordinatesQuadrantSpiral(uint256 tokenId) public pure returns (int256 x, int256 y) {
        /// @notice Check if the token ID is 0, which represents the center of the spiral
        if (tokenId == 0) {
            return (0, 0);
        }

        /// @notice Define the four directions for the spiral: right, down, left, up
        int256[2][4] memory directions = [
            [int256(0), int256(1)],
            [int256(1), int256(0)],
            [int256(0), int256(-1)],
            [int256(-1), int256(0)]
        ];

        /// @notice Initialize the direction index to 0 (starting with moving right)
        uint256 directionIndex = 0;

        /// @notice Initialize the number of steps to take in the current direction
        uint256 stepsInThisDirection = 1;

        /// @notice Initialize the counter for steps taken in the current direction
        uint256 stepsCount = 0;

        /// @notice Iterate through the spiral pattern for the given token ID
        for (uint256 i = 0; i < tokenId; i++) {
            /// @notice Get the current direction's X and Y components
            int256 dx = directions[directionIndex][0];
            int256 dy = directions[directionIndex][1];

            /// @notice Update the X and Y coordinates based on the current direction
            x += dx;
            y += dy;

            /// @notice Increment the steps taken in the current direction
            stepsCount++;

            /// @notice Check if we've taken all steps in the current direction
            if (stepsCount == stepsInThisDirection) {
                /// @notice Change to the next direction (clockwise)
                directionIndex = (directionIndex + 1) % 4;

                /// @notice Reset the step counter for the new direction
                stepsCount = 0;

                /// @notice Increase the number of steps every two direction changes
                if (directionIndex % 2 == 0) {
                    stepsInThisDirection++;
                }
            }
        }

        /// @notice Return the final calculated X and Y coordinates
        return (x, y);
    }

    /// @notice Assigns coordinates to a newly minted token
    /// @param tokenId The ID of the token to assign coordinates to
    function _landAssignCoordinates(uint256 tokenId) private {
        (int256 x, int256 y) = landCalculateCoordinatesQuadrantSpiral(tokenId);

        // Ensure coordinates are within bounds using custom errors
        if (x < _sN().minX || x > _sN().maxX) {
            revert NFTCoordinateOutOfBounds(x, "X");
        }
        if (y < _sN().minY || y > _sN().maxY) {
            revert NFTCoordinateOutOfBounds(y, "Y");
        }

        // Check if the coordinate is already occupied
        if (_sN().coordinateToTokenId[x][y] != 0) {
            revert NFTCoordinateOccupied(x, y);
        }

        // Assign coordinates
        _sN().tokenCoordinates[tokenId] = LibLandStorage.Coordinates(x, y, true);
        _sN().coordinateToTokenId[x][y] = tokenId;
    }

    /// @notice Assigns coordinates and mint date to a newly minted token
    /// @param tokenId The ID of the token to assign land to
    function _AssignLand(uint256 tokenId) internal {
        _landAssignCoordinates(tokenId);
        _sN().mintDate[tokenId] = block.timestamp;
    }

    /// @notice Retrieves the buildings in a village for a given token ID
    /// @param tokenId The ID of the token to retrieve village buildings for
    /// @return An array of Building structs representing the village buildings
    function _getVillageBuildings(uint256 tokenId) internal view returns (Building[] memory) {
        require(IERC721(address(this)).exists(tokenId), "LibLand: Token does not exist");

        LibLandBuildingStorage.Data storage s = _sNB();

        LibLandBuildingStorage.Building[] storage storageBuildings = s.villageBuildings[tokenId];
        uint256 buildingCount = storageBuildings.length;

        Building[] memory buildings = new Building[](buildingCount);

        for (uint256 i = 0; i < buildingCount; i++) {
            uint256 accumulatedPoints = 0; //TODO, on chain calculation based on BuildingType points production rate
            uint256 accumulatedLifetime = 0; //TODO, on chain calculation based on BuildingType lifetime production rate
            
            buildings[i] = Building({
                id: storageBuildings[i].id,
                level: storageBuildings[i].level,
                blockHeightUpgradeInitiated: storageBuildings[i].blockHeightUpgradeInitiated,
                blockHeightUntilUpgradeDone: storageBuildings[i].blockHeightUntilUpgradeDone,
                accumulatedPoints: accumulatedPoints,
                accumulatedLifetime: accumulatedLifetime
            });
        }

        return buildings;
    }

    // /// @notice Retrieves the buildings in a town for a given token ID
    // /// @param tokenId The ID of the token to retrieve town buildings for
    // /// @return An array of Building structs representing the town buildings
    // function _getTownBuildings(uint256 tokenId) internal view returns (Building[] memory) {
    //     require(IERC721(address(this)).exists(tokenId), "LibLand: Token does not exist");

    //     LibLandBuildingStorage.Data storage s = _sNB();

    //     return s.townBuildings[tokenId];
    // }

    /// @notice Retrieves land information for a given token ID
    /// @param tokenId The ID of the token to retrieve land information for
    /// @return land The Land struct containing the land information
    function _getLand(uint256 tokenId) internal view returns (Land memory land) {
        require(IERC721(address(this)).exists(tokenId), "LibLand: Token does not exist");

        LibLandStorage.Data storage s = _sN();
        LibLandStorage.Coordinates memory coords = s.tokenCoordinates[tokenId];

        land.tokenId = tokenId;
        land.owner = IERC721(address(this)).ownerOf(tokenId);
        (land.coordinateX, land.coordinateY) = (coords.x, coords.y);
        land.name = s.name[tokenId];
        land.experiencePoints = s.experiencePoints[tokenId];
        land.accumulatedPlantPoints = s.accumulatedPlantPoints[tokenId];
        land.accumulatedPlantLifetime = s.accumulatedPlantLifetime[tokenId];


        land.tokenUri = ""; // TODO
        land.mintDate = s.mintDate[tokenId];

        return land;
    }

    /// @notice Retrieves all lands owned by a specific address
    /// @param owner The address of the land owner
    /// @return lands An array of Land structs containing the land information
    function _getLandsByOwner(address owner) internal view returns (Land[] memory lands) {
        uint256 balance = IERC721(address(this)).balanceOf(owner);
        lands = new Land[](balance);

        uint256 landCount = 0;
        uint256 totalSupply = IERC721Enumerable(address(this)).totalSupply();

        for (uint256 tokenId = 1; tokenId <= totalSupply && landCount < balance; tokenId++) {
            if (IERC721(address(this)).ownerOf(tokenId) == owner) {
                lands[landCount] = _getLand(tokenId);
                landCount++;
            }
        }
    }

    /// @notice Internal function to access NFT storage
    /// @return data The LibLandStorage.Data struct
    function _sN() internal pure returns (LibLandStorage.Data storage data) {
        data = LibLandStorage.data();
    }

    /// @notice Internal function to access NFT Building storage
    /// @return data The LibLandBuildingStorage.Data struct
    function _sNB() internal pure returns (LibLandBuildingStorage.Data storage data) {
        data = LibLandBuildingStorage.data();
    }

    /// @notice Internal function to access AppStorage
    /// @return data The AppStorage struct
    function _sA() internal pure returns (AppStorage storage data) {
        data = LibAppStorage.diamondStorage();
    }


}

/// @notice Error thrown when a coordinate is out of the allowed bounds
/// @param coordinate The coordinate value that is out of bounds
/// @param axis The axis (X or Y) of the out-of-bounds coordinate
error NFTCoordinateOutOfBounds(int256 coordinate, string axis);

/// @notice Error thrown when trying to assign a coordinate that is already occupied
/// @param x The X coordinate that is occupied
/// @param y The Y coordinate that is occupied
error NFTCoordinateOccupied(int256 x, int256 y);