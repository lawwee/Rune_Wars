//  SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "./runehelper.sol";

contract CharacterOwnership is RuneHelper {

    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;
    
    // mapping (uint => address) characterApprovals;
    
    constructor () RuneHelper() {
        console.log("Character Ownership contract");
    }

    function balanceOf(address _owner) external view returns(uint256) {
        console.log("balance of address is", characterOwnerCount[_owner]);
        return characterOwnerCount[_owner];
    }

    function ownerOf(uint256 _tokenId) external view returns(address) {
        console.log("current owner of character is", characterOwner[_tokenId]);
        return characterOwner[_tokenId];
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        require(_from == msg.sender, "You do not own this account");
        characterOwnerCount[_to] = characterOwnerCount[_to].add(1);
        characterOwnerCount[msg.sender] = characterOwnerCount[msg.sender].sub(1);
        characterOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
        console.log("new owner of character is:", characterOwner[_tokenId]);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
        require (characterOwner[_tokenId] == msg.sender, "You do not own this character");
        _transfer(_from, _to, _tokenId);
    }
}