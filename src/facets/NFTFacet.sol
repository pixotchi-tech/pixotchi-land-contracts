// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

//import {LibLandStorage} from "../libs/LibLandStorage.sol";
//import {ERC721Upgradeable} from "lib_fork/ERC721-Upgradeable/contracts/ERC721Upgradeable.sol";
//import {IERC721Upgradeable} from "lib_fork/ERC721-Upgradeable/contracts/IERC721Upgradeable.sol";
//import {ERC721QueryableUpgradeable} from "lib_fork/ERC721-Upgradeable/contracts/extensions/ERC721QueryableUpgradeable.sol";
//import {LibLand} from "../libs/LibLand.sol";
import {ERC721Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
//import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";


contract NFTFacet is ERC721Upgradeable /*is ERC721Upgradeable, ERC721QueryableUpgradeable*/ {

    function initialize() initializer public {
        __ERC721_init("Land02", "LAND02");
    }

//    function initNFTFacet() external initializerERC721 {
//        __ERC721_init("Land01", "LAND01");
//        _nftMint(msg.sender, 1);
//    }
//
//
//    function mint(uint256 quantity) external {
//        _nftMint(msg.sender, quantity);
//    }
//
//    /// @notice Internal function to mint NFTs with specific coordinate assignment
//    /// @param to The address to mint the NFT to
//    /// @param quantity The number of NFTs to mint
//    function _nftMint(address to, uint256 quantity) internal {
//        uint256 supply = totalSupply();
//        require(supply + quantity <= _sN().maxSupply, "Exceeds max supply");
//
//        _mint(to, quantity);
//
//        for (uint256 i = 0; i < quantity; i++) {
//            uint256 tokenId = supply + i + 1;
//            LibLand._AssignLand(tokenId);
//        }
//    }
//
//    function _sN() internal pure returns (LibLandStorage.Data storage data) {
//        data = LibLandStorage.data();
//    }
//
//    /// ERC721 non standard functions
//
//    /// @notice Get the maximum supply of NFTs
//    /// @return The maximum supply
//    function maxSupply() external view returns (uint256) {
//        return _sN().maxSupply;
//    }
//
//    /// ERC721 Overrides

//    function totalSupply() public view virtual override returns (uint256) {
//        return super.totalSupply();
//    }

    function balanceOf(address owner) public view virtual override returns (uint256) {
        return super.balanceOf(owner);
    }

    function ownerOf(uint256 tokenId) public view virtual override returns (address) {
        return super.ownerOf(tokenId);
    }

    function name() public view virtual override returns (string memory) {
        return super.name();
    }

    function symbol() public view virtual override returns (string memory) {
        return super.symbol();
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function approve(address to, uint256 tokenId) public  virtual override {
        super.approve(to, tokenId);
    }

    function getApproved(uint256 tokenId) public view virtual override returns (address) {
        return super.getApproved(tokenId);
    }

    function setApprovalForAll(address operator, bool approved) public virtual override {
        super.setApprovalForAll(operator, approved);
    }

    function isApprovedForAll(address owner, address operator) public view virtual override returns (bool) {
        return super.isApprovedForAll(owner, operator);
    }

    function transferFrom(address from, address to, uint256 tokenId) public virtual override {
        super.transferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public virtual override {
        super.safeTransferFrom(from, to, tokenId);
    }

//    function explicitOwnershipOf(uint256 tokenId) public view virtual override returns (TokenOwnership memory) {
//        return super.explicitOwnershipOf(tokenId);
//    }
//
//    function explicitOwnershipsOf(uint256[] calldata tokenIds) public view virtual override returns (TokenOwnership[] memory) {
//        return super.explicitOwnershipsOf(tokenIds);
//    }
//
//    function tokensOfOwnerIn(address owner, uint256 start, uint256 stop) public view virtual override returns (uint256[] memory) {
//        return super.tokensOfOwnerIn(owner, start, stop);
//    }
//
//    function tokensOfOwner(address owner) public view virtual override returns (uint256[] memory) {
//        return super.tokensOfOwner(owner);
//    }


}