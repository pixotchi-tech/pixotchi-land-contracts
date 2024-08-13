// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import { LibLandStorage } from "../libs/LibLandStorage.sol";
import { LibAppStorage, AppStorage } from "../libs/LibAppStorage.sol";

contract DebugFacet {



    /// @notice Get the diamond initialization status
    /// @return Whether the diamond is initialized
    function debugGetAppDiamondInitialized() external view returns (bool) {
        return _sA().diamondInitialized;
    }

    /// @notice Get the initialization number of the NFT storage
    /// @return The initialization number
    function debugGetNftInitializationNumber() external view returns (uint256) {
        return _sN().initializationNumber;
    }


    /// @notice Internal function to access NFT storage
    /// @return data The LibLandStorage.Data struct
    function _sN() internal pure returns (LibLandStorage.Data storage data) {
        data = LibLandStorage.data();
    }

    /// @notice Internal function to access AppStorage
    /// @return data The AppStorage struct
    function _sA() internal pure returns (AppStorage storage data) {
        data = LibAppStorage.diamondStorage();
    }


}