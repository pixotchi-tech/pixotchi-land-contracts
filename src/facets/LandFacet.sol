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

    /// @notice Get the land boundaries
    /// @return minX The minimum x-coordinate
    /// @return maxX The maximum x-coordinate
    /// @return minY The minimum y-coordinate
    /// @return maxY The maximum y-coordinate
    function landGetBoundaries() external view returns (int256 minX, int256 maxX, int256 minY, int256 maxY) {
        LibNFTStorage.Data storage s = _sN();
        return (s.minX, s.maxX, s.minY, s.maxY);
    }

    /// @notice Get the token ID for specific coordinates
    /// @param x The x-coordinate
    /// @param y The y-coordinate
    /// @return The token ID at the given coordinates
    function landGetTokenIdByCoordinates(int256 x, int256 y) external view returns (uint256) {
        return _sN().coordinateToTokenId[x][y];
    }
}