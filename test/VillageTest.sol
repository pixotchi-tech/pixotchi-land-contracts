// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import "forge-std/Test.sol";
import { TestBaseContract, console2 } from "./utils/TestBaseContract.sol";

contract VillageTest is TestBaseContract {
  function setUp() public virtual override {
    super.setUp();
  }

  function testExample() public {
    string memory e = diamond.name();
    //assertEq(e, "Hello World!", "Invalid example function");
      console.log(e);
  }
}