// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibNFTStorage } from "../libs/LibNFTStorage.sol";
//import "ERC721A-Upgradeable/ERC721AUpgradeable.sol";
import {ERC721AUpgradeable} from "lib_fork/ERC721A-Upgradeable/contracts/ERC721AUpgradeable.sol";
//import 'erc721a-upgradeable/contracts/ERC721AUpgradeable.sol';
//import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
//import "lib/ERC721A-Upgradeable/contracts/ERC721AUpgradeable.sol";

contract NFTFacet is ERC721AUpgradeable {
  // Take note of the initializer modifier_sN().
  // - `initializerERC721A` for `ERC721AUpgradeable`.
  // - `initializer` for OpenZeppelin's `OwnableUpgradeable`.
//  function initNFTFacet() initializerERC721A public {
//    __ERC721A_init("Land01", "LAND01");
//    //__Ownable_init();
//  }

  function mint(uint256 quantity) external payable {
    // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
    _nftMint(msg.sender, quantity);
  }

  /// @notice Internal function to mint NFTs with specific coordinate assignment
  /// @param to The address to mint the NFT to
  /// @param quantity The number of NFTs to mint
  function _nftMint(address to, uint256 quantity) internal {
    //LibNFTStorage.Data storage s = _sN();
    uint256 supply = totalSupply();
    require(supply + quantity <= _sN().maxSupply, "Exceeds max supply");

    _mint(to, quantity);

    for (uint256 i = 0; i < quantity; i++) {
      uint256 tokenId = supply + i;
      _assignCoordinates(tokenId);
    }
  }

  /// @notice Assigns coordinates to a newly minted token
  /// @param tokenId The ID of the token to assign coordinates to
  function _assignCoordinates(uint256 tokenId) internal {
    //LibNFTStorage.Data storage s = _sN();
    int256 x = 0;
    int256 y = 0;
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
    _sN().tokenCoordinates[tokenId] = LibNFTStorage.Coordinates(x, y, true);
    _sN().coordinateToTokenId[x][y] = tokenId;
  }

  /// @notice Public function to mint NFTs
  /// @param quantity The number of NFTs to mint
  function nftMint(uint256 quantity) external payable {
    _nftMint(msg.sender, quantity);
  }

  /// @notice Get the coordinates of a specific land token
  /// @param tokenId The ID of the token to get coordinates for
  /// @return x The x-coordinate of the land
  /// @return y The y-coordinate of the land
  function nftGetLandCoordinates(uint256 tokenId) external view returns (int256 x, int256 y) {
    //LibNFTStorage.Data storage s = _sN();
    require(_exists(tokenId), "Token does not exist");
    LibNFTStorage.Coordinates memory coords = _sN().tokenCoordinates[tokenId];
    require(coords.occupied, "Coordinates not assigned");
    return (coords.x, coords.y);
  }

  function _sN() internal pure returns (LibNFTStorage.Data storage data) {
    data = LibNFTStorage.data();
  }
}

error NFTCoordinateOutOfBounds(int256 coordinate, string axis);
error NFTCoordinateOccupied(int256 x, int256 y);