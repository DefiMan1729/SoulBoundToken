// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
contract Soul1 is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    address owner;
    uint256 tokenId;
    uint256 access_code;
    constructor() ERC721("MySoul", "SOUL") {
    owner = msg.sender;
    }     
mapping (address=>uint256) public map_Accepted;    
mapping (address=>mapping(uint256=>bool)) public map_Accepted2;
mapping (address=>uint256) public map_Claimed;
mapping (address=>mapping(uint256=>uint256)) public map_Claimed2;
// mapping (address=>uint256) map_Access;
// mapping (address=>bool) map_AccessWhiteList;
event Transfer_Graph(address indexed _from, address indexed _to, uint256 _tokenid);

function assign(address _client) public {
    require(msg.sender == owner);
    tokenId = _tokenIdCounter.current();
    map_Accepted2[_client][tokenId]=true;
    map_Accepted[_client]=tokenId;
    _tokenIdCounter.increment();
}
function getAssignedTokenId(address _client) public view returns(uint256){
    return map_Accepted[_client];
}
function _beforeTokenTransfer(
        address from,
        address to,
        uint256, /* firstTokenId */
        uint256 batchSize
    ) internal override virtual{
        require (from == address(0) || to == address(0), "you are not allowed to transfer soul");
    }
function _afterTokenTransfer(
        address from,
        address to,
        uint256 firstTokenId,
        uint256 batchSize
    ) internal override virtual {
        emit Transfer_Graph(from,to,firstTokenId);
    }
function claim(string memory _uri, uint256 _tokenId) public{
    require (map_Accepted2[msg.sender][_tokenId]==true,"you are not assigned this token");
    require (map_Claimed2[msg.sender][_tokenId]==0,"you have already minted this token");   
        _safeMint(msg.sender, _tokenId);
        _setTokenURI(_tokenId, _uri);
        map_Claimed[msg.sender]=_tokenId;     
        map_Claimed2[msg.sender][_tokenId]=1;      
}
function getClaimedTokenId(address _client) public view returns(uint256){
    return map_Claimed[_client];
}
function burnMyToken(uint256 _x) public {
    require (msg.sender == ownerOf(_x), "not contract owner");
    _burn(_x);
}
function revokeToken(uint256 _x) public {
    require (msg.sender == owner, "not contract owner");
    _burn(_x);
}
function destroy() public payable {
    require(msg.sender==owner,"you are not the contract owner");
        selfdestruct(payable(msg.sender));
    }
}