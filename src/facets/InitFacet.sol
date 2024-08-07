// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibNFTStorage } from "../libs/LibNFTStorage.sol";


contract InitFacet {
  event InitializeDiamond(address sender);

  function initFacet() external {
    LibNFTStorage.initializeNFTStorage();

    emit InitializeDiamond(msg.sender);
  }
}
