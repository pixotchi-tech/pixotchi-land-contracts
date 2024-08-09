// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibNFTStorage } from "../libs/LibNFTStorage.sol";

contract LandFacet {
    function _sN() internal pure returns (LibNFTStorage.Data storage data) {
        data = LibNFTStorage.data();
    }

    /// @notice Get the maximum supply of NFTs
    /// @return The maximum supply
    function landGetMaxSupply() external view returns (uint256) {
        return _sN().maxSupply;
    }

    /// @notice Get the coordinates for a specific token ID
    /// @param tokenId The ID of the token
    /// @return x The x-coordinate
    /// @return y The y-coordinate
    /// @return occupied Whether the land is occupied
    function landGetCoordinates(uint256 tokenId) external view returns (int256 x, int256 y, bool occupied) {
        LibNFTStorage.Coordinates memory coords = _sN().tokenCoordinates[tokenId];
        return (coords.x, coords.y, coords.occupied);
    }

    /// @notice Get the minimum x-coordinate
    /// @return The minimum x-coordinate
    function landGetMinX() external view returns (int256) {
        return _sN().minX;
    }

    /// @notice Get the maximum x-coordinate
    /// @return The maximum x-coordinate
    function landGetMaxX() external view returns (int256) {
        return _sN().maxX;
    }

    /// @notice Get the minimum y-coordinate
    /// @return The minimum y-coordinate
    function landGetMinY() external view returns (int256) {
        return _sN().minY;
    }

    /// @notice Get the maximum y-coordinate
    /// @return The maximum y-coordinate
    function landGetMaxY() external view returns (int256) {
        return _sN().maxY;
    }

    /// @notice Get the token ID for specific coordinates
    /// @param x The x-coordinate
    /// @param y The y-coordinate
    /// @return The token ID at the given coordinates
    function landGetTokenIdByCoordinates(int256 x, int256 y) external view returns (uint256) {
        return _sN().coordinateToTokenId[x][y];
    }
}