// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibNFTStorage } from "../libs/LibNFTStorage.sol";
import { LibAppStorage, AppStorage } from "../libs/LibAppStorage.sol";
import { LibDiamond } from 'lib/diamond-2-hardhat/contracts/libraries/LibDiamond.sol';


contract InitFacet {
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

  /// @notice Modifier to ensure NFT storage is initialized only once
  /// @dev Checks if NFT storage is uninitialized, runs the function, then sets it as initialized
  modifier initializeAppStorage() {
    require(!_sA().diamondInitialized, "diamond storage already initialized");
    _;
    _sA().diamondInitialized = true;
    emit InitializeDiamond(msg.sender);

  }

  function initFacet() external initializeAppStorage {
    LibNFTStorage.initializeNFTStorage();

    _sD().supportedInterfaces[0x01ffc9a7] = true; // ERC165 interface ID for ERC165.
    _sD().supportedInterfaces[0x80ac58cd] = true;  // ERC165 interface ID for ERC721.
    _sD().supportedInterfaces[0x5b5e139f] = true; // ERC165 interface ID for ERC721Metadata.


    emit InitializeDiamond(msg.sender);
  }
}
