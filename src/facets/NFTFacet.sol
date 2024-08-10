// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibNFTStorage } from "../libs/LibNFTStorage.sol";
import {ERC721AUpgradeable} from "lib_fork/ERC721A-Upgradeable/contracts/ERC721AUpgradeable.sol";
import {IERC721AUpgradeable} from "lib_fork/ERC721A-Upgradeable/contracts/IERC721AUpgradeable.sol";
import {ERC721AQueryableUpgradeable} from "lib_fork/ERC721A-Upgradeable/contracts/extensions/ERC721AQueryableUpgradeable.sol";

contract NFTFacet is ERC721AUpgradeable, ERC721AQueryableUpgradeable {

    function initNFTFacet() external initializerERC721A {
    __ERC721A_init("Land01", "LAND01");
      _mint(msg.sender, 1);
    }


  function mint(uint256 quantity) external payable {
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

  // Overwritten methods from IERC721AUpgradeable

  function totalSupply() public view virtual override(ERC721AUpgradeable, IERC721AUpgradeable) returns (uint256) {
      return super.totalSupply();
  }

  function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721AUpgradeable, IERC721AUpgradeable) returns (bool) {
      return super.supportsInterface(interfaceId);
  }

  function balanceOf(address owner) public view virtual override(ERC721AUpgradeable, IERC721AUpgradeable) returns (uint256) {
      return super.balanceOf(owner);
  }

  function ownerOf(uint256 tokenId) public view virtual override(ERC721AUpgradeable, IERC721AUpgradeable) returns (address) {
      return super.ownerOf(tokenId);
  }

  function name() public view virtual override(ERC721AUpgradeable, IERC721AUpgradeable) returns (string memory) {
      return super.name();
  }

  function symbol() public view virtual override(ERC721AUpgradeable, IERC721AUpgradeable) returns (string memory) {
      return super.symbol();
  }

  function tokenURI(uint256 tokenId) public view virtual override(ERC721AUpgradeable, IERC721AUpgradeable) returns (string memory) {
      return super.tokenURI(tokenId);
  }

  function approve(address to, uint256 tokenId) public payable virtual override(ERC721AUpgradeable, IERC721AUpgradeable) {
      super.approve(to, tokenId);
  }

  function getApproved(uint256 tokenId) public view virtual override(ERC721AUpgradeable, IERC721AUpgradeable) returns (address) {
      return super.getApproved(tokenId);
  }

  function setApprovalForAll(address operator, bool approved) public virtual override(ERC721AUpgradeable, IERC721AUpgradeable) {
      super.setApprovalForAll(operator, approved);
  }

  function isApprovedForAll(address owner, address operator) public view virtual override(ERC721AUpgradeable, IERC721AUpgradeable) returns (bool) {
      return super.isApprovedForAll(owner, operator);
  }

  function transferFrom(address from, address to, uint256 tokenId) public payable virtual override(ERC721AUpgradeable, IERC721AUpgradeable) {
      super.transferFrom(from, to, tokenId);
  }

  function safeTransferFrom(address from, address to, uint256 tokenId) public payable virtual override(ERC721AUpgradeable, IERC721AUpgradeable) {
      super.safeTransferFrom(from, to, tokenId);
  }

  // function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public payable virtual {
  //     super.safeTransferFrom(from, to, tokenId, _data);
  // }

  // Overwritten methods from ERC721AQueryableUpgradeable

  function explicitOwnershipOf(uint256 tokenId) public view virtual override returns (TokenOwnership memory) {
      return super.explicitOwnershipOf(tokenId);
  }

  function explicitOwnershipsOf(uint256[] calldata tokenIds) public view virtual override returns (TokenOwnership[] memory) {
      return super.explicitOwnershipsOf(tokenIds);
  }

  function tokensOfOwnerIn(address owner, uint256 start, uint256 stop) public view virtual override returns (uint256[] memory) {
      return super.tokensOfOwnerIn(owner, start, stop);
  }

  function tokensOfOwner(address owner) public view virtual override returns (uint256[] memory) {
      return super.tokensOfOwner(owner);
  }
}

error NFTCoordinateOutOfBounds(int256 coordinate, string axis);
error NFTCoordinateOccupied(int256 x, int256 y);