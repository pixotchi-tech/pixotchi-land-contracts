// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/// @notice Stores context for meta-transactions
/// @dev Used for storing trusted forwarder address in EIP-2771 context
    struct MetaTxContextStorage {
        /// @notice Address of the trusted forwarder for meta-transactions
        address trustedForwarder;
    }

/// @notice Represents ownership information for a token
/// @dev Used in ERC721A for efficient storage of token ownership data. From lib_fork/ERC721A-Upgradeable/contracts/IERC721AUpgradeable.sol
    struct TokenOwnership {
        /// @notice The address of the owner
        address addr;
        /// @notice Stores the start time of ownership with minimal overhead for tokenomics
        uint64 startTimestamp;
        /// @notice Whether the token has been burned
        bool burned;
        /// @notice Arbitrary data similar to `startTimestamp` that can be set via {_extraData}
        uint24 extraData;
    }

/// @notice Represents a land parcel in the game
/// @dev This struct contains all the essential information about a land
    struct Land {
        /// @notice Unique identifier for the land
        uint256 tokenId;
        /// @notice URI for the land's metadata
        string tokenUri;
        /// @notice Timestamp of when the land was minted
        uint256 mintDate;
        /// @notice Address of the land owner
        address owner;
        /// @notice Custom name given to the land
        string name;
        /// @notice X-coordinate of the land on the game map
        uint256 coordinateX;
        /// @notice Y-coordinate of the land on the game map
        uint256 coordinateY;
        /// @notice Total experience points accumulated on this land
        uint256 experiencePoints;
        /// @notice Cumulative points earned from plants on this land
        uint256 accumulatedPlantPoints;
        /// @notice Total lifetime of all plants grown on this land
        uint256 accumulatedPlantLifetime;
    }