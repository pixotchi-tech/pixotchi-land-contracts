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
  ] as const
  
  /**
   * [__View Contract on Base Sepolia Basescan__](https://sepolia.basescan.org/address/0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba)
   */
  export const landAddress = {
    84532: '0xc7EdFFa05A3D65F340048E28d5DA06CFf1EB2Eba',
  } as const
  