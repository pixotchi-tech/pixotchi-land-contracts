// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibNFTStorage } from "../libs/LibNFTStorage.sol";
//import { NFTFacet } from "../facets/NFTFacet.sol";
import {ERC721AUpgradeable} from "lib_fork/ERC721A-Upgradeable/contracts/ERC721AUpgradeable.sol";


contract InitDiamond {
  event InitializeDiamond(address sender);

  function init() external {
    LibNFTStorage.initializeNFTStorage();
    //NFTFacet.initNFTFacet();

        // Initialize ERC721A
    ERC721AUpgradeable(address(this)).__ERC721A_init("Land01", "LAND01");

    emit InitializeDiamond(msg.sender);
  }
}
