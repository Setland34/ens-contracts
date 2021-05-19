pragma solidity >=0.6.0 <0.9.0;
//import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

import "./Resolver.sol";

abstract contract INFTFuseWrapper {
    event Wrap(
        bytes32 indexed parentNode,
        string indexed label,
        address owner,
        uint96 fuses
    );

    event WrapETH2LD(bytes32 indexed labelhash, address owner, uint96 fuses);

    event Unwrap(
        bytes32 indexed parentNode,
        bytes32 indexed labelhash,
        address owner
    );

    event UnwrapETH2LD(
        bytes32 indexed labelhash,
        address registrant,
        address controller
    );

    function wrap(
        bytes32 node,
        string calldata label,
        address wrappedOwner,
        uint96 _fuses
    ) public virtual;

    function wrapETH2LD(
        string calldata label,
        address wrappedOwner,
        uint96 _fuses
    ) public virtual;

    function unwrap(
        bytes32 node,
        bytes32 label,
        address owner
    ) public virtual;

    function setSubnodeRecordAndWrap(
        bytes32 node,
        string calldata label,
        address owner,
        address resolver,
        uint64 ttl,
        uint96 _fuses
    ) public virtual returns (bytes32);

    function setSubnodeOwner(
        bytes32 node,
        bytes32 label,
        address owner
    ) public virtual returns (bytes32);

    function setSubnodeOwnerAndWrap(
        bytes32 node,
        string calldata label,
        address newOwner,
        uint96 _fuses
    ) public virtual returns (bytes32);

    function isOwnerOrApproved(bytes32 node, address addr)
        public
        virtual
        returns (bool);

    function setResolver(bytes32 node, address resolver) public virtual;

    function setTTL(bytes32 node, uint64 ttl) public virtual;

    uint96 public constant CANNOT_UNWRAP = 1;
    uint96 public constant CANNOT_BURN_FUSES = 2;
    uint96 public constant CANNOT_TRANSFER = 4;
    uint96 public constant CANNOT_SET_RESOLVER = 8;
    uint96 public constant CANNOT_SET_TTL = 16;
    uint96 public constant CANNOT_CREATE_SUBDOMAIN = 32;
    uint96 public constant CANNOT_REPLACE_SUBDOMAIN = 64;
    uint96 public constant CAN_DO_EVERYTHING = 0;
    uint96 public constant MINIMUM_PARENT_FUSES =
        CANNOT_UNWRAP | CANNOT_REPLACE_SUBDOMAIN;
}

// events for wrapping names, unwrap, setFuses
// Then log the event. parentNode, label (string), fuses, owner
