// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibNFTStorage } from "../libs/LibNFTStorage.sol";
//import "ERC721A-Upgradeable/ERC721AUpgradeable.sol";
import {ERC721AUpgradeable} from "lib_fork/ERC721A-Upgradeable/contracts/ERC721AUpgradeable.sol";
//import 'erc721a-upgradeable/contracts/ERC721AUpgradeable.sol';
//import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
//import "lib/ERC721A-Upgradeable/contracts/ERC721AUpgradeable.sol";

contract NFTFacet is ERC721AUpgradeable {
  // Take note of the initializer modifiers.
  // - `initializerERC721A` for `ERC721AUpgradeable`.
  // - `initializer` for OpenZeppelin's `OwnableUpgradeable`.
  function initialize() initializerERC721A  public {
    __ERC721A_init("Land01", "LAND01");
    //__Ownable_init();
  }

  function mint(uint256 quantity) external payable {
    // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
    _mint(msg.sender, quantity);
  }

  /// @notice Internal function to mint NFTs with specific coordinate assignment
  /// @param to The address to mint the NFT to
  /// @param quantity The number of NFTs to mint
  function _nftMint(address to, uint256 quantity) internal {
    LibNFTStorage.Data storage s = _sN();
    uint256 supply = totalSupply();
    require(supply + quantity <= s.maxSupply, "Exceeds max supply");

    _mint(to, quantity);

    for (uint256 i = 0; i < quantity; i++) {
      uint256 tokenId = supply + i;
      _assignCoordinates(tokenId);
    }
  }

  /// @notice Assigns coordinates to a newly minted token
  /// @param tokenId The ID of the token to assign coordinates to
  function _assignCoordinates(uint256 tokenId) internal {
    LibNFTStorage.Data storage s = _sN();
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

    // Ensure coordinates are within bounds
    x = _clamp(x, s.minX, s.maxX);
    y = _clamp(y, s.minY, s.maxY);

    // Check if the coordinate is already occupied
    require(s.coordinateToTokenId[x][y] == 0, "Coordinate already occupied");

    // Assign coordinates
    s.tokenCoordinates[tokenId] = LibNFTStorage.Coordinates(x, y, true);
    s.coordinateToTokenId[x][y] = tokenId;
  }

  /// @notice Clamps a value between a minimum and maximum
  /// @param value The value to clamp
  /// @param min The minimum allowed value
  /// @param max The maximum allowed value
  /// @return The clamped value
  function _clamp(int256 value, int256 min, int256 max) internal pure returns (int256) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }

  /// @notice Public function to mint NFTs
  /// @param quantity The number of NFTs to mint
  function nftMint(uint256 quantity) external payable {
    _nftMint(msg.sender, quantity);
  }

  function _sN() internal pure returns (LibNFTStorage.Data storage data) {
    data = LibNFTStorage.data();
  }
}