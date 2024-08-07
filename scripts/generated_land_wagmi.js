import {
  createReadContract,
  createWriteContract,
  createSimulateContract,
  createWatchContractEvent,
} from '@wagmi/core/codegen'

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Land
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const landAbi = [
  {
    type: 'function',
    inputs: [
      {
        name: '_diamondCut',
        internalType: 'struct IDiamondCut.FacetCut[]',
        type: 'tuple[]',
        components: [
          { name: 'facetAddress', internalType: 'address', type: 'address' },
          {
            name: 'action',
            internalType: 'enum IDiamondCut.FacetCutAction',
            type: 'uint8',
          },
          {
            name: 'functionSelectors',
            internalType: 'bytes4[]',
            type: 'bytes4[]',
          },
        ],
      },
      { name: '_init', internalType: 'address', type: 'address' },
      { name: '_calldata', internalType: 'bytes', type: 'bytes' },
    ],
    name: 'diamondCut',
    outputs: [],
    stateMutability: 'nonpayable',
  },
  {
    type: 'function',
    inputs: [
      { name: '_functionSelector', internalType: 'bytes4', type: 'bytes4' },
    ],
    name: 'facetAddress',
    outputs: [
      { name: 'facetAddress_', internalType: 'address', type: 'address' },
    ],
    stateMutability: 'view',
  },
  {
    type: 'function',
    inputs: [],
    name: 'facetAddresses',
    outputs: [
      { name: 'facetAddresses_', internalType: 'address[]', type: 'address[]' },
    ],
    stateMutability: 'view',
  },
  {
    type: 'function',
    inputs: [{ name: '_facet', internalType: 'address', type: 'address' }],
    name: 'facetFunctionSelectors',
    outputs: [
      {
        name: 'facetFunctionSelectors_',
        internalType: 'bytes4[]',
        type: 'bytes4[]',
      },
    ],
    stateMutability: 'view',
  },
  {
    type: 'function',
    inputs: [],
    name: 'facets',
    outputs: [
      {
        name: 'facets_',
        internalType: 'struct IDiamondLoupe.Facet[]',
        type: 'tuple[]',
        components: [
          { name: 'facetAddress', internalType: 'address', type: 'address' },
          {
            name: 'functionSelectors',
            internalType: 'bytes4[]',
            type: 'bytes4[]',
          },
        ],
      },
    ],
    stateMutability: 'view',
  },
  {
    type: 'function',
    inputs: [],
    name: 'init',
    outputs: [],
    stateMutability: 'nonpayable',
  },
  {
    type: 'function',
    inputs: [{ name: 'quantity', internalType: 'uint256', type: 'uint256' }],
    name: 'mint',
    outputs: [],
    stateMutability: 'payable',
  },
  {
    type: 'function',
    inputs: [{ name: 'tokenId', internalType: 'uint256', type: 'uint256' }],
    name: 'nftGetLandCoordinates',
    outputs: [
      { name: 'x', internalType: 'int256', type: 'int256' },
      { name: 'y', internalType: 'int256', type: 'int256' },
    ],
    stateMutability: 'view',
  },
  {
    type: 'function',
    inputs: [{ name: 'quantity', internalType: 'uint256', type: 'uint256' }],
    name: 'nftMint',
    outputs: [],
    stateMutability: 'payable',
  },
  {
    type: 'function',
    inputs: [],
    name: 'owner',
    outputs: [{ name: 'owner_', internalType: 'address', type: 'address' }],
    stateMutability: 'view',
  },
  {
    type: 'function',
    inputs: [{ name: 'interfaceId', internalType: 'bytes4', type: 'bytes4' }],
    name: 'supportsInterface',
    outputs: [{ name: '', internalType: 'bool', type: 'bool' }],
    stateMutability: 'view',
  },
  {
    type: 'function',
    inputs: [{ name: '_newOwner', internalType: 'address', type: 'address' }],
    name: 'transferOwnership',
    outputs: [],
    stateMutability: 'nonpayable',
  },
  {
    type: 'event',
    anonymous: false,
    inputs: [
      {
        name: 'sender',
        internalType: 'address',
        type: 'address',
        indexed: false,
      },
    ],
    name: 'InitializeDiamond',
  },
  {
    type: 'event',
    anonymous: false,
    inputs: [
      {
        name: 'previousOwner',
        internalType: 'address',
        type: 'address',
        indexed: true,
      },
      {
        name: 'newOwner',
        internalType: 'address',
        type: 'address',
        indexed: true,
      },
    ],
    name: 'OwnershipTransferred',
  },
  {
    type: 'event',
    anonymous: false,
    inputs: [
      {
        name: 'owner',
        internalType: 'address',
        type: 'address',
        indexed: true,
      },
      {
        name: 'approved',
        internalType: 'address',
        type: 'address',
        indexed: true,
      },
      {
        name: 'tokenId',
        internalType: 'uint256',
        type: 'uint256',
        indexed: true,
      },
    ],
    name: 'Approval',
  },
  {
    type: 'event',
    anonymous: false,
    inputs: [
      {
        name: 'owner',
        internalType: 'address',
        type: 'address',
        indexed: true,
      },
      {
        name: 'operator',
        internalType: 'address',
        type: 'address',
        indexed: true,
      },
      { name: 'approved', internalType: 'bool', type: 'bool', indexed: false },
    ],
    name: 'ApprovalForAll',
  },
  {
    type: 'event',
    anonymous: false,
    inputs: [
      {
        name: 'fromTokenId',
        internalType: 'uint256',
        type: 'uint256',
        indexed: true,
      },
      {
        name: 'toTokenId',
        internalType: 'uint256',
        type: 'uint256',
        indexed: false,
      },
      { name: 'from', internalType: 'address', type: 'address', indexed: true },
      { name: 'to', internalType: 'address', type: 'address', indexed: true },
    ],
    name: 'ConsecutiveTransfer',
  },
  {
    type: 'event',
    anonymous: false,
    inputs: [
      { name: 'from', internalType: 'address', type: 'address', indexed: true },
      { name: 'to', internalType: 'address', type: 'address', indexed: true },
      {
        name: 'tokenId',
        internalType: 'uint256',
        type: 'uint256',
        indexed: true,
      },
    ],
    name: 'Transfer',
  },
  {
    type: 'event',
    anonymous: false,
    inputs: [
      {
        name: '_diamondCut',
        internalType: 'struct IDiamondCut.FacetCut[]',
        type: 'tuple[]',
        components: [
          { name: 'facetAddress', internalType: 'address', type: 'address' },
          {
            name: 'action',
            internalType: 'enum IDiamondCut.FacetCutAction',
            type: 'uint8',
          },
          {
            name: 'functionSelectors',
            internalType: 'bytes4[]',
            type: 'bytes4[]',
          },
        ],
        indexed: false,
      },
      {
        name: '_init',
        internalType: 'address',
        type: 'address',
        indexed: false,
      },
      {
        name: '_calldata',
        internalType: 'bytes',
        type: 'bytes',
        indexed: false,
      },
    ],
    name: 'DiamondCut',
  },
  {
    type: 'error',
    inputs: [
      { name: 'currentVersion', internalType: 'uint256', type: 'uint256' },
      { name: 'newVersion', internalType: 'uint256', type: 'uint256' },
    ],
    name: 'AlreadyInitialized',
  },
  { type: 'error', inputs: [], name: 'ApprovalCallerNotOwnerNorApproved' },
  { type: 'error', inputs: [], name: 'ApprovalQueryForNonexistentToken' },
  { type: 'error', inputs: [], name: 'BalanceQueryForZeroAddress' },
  { type: 'error', inputs: [], name: 'MintERC2309QuantityExceedsLimit' },
  { type: 'error', inputs: [], name: 'MintToZeroAddress' },
  { type: 'error', inputs: [], name: 'MintZeroQuantity' },
  {
    type: 'error',
    inputs: [
      { name: 'x', internalType: 'int256', type: 'int256' },
      { name: 'y', internalType: 'int256', type: 'int256' },
    ],
    name: 'NFTCoordinateOccupied',
  },
  {
    type: 'error',
    inputs: [
      { name: 'coordinate', internalType: 'int256', type: 'int256' },
      { name: 'axis', internalType: 'string', type: 'string' },
    ],
    name: 'NFTCoordinateOutOfBounds',
  },
  { type: 'error', inputs: [], name: 'NotCompatibleWithSpotMints' },
  { type: 'error', inputs: [], name: 'OwnerQueryForNonexistentToken' },
  { type: 'error', inputs: [], name: 'OwnershipNotInitializedForExtraData' },
  { type: 'error', inputs: [], name: 'SequentialMintExceedsLimit' },
  { type: 'error', inputs: [], name: 'SequentialUpToTooSmall' },
  { type: 'error', inputs: [], name: 'SpotMintTokenIdTooSmall' },
  { type: 'error', inputs: [], name: 'TokenAlreadyExists' },
  { type: 'error', inputs: [], name: 'TransferCallerNotOwnerNorApproved' },
  { type: 'error', inputs: [], name: 'TransferFromIncorrectOwner' },
  { type: 'error', inputs: [], name: 'TransferToNonERC721ReceiverImplementer' },
  { type: 'error', inputs: [], name: 'TransferToZeroAddress' },
  { type: 'error', inputs: [], name: 'URIQueryForNonexistentToken' },
  {
    type: 'error',
    inputs: [
      {
        name: '_initializationContractAddress',
        internalType: 'address',
        type: 'address',
      },
      { name: '_calldata', internalType: 'bytes', type: 'bytes' },
    ],
    name: 'InitializationFunctionReverted',
  },
]

/**
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const landAddress = {
  84532: '0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba',
}

/**
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const landConfig = { address: landAddress, abi: landAbi }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Action
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Wraps __{@link readContract}__ with `abi` set to __{@link landAbi}__
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const readLand = /*#__PURE__*/ createReadContract({
  abi: landAbi,
  address: landAddress,
})

/**
 * Wraps __{@link readContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"facetAddress"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const readLandFacetAddress = /*#__PURE__*/ createReadContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'facetAddress',
})

/**
 * Wraps __{@link readContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"facetAddresses"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const readLandFacetAddresses = /*#__PURE__*/ createReadContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'facetAddresses',
})

/**
 * Wraps __{@link readContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"facetFunctionSelectors"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const readLandFacetFunctionSelectors = /*#__PURE__*/ createReadContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'facetFunctionSelectors',
})

/**
 * Wraps __{@link readContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"facets"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const readLandFacets = /*#__PURE__*/ createReadContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'facets',
})

/**
 * Wraps __{@link readContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"nftGetLandCoordinates"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const readLandNftGetLandCoordinates = /*#__PURE__*/ createReadContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'nftGetLandCoordinates',
})

/**
 * Wraps __{@link readContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"owner"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const readLandOwner = /*#__PURE__*/ createReadContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'owner',
})

/**
 * Wraps __{@link readContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"supportsInterface"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const readLandSupportsInterface = /*#__PURE__*/ createReadContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'supportsInterface',
})

/**
 * Wraps __{@link writeContract}__ with `abi` set to __{@link landAbi}__
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const writeLand = /*#__PURE__*/ createWriteContract({
  abi: landAbi,
  address: landAddress,
})

/**
 * Wraps __{@link writeContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"diamondCut"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const writeLandDiamondCut = /*#__PURE__*/ createWriteContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'diamondCut',
})

/**
 * Wraps __{@link writeContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"init"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const writeLandInit = /*#__PURE__*/ createWriteContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'init',
})

/**
 * Wraps __{@link writeContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"mint"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const writeLandMint = /*#__PURE__*/ createWriteContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'mint',
})

/**
 * Wraps __{@link writeContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"nftMint"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const writeLandNftMint = /*#__PURE__*/ createWriteContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'nftMint',
})

/**
 * Wraps __{@link writeContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"transferOwnership"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const writeLandTransferOwnership = /*#__PURE__*/ createWriteContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'transferOwnership',
})

/**
 * Wraps __{@link simulateContract}__ with `abi` set to __{@link landAbi}__
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const simulateLand = /*#__PURE__*/ createSimulateContract({
  abi: landAbi,
  address: landAddress,
})

/**
 * Wraps __{@link simulateContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"diamondCut"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const simulateLandDiamondCut = /*#__PURE__*/ createSimulateContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'diamondCut',
})

/**
 * Wraps __{@link simulateContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"init"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const simulateLandInit = /*#__PURE__*/ createSimulateContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'init',
})

/**
 * Wraps __{@link simulateContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"mint"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const simulateLandMint = /*#__PURE__*/ createSimulateContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'mint',
})

/**
 * Wraps __{@link simulateContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"nftMint"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const simulateLandNftMint = /*#__PURE__*/ createSimulateContract({
  abi: landAbi,
  address: landAddress,
  functionName: 'nftMint',
})

/**
 * Wraps __{@link simulateContract}__ with `abi` set to __{@link landAbi}__ and `functionName` set to `"transferOwnership"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const simulateLandTransferOwnership =
  /*#__PURE__*/ createSimulateContract({
    abi: landAbi,
    address: landAddress,
    functionName: 'transferOwnership',
  })

/**
 * Wraps __{@link watchContractEvent}__ with `abi` set to __{@link landAbi}__
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const watchLandEvent = /*#__PURE__*/ createWatchContractEvent({
  abi: landAbi,
  address: landAddress,
})

/**
 * Wraps __{@link watchContractEvent}__ with `abi` set to __{@link landAbi}__ and `eventName` set to `"InitializeDiamond"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const watchLandInitializeDiamondEvent =
  /*#__PURE__*/ createWatchContractEvent({
    abi: landAbi,
    address: landAddress,
    eventName: 'InitializeDiamond',
  })

/**
 * Wraps __{@link watchContractEvent}__ with `abi` set to __{@link landAbi}__ and `eventName` set to `"OwnershipTransferred"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const watchLandOwnershipTransferredEvent =
  /*#__PURE__*/ createWatchContractEvent({
    abi: landAbi,
    address: landAddress,
    eventName: 'OwnershipTransferred',
  })

/**
 * Wraps __{@link watchContractEvent}__ with `abi` set to __{@link landAbi}__ and `eventName` set to `"Approval"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const watchLandApprovalEvent = /*#__PURE__*/ createWatchContractEvent({
  abi: landAbi,
  address: landAddress,
  eventName: 'Approval',
})

/**
 * Wraps __{@link watchContractEvent}__ with `abi` set to __{@link landAbi}__ and `eventName` set to `"ApprovalForAll"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const watchLandApprovalForAllEvent =
  /*#__PURE__*/ createWatchContractEvent({
    abi: landAbi,
    address: landAddress,
    eventName: 'ApprovalForAll',
  })

/**
 * Wraps __{@link watchContractEvent}__ with `abi` set to __{@link landAbi}__ and `eventName` set to `"ConsecutiveTransfer"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const watchLandConsecutiveTransferEvent =
  /*#__PURE__*/ createWatchContractEvent({
    abi: landAbi,
    address: landAddress,
    eventName: 'ConsecutiveTransfer',
  })

/**
 * Wraps __{@link watchContractEvent}__ with `abi` set to __{@link landAbi}__ and `eventName` set to `"Transfer"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const watchLandTransferEvent = /*#__PURE__*/ createWatchContractEvent({
  abi: landAbi,
  address: landAddress,
  eventName: 'Transfer',
})

/**
 * Wraps __{@link watchContractEvent}__ with `abi` set to __{@link landAbi}__ and `eventName` set to `"DiamondCut"`
 *
 * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
 */
export const watchLandDiamondCutEvent = /*#__PURE__*/ createWatchContractEvent({
  abi: landAbi,
  address: landAddress,
  eventName: 'DiamondCut',
})
