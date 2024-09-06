// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import "forge-std/Test.sol";
import { TestBaseContract, console2 } from "./utils/TestBaseContract.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../src/shared/Structs.sol";  // Import the Structs file

// Mock ERC20 token contract
contract MockERC20 is ERC20 {
    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
    }
    
    function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }
}

contract VillageTest is TestBaseContract {
    MockERC20 public seedToken;
    MockERC20 public leafToken;
    address public player;

    function setUp() public virtual override {
        super.setUp();

        // Create SEED token
        seedToken = new MockERC20("SEED Token", "SEED", 21_000_000 * 10**18);
        vm.etch(0xc64F740D216B6ec49e435a8a08132529788e8DD0, address(seedToken).code);
        seedToken = MockERC20(0xc64F740D216B6ec49e435a8a08132529788e8DD0);

        // Create LEAF token
        leafToken = new MockERC20("LEAF Token", "LEAF", 79_000_000_000 * 10**18);
        vm.etch(0x33feeD5a3eD803dc03BBF4B6041bB2b86FACD6C4, address(leafToken).code);
        leafToken = MockERC20(0x33feeD5a3eD803dc03BBF4B6041bB2b86FACD6C4);

        // Approve max supply for both tokens to the diamond address
        seedToken.approve(address(diamond), seedToken.totalSupply());
        leafToken.approve(address(diamond), leafToken.totalSupply());

        // Set up a player account
        player = address(0x1234);
        vm.deal(player, 100 ether);
    }

    function testExample() public {
        string memory e = diamond.name();
        assertEq(e, "Land02", "Invalid name");
        console.log(e);
    }

    function testVillageUpgradeAndSpeedup() public {
        // Switch to the player account
        vm.startPrank(player);

        // Mint 1 million LEAF tokens to the player
        uint256 leafAmount = 1_000_000 * 10**18;
        leafToken.mint(player, leafAmount);

        // Mint 1 million SEED tokens to the player
        uint256 seedAmount = 1_000_000 * 10**18;
        seedToken.mint(player, seedAmount);

        // Approve the diamond contract to spend LEAF and SEED tokens
        leafToken.approve(address(diamond), leafAmount);
        seedToken.approve(address(diamond), seedAmount);

        // Mint a land
        diamond.mint();

        // Upgrade village building (0, 0)
        diamond.villageUpgradeWithLeaf(1, 0);

        // Advance the block number
        vm.roll(block.number + 1);

        // Speed up the upgrade
        diamond.villageSpeedUpWithSeed(1, 0);

//        // Get village buildings for the land
//        VillageBuilding[] memory buildings = diamond.villageGetVillageBuildingsByLandId(1);
//
//        // Log the buildings array
//        console.log("Number of buildings:", buildings.length);
//        for (uint i = 0; i < buildings.length; i++) {
//            VillageBuilding memory building = buildings[i];
//            console.log("Building", i);
//            console.log("  ID:", building.id);
//            console.log("  Level:", building.level);
//            console.log("  Max Level:", building.maxLevel);
//            console.log("  Is Upgrading:", building.isUpgrading);
//            console.log("  Upgrade Cost (LEAF):", building.levelUpgradeCostLeaf);
//            console.log("  Instant Upgrade Cost (SEED):", building.levelUpgradeCostSeedInstant);
//            console.log("  Upgrade Block Interval:", building.levelUpgradeBlockInterval);
//            console.log("  Production Rate (Lifetime):", building.productionRatePlantLifetimePerDay);
//            console.log("  Production Rate (Points):", building.productionRatePlantPointsPerDay);
//            console.log("  Claimed Block Height:", building.claimedBlockHeight);
//        }
//
//        // Stop impersonating the player
//        vm.stopPrank();
    }
}
