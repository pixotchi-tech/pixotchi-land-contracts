// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibNFTStorage } from "../libs/LibNFTStorage.sol";
import { NFTFacet } from "../facets/NFTFacet.sol";
import {ERC721AStorage} from "lib_fork/ERC721A-Upgradeable/contracts/ERC721AStorage.sol";

contract InitDiamond {
  event InitializeDiamond(address sender);

  function init() external {
    LibNFTStorage.initializeNFTStorage();
    
    // Start initializing ERC721A
    ERC721A__InitializableStorage.Layout storage initializableLayout = ERC721A__InitializableStorage.layout();
    require(!initializableLayout._initialized, "ERC721A: already initialized");
    initializableLayout._initializing = true;

    // Initialize ERC721A
    _initializeERC721A("Land01", "LAND01");

    // Finish initializing ERC721A
    initializableLayout._initializing = false;
    initializableLayout._initialized = true;

    emit InitializeDiamond(msg.sender);
  }

  function _initializeERC721A(string memory name_, string memory symbol_) internal onlyInitializingERC721A {
    __ERC721A_init_unchained(name_, symbol_);
  }

  function __ERC721A_init_unchained(string memory name_, string memory symbol_) internal onlyInitializingERC721A {
    ERC721AStorage.Layout storage layout = ERC721AStorage.layout();
    layout._name = name_;
    layout._symbol = symbol_;
    layout._currentIndex = _startTokenId();

    if (_sequentialUpTo() < _startTokenId()) revert SequentialUpToTooSmall();
  }

  function _startTokenId() internal pure returns (uint256) {
    return 1;
  }

  function _sequentialUpTo() internal pure returns (uint256) {
    return type(uint256).max;
  }

  /**
   * @dev Modifier to protect an initialization function so that it can only be invoked by functions with the
   * {initializer} modifier, directly or indirectly.
   */
  modifier onlyInitializingERC721A() {
    require(
      ERC721A__InitializableStorage.layout()._initializing,
      'ERC721A__Initializable: contract is not initializing'
    );
    _;
  }
}

library ERC721A__InitializableStorage {
  struct Layout {
    bool _initialized;
    bool _initializing;
  }

  bytes32 internal constant STORAGE_SLOT = keccak256('ERC721A.contracts.storage.initializable.facet');

  function layout() internal pure returns (Layout storage l) {
    bytes32 slot = STORAGE_SLOT;
    assembly {
      l.slot := slot
    }
  }
}
error SequentialUpToTooSmall();
