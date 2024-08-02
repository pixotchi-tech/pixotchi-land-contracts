// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

//import "ERC721A-Upgradeable/ERC721AUpgradeable.sol";
import {ERC721AUpgradeable} from "lib_fork/ERC721A-Upgradeable/contracts/ERC721AUpgradeable.sol";
//import 'erc721a-upgradeable/contracts/ERC721AUpgradeable.sol';
//import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
//import "lib/ERC721A-Upgradeable/contracts/ERC721AUpgradeable.sol";

contract ERC721Facet is ERC721AUpgradeable {
  // Take note of the initializer modifiers.
  // - `initializerERC721A` for `ERC721AUpgradeable`.
  // - `initializer` for OpenZeppelin's `OwnableUpgradeable`.
  function initialize() initializerERC721A  public {
    __ERC721A_init('Land01', 'LAND01');
    //__Ownable_init();
  }

  function mint(uint256 quantity) external payable {
    // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
    _mint(msg.sender, quantity);
  }
}
