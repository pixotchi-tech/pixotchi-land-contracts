// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import "../shared/Structs.sol";

struct NFTStorage {
    bool diamondInitialized;
    uint256 reentrancyStatus;
    MetaTxContextStorage metaTxContext;

    /*
    TODO: Customize storage variables here

    NOTE: Once contracts have been deployed you cannot modify the existing entries here. You can only append 
    new entries. Otherwise, any subsequent upgrades you perform will break the memory structure of your 
    deployed contracts.
    */
    //mapping(address => ERC20Token) erc20s;
}

library LibNFTStorage {
    bytes32 internal constant DIAMOND_NFT_STORAGE_POSITION = keccak256("diamond.nft.storage");

    function diamondStorage() internal pure returns (NFTStorage storage ds) {
        bytes32 position = DIAMOND_NFT_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
