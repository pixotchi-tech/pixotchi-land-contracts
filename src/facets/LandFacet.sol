// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {LibLandStorage} from "../libs/LibLandStorage.sol";
import {LibAppStorage, AppStorage} from "../libs/LibAppStorage.sol";
import {NFTModifiers} from "../libs/LibNFT.sol";
import {LibLand} from "../libs/LibLand.sol";
import {Land} from "../shared/Structs.sol";

contract LandFacet is NFTModifiers {

    /// @notice Get the coordinates of a specific land token
    /// @param tokenId The ID of the token to get coordinates for
    /// @return x The x-coordinate of the land
    /// @return y The y-coordinate of the land
    function landGetCoordinates(uint256 tokenId) public view exists(tokenId) returns (int256 x, int256 y) {
        LibLandStorage.Coordinates memory coords = _sN().tokenCoordinates[tokenId];
        require(coords.occupied, "Coordinates not assigned");
        return (coords.x, coords.y);
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
//
//    /// @notice Get all lands owned by a specific address
//    /// @param owner The address of the land owner
//    /// @return lands An array of Land structs containing the land information
//    function landGetByOwner(address owner) public view returns (Land[] memory lands) {
//        return LibLand._getLandsByOwner(owner);
//    }

}