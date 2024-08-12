// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibNFTStorage } from "../libs/LibNFTStorage.sol";
import { LibAppStorage, AppStorage } from "../libs/LibAppStorage.sol";
import { LibDiamond } from 'lib/diamond-2-hardhat/contracts/libraries/LibDiamond.sol';

contract InitDiamond {
  event InitializeDiamond(address sender);

  /// @notice Internal function to access NFT storage
  /// @return data The LibNFTStorage.Data struct
  function _sD() internal pure returns (LibDiamond.DiamondStorage storage data) {
    data = LibDiamond.diamondStorage();
  }

  /// @notice Internal function to access NFT storage
  /// @return data The LibNFTStorage.Data struct
  function _sN() internal pure returns (LibNFTStorage.Data storage data) {
    data = LibNFTStorage.data();
  }

  /// @notice Internal function to access AppStorage
  /// @return data The AppStorage struct
  function _sA() internal pure returns (AppStorage storage data) {
    data = LibAppStorage.diamondStorage();
  }

  function init() external  {
    LibNFTStorage.initializeNFTStorage();
  }
}