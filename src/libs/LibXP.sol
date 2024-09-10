// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibLandStorage } from "../libs/LibLandStorage.sol";
//import  "../libs/LibAppStorage.sol";
//import  "../shared/Structs.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
//import {IERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
//import {LibLandStorage} from "./LibLandStorage.sol";

library LibXP {

    // Constant for decimal precision in XP system
    uint256 private constant XP_DECIMALS = 1 ether; // 1e18

    /// @notice Converts raw XP to decimal representation
    /// @param rawXP The raw XP value
    /// @return The XP value with decimal precision
    function _toDecimalXP(uint256 rawXP) internal pure returns (uint256) {
        return rawXP * XP_DECIMALS;
    }

    /// @notice Converts decimal XP to raw representation
    /// @param decimalXP The XP value with decimal precision
    /// @return The raw XP value
    function _fromDecimalXP(uint256 decimalXP) internal pure returns (uint256) {
        return decimalXP / XP_DECIMALS;
    }

    /// @notice Internal function to access NFT storage
    /// @return data The LibLandStorage.Data struct
    function _sN() internal pure returns (LibLandStorage.Data storage data) {
        data = LibLandStorage.data();
    }


    // /// @notice Internal function to access AppStorage
    // /// @return data The AppStorage struct
    // function _sA() internal pure returns (AppStorage storage data) {
    //     data = LibAppStorage.diamondStorage();
    // }


    /// @notice Adds experience points to a land
    /// @param tokenId The ID of the token to add experience points to
    /// @param points The amount of experience points to add
    function pushExperiencePoints(uint256 tokenId, uint256 points) internal {
        // Checks
        require(IERC721(address(this)).exists(tokenId), "LibLand: Token does not exist");
        require(points > 0, "LibLand: Experience points must be greater than zero");

        // Effects
        LibLandStorage.Data storage s = _sN();
        s.experiencePoints[tokenId] += points;

    }

    // Constants for XP calculations
    uint256 private constant ETHER = 1e18;

    function getLeafUpgradeXP(uint8 level) internal pure returns (uint256) {
        if (level == 0) return 1 * ETHER;
        if (level == 1) return 2 * ETHER;
        if (level == 2) return 3 * ETHER;
        revert("Invalid level");
    }

    function getSeedSpeedUpXP(uint8 level) internal pure returns (uint256) {
        if (level == 0) return 2 * ETHER;
        if (level == 1) return 4 * ETHER;
        if (level == 2) return 6 * ETHER;
        revert("Invalid level");
    }

    /// @notice Calculates XP for leaf upgrades
    /// @param currentLevel The current level of the building
    /// @return xp The amount of XP to be awarded
    function calculateLeafUpgradeXP(uint8 currentLevel) internal pure returns (uint256 xp) {
        //require(currentLevel < 3, "LibXP: Invalid level for XP calculation");
        return getLeafUpgradeXP(currentLevel);
    }

    /// @notice Calculates XP for seed speed-ups
    /// @param currentLevel The current level of the building
    /// @return xp The amount of XP to be awarded
    function calculateSeedSpeedUpXP(uint8 currentLevel) internal pure returns (uint256 xp) {
        //require(currentLevel < 3, "LibXP: Invalid level for XP calculation");
        return getSeedSpeedUpXP(currentLevel);
    }

}

