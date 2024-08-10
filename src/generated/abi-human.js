[
  "function diamondCut(tuple(address facetAddress, uint8 action, bytes4[] functionSelectors)[] _diamondCut, address _init, bytes _calldata)",
  "function facetAddress(bytes4 _functionSelector) view returns (address facetAddress_)",
  "function facetAddresses() view returns (address[] facetAddresses_)",
  "function facetFunctionSelectors(address _facet) view returns (bytes4[] facetFunctionSelectors_)",
  "function facets() view returns (tuple(address facetAddress, bytes4[] functionSelectors)[] facets_)",
  "function initNFTFacet()",
  "function landGetBoundaries() view returns (int256 minX, int256 maxX, int256 minY, int256 maxY)",
  "function landGetCoordinates(uint256 tokenId) view returns (int256 x, int256 y, bool occupied)",
  "function landGetDiamondInitialized() view returns (bool)",
  "function landGetInitializationNumber() view returns (uint256)",
  "function landGetMaxSupply() view returns (uint256)",
  "function landGetTokenIdByCoordinates(int256 x, int256 y) view returns (uint256)",
  "function mint(uint256 quantity) payable",
  "function nftGetLandCoordinates(uint256 tokenId) view returns (int256 x, int256 y)",
  "function owner() view returns (address owner_)",
  "function supportsInterface(bytes4 interfaceId) view returns (bool)",
  "function transferOwnership(address _newOwner)",
  "event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId)",
  "event ApprovalForAll(address indexed owner, address indexed operator, bool approved)",
  "event ConsecutiveTransfer(uint256 indexed fromTokenId, uint256 toTokenId, address indexed from, address indexed to)",
  "event Transfer(address indexed from, address indexed to, uint256 indexed tokenId)",
  "event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)",
  "event DiamondCut(tuple(address facetAddress, uint8 action, bytes4[] functionSelectors)[] _diamondCut, address _init, bytes _calldata)",
  "event InitializeDiamond(address sender)",
  "error ApprovalCallerNotOwnerNorApproved()",
  "error ApprovalQueryForNonexistentToken()",
  "error BalanceQueryForZeroAddress()",
  "error MintERC2309QuantityExceedsLimit()",
  "error MintToZeroAddress()",
  "error MintZeroQuantity()",
  "error NotCompatibleWithSpotMints()",
  "error OwnerQueryForNonexistentToken()",
  "error OwnershipNotInitializedForExtraData()",
  "error SequentialMintExceedsLimit()",
  "error SequentialUpToTooSmall()",
  "error SpotMintTokenIdTooSmall()",
  "error TokenAlreadyExists()",
  "error TransferCallerNotOwnerNorApproved()",
  "error TransferFromIncorrectOwner()",
  "error TransferToNonERC721ReceiverImplementer()",
  "error TransferToZeroAddress()",
  "error URIQueryForNonexistentToken()",
  "error InvalidQueryRange()",
  "error NFTCoordinateOccupied(int256 x, int256 y)",
  "error NFTCoordinateOutOfBounds(int256 coordinate, string axis)",
  "error AlreadyInitialized(uint256 currentVersion, uint256 newVersion)",
  "error InitializationFunctionReverted(address _initializationContractAddress, bytes _calldata)"
]