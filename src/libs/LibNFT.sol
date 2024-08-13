// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {ERC721AStorage} from "lib_fork/ERC721A-Upgradeable/contracts/ERC721AStorage.sol";

library LibNFT {
    // Constants from ERC721AUpgradeable
    uint256 private constant _BITMASK_ADDRESS = (1 << 160) - 1;
    uint256 private constant _BITMASK_BURNED = 1 << 224;
    uint256 private constant _BITPOS_START_TIMESTAMP = 160;
    uint256 private constant _BITPOS_NEXT_INITIALIZED = 225;
    uint256 private constant _BITMASK_NEXT_INITIALIZED = 1 << 225;

    /**
     * @dev Returns whether `tokenId` exists.
     *
     * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
     *
     * Tokens start existing when they are minted. See {_mint}.
     */
    function _exists(uint256 tokenId) internal view returns (bool result) {
        if (_startTokenId() <= tokenId) {
            if (tokenId > _sequentialUpTo())
                return _packedOwnershipExists(ERC721AStorage.layout()._packedOwnerships[tokenId]);

            if (tokenId < ERC721AStorage.layout()._currentIndex) {
                uint256 packed;
                while ((packed = ERC721AStorage.layout()._packedOwnerships[tokenId]) == 0) --tokenId;
                result = packed & _BITMASK_BURNED == 0;
            }
        }
    }

        /**
     * @dev Returns whether `packed` represents a token that exists.
     */
    function _packedOwnershipExists(uint256 packed) private pure returns (bool result) {
        assembly {
            // The following is equivalent to `owner != address(0) && burned == false`.
            // Symbolically tested.
            result := gt(and(packed, _BITMASK_ADDRESS), and(packed, _BITMASK_BURNED))
        }
    }

        /**
     * @dev Returns the starting token ID for sequential mints.
     *
     * Override this function to change the starting token ID for sequential mints.
     *
     * Note: The value returned must never change after any tokens have been minted.
     */
    function _startTokenId() internal pure returns (uint256) {
        return 0;
    }

        /**
     * @dev Returns the maximum token ID (inclusive) for sequential mints.
     *
     * Override this function to return a value less than 2**256 - 1,
     * but greater than `_startTokenId()`, to enable spot (non-sequential) mints.
     *
     * Note: The value returned must never change after any tokens have been minted.
     */
    function _sequentialUpTo() internal pure returns (uint256) {
        return type(uint256).max;
    }


}