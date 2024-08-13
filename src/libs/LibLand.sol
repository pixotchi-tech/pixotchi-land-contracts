// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibLandStorage } from "../libs/LibLandStorage.sol";
import { LibAppStorage, AppStorage } from "../libs/LibAppStorage.sol";
import { LibNFT } from "../libs/LibNFT.sol";
import { Land } from "../shared/Structs.sol";



library LibLand {
    /// @notice Calculates coordinates for a given token ID
    /// @param tokenId The ID of the token to calculate coordinates for
    /// @return x The calculated X coordinate
    /// @return y The calculated Y coordinate
    function _landCalculateCoordinates(uint256 tokenId) internal pure returns (int256 x, int256 y) {
        if (tokenId == 0) {
            return (0, 0);
        }

        uint256 quadrant = (tokenId - 1) % 4;
        uint256 step = (tokenId - 1) / 4 + 1;

        if (quadrant == 0) { // Right top
            x = int256(step);
            y = int256(step);
        } else if (quadrant == 1) { // Right bottom
            x = int256(step);
            y = -int256(step);
        } else if (quadrant == 2) { // Left bottom
            x = -int256(step);
            y = -int256(step);
        } else { // Left top
            x = -int256(step);
            y = int256(step);
        }
    }

    /// @notice Assigns coordinates to a newly minted token
    /// @param tokenId The ID of the token to assign coordinates to
    function _landAssignCoordinates(uint256 tokenId) internal {
        (int256 x, int256 y) = _landCalculateCoordinates(tokenId);

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

    /// @notice Retrieves land information for a given token ID
    /// @param tokenId The ID of the token to retrieve land information for
    /// @return land The Land struct containing the land information
    function _getLand(uint256 tokenId) internal view returns (Land memory land) {
        require(LibNFT._exists(tokenId), "LibLand: Token does not exist");

        LibLandStorage.Data storage s = _sN();
        LibLandStorage.Coordinates memory coords = s.tokenCoordinates[tokenId];

        land.tokenId = tokenId;
        land.owner = LibNFT._ownerOf(tokenId);
        //TODO unify data type
        (land.coordinateX, land.coordinateY) = (uint256(int256(coords.x)), uint256(int256(coords.y)));
        land.name = s.name;
        land.experiencePoints = s.experiencePoints;
        land.accumulatedPlantPoints = s.accumulatedPlantPoints;
        land.accumulatedPlantLifetime = s.accumulatedPlantLifetime;

        // TODO
        land.tokenUri = "";
        land.mintDate = 0;
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
}

error NFTCoordinateOutOfBounds(int256 coordinate, string axis);
error NFTCoordinateOccupied(int256 x, int256 y);