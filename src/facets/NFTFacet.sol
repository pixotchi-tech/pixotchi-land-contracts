// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

//import {LibLandStorage} from "../libs/LibLandStorage.sol";
//import {LibLand} from "../libs/LibLand.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {ERC721Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import {ERC721EnumerableUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";


contract NFTFacet is  ERC721EnumerableUpgradeable /*is ERC721Upgradeable, ERC721QueryableUpgradeable*/ {

    function initNFTFacet() external initializer  {
        __ERC721_init("Land02", "LAND02");
        _mint(msg.sender, 1);
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

    /// ERC721EnumerableUpgradeable Overrides

    function tokenOfOwnerByIndex(address owner, uint256 index) public view virtual override returns (uint256) {
        return super.tokenOfOwnerByIndex(owner, index);
    }

    function totalSupply() public view virtual override returns (uint256) {
        return super.totalSupply();
    }
    
    /// ERC721 Overrides


    function balanceOf(address owner) public view virtual override(IERC721, ERC721Upgradeable) returns (uint256) {
        return super.balanceOf(owner);
    }

    function ownerOf(uint256 tokenId) public view virtual override(IERC721, ERC721Upgradeable) returns (address) {
        return super.ownerOf(tokenId);
    }

    function name() public view virtual override(ERC721Upgradeable) returns (string memory) {
        return super.name();
    }

    function symbol() public view virtual override(ERC721Upgradeable) returns (string memory) {
        return super.symbol();
    }

    function tokenURI(uint256 tokenId) public view virtual override(ERC721Upgradeable) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function approve(address to, uint256 tokenId) public  virtual override(IERC721, ERC721Upgradeable) {
        super.approve(to, tokenId);
    }

    function getApproved(uint256 tokenId) public view virtual override(IERC721, ERC721Upgradeable) returns (address) {
        return super.getApproved(tokenId);
    }

    function setApprovalForAll(address operator, bool approved) public virtual override(IERC721, ERC721Upgradeable) {
        super.setApprovalForAll(operator, approved);
    }

    function isApprovedForAll(address owner, address operator) public view virtual override(IERC721, ERC721Upgradeable) returns (bool) {
        return super.isApprovedForAll(owner, operator);
    }

    function transferFrom(address from, address to, uint256 tokenId) public virtual override(IERC721, ERC721Upgradeable) {
        super.transferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public virtual override(IERC721, ERC721Upgradeable) {
        super.safeTransferFrom(from, to, tokenId);
    }

    
    /// @notice Returns an array of token IDs owned by a given address
    /// @param owner The address to query the tokens of
    /// @return An array of token IDs owned by the requested address
    function tokensOfOwner(address owner) public view returns (uint256[] memory) {
        return _tokensOfOwner(owner);
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