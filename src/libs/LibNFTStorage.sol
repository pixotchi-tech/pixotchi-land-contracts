// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import "../shared/Structs.sol";

struct NFTStorage {
    uint256 initializationNumber;
    //bool diamondInitialized;
    uint256 reentrancyStatus;
    MetaTxContextStorage metaTxContext;

    /*
    TODO: Customize storage variables here

    NOTE: Once contracts have been deployed you cannot modify the existing entries here. You can only append 
    new entries. Otherwise, any subsequent upgrades you perform will break the memory structure of your 
    deployed contracts.
    */
    //mapping(address => ERC20Token) erc20s;
    uint256 maxSupply;
    // Mappings to store coordinates for each token ID
    mapping(uint256 => int256) tokenIdToX;
    mapping(uint256 => int256) tokenIdToY;

    // Boundaries for x and y coordinates
    int256 minX;
    int256 maxX;
    int256 minY;
    int256 maxY;

}

library LibNFTStorage {
    bytes32 internal constant DIAMOND_NFT_STORAGE_POSITION = keccak256("diamond.nft.storage");

    /// @notice Returns the diamond storage for NFT-related data
    /// @return ds The NFTStorage struct
    function _nftDiamondStorage() internal pure returns (NFTStorage storage ds) {
        bytes32 position = DIAMOND_NFT_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }

    /// @notice Initializes the NFT storage with default values
    /// @dev This function can only be called once
    function initializeNFTStorage() internal initializer(1) {
        NFTStorage storage s = _nftDiamondStorage();
        s.maxSupply = 10000;
        s.minX = -50;
        s.maxX = 50;
        s.minY = -50;
        s.maxY = 50;
    }

    error AlreadyInitialized(uint256 currentVersion, uint256 newVersion);

    /// @notice Modifier to ensure initialization is done only once per version
    /// @param version The version number of the initializer
    modifier initializer(uint256 version) {
        NFTStorage storage s = _nftDiamondStorage();
        if (s.initializationNumber >= version) {
            revert AlreadyInitialized(s.initializationNumber, version);
        }
        _;
        s.initializationNumber = version;
    }
}