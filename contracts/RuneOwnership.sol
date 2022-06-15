//  SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "./RuneAttack.sol";

contract PlayerOwnership is RuneAttack {

    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;
    
    mapping (uint => address) playerApprovals;
    
    constructor () RuneAttack() {
        console.log("Player Ownership contract");
    }

    function balanceOf(address _owner) external view returns(uint256) {
        console.log("balance of address is", playerOwnerCount[_owner]);
        return playerOwnerCount[_owner];
    }

    function ownerOf(uint256 _tokenId) external view returns(address) {
        console.log("current owner of player is", playerOwner[_tokenId]);
        return playerOwner[_tokenId];
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        require(_from == msg.sender, "You do not own this account");
        playerOwnerCount[_to] = playerOwnerCount[_to].add(1);
        playerOwnerCount[msg.sender] = playerOwnerCount[msg.sender].sub(1);
        playerOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
        console.log("new owner of player is:", playerOwner[_tokenId]);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        require (playerOwner[_tokenId] == msg.sender, "You do not own this player");
        _transfer(_from, _to, _tokenId);
    }
}