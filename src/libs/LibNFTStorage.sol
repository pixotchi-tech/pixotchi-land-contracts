// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { MetaTxContextStorage } from "../shared/Structs.sol";

library LibNFTStorage {
    bytes32 internal constant DIAMOND_STORAGE_POSITION = keccak256("eth.pixotchi.land.nft.storage");

    /// @notice Returns the diamond storage for NFT-related data
    /// @return ds The NFTStorage struct
    function data() internal pure returns (Data storage ds) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }

    /// @notice Initializes the NFT storage with default values
    /// @dev This function can only be called once
    function initializeNFTStorage() internal initializer(1) {
        Data storage s = data();
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
        Data storage s = data();
        if (s.initializationNumber >= version) {
            revert AlreadyInitialized(s.initializationNumber, version);
        }
        _;
        s.initializationNumber = version;
    }

    struct Data {
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

        // Add these new fields
        mapping(int256 => mapping(int256 => bool)) coordinateOccupied;
    }

    /// @notice Get the X coordinate for a given token ID
    /// @param tokenId The token ID to get the X coordinate for
    /// @return x The X coordinate
    function nftGetX(uint256 tokenId) internal view returns (int256 x) {
        return data().tokenIdToX[tokenId];
    }

    /// @notice Get the Y coordinate for a given token ID
    /// @param tokenId The token ID to get the Y coordinate for
    /// @return y The Y coordinate
    function nftGetY(uint256 tokenId) internal view returns (int256 y) {
        return data().tokenIdToY[tokenId];
    }

    /// @notice Set the coordinates for a given token ID
    /// @param tokenId The token ID to set the coordinates for
    /// @param x The X coordinate
    /// @param y The Y coordinate
    function nftSetCoordinates(uint256 tokenId, int256 x, int256 y) internal {
        Data storage s = data();
        require(!s.coordinateOccupied[x][y], "Coordinate already occupied");
        s.tokenIdToX[tokenId] = x;
        s.tokenIdToY[tokenId] = y;
        s.coordinateOccupied[x][y] = true;
    }
}