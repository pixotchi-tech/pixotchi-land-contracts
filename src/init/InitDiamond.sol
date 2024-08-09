// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibNFTStorage } from "../libs/LibNFTStorage.sol";

contract InitDiamond {
  event InitializeDiamond(address sender);

  function init() external {
    LibNFTStorage.initializeNFTStorage();

    emit InitializeDiamond(msg.sender);
  }
}