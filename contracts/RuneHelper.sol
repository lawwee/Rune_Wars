// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "./characterfactory.sol";

contract RuneHelper is CharacterFactory {

    // uint levelUpFee = 0.001 ether;

    constructor () CharacterFactory() {
        console.log("This is for helper");
    }

    modifier onlyOwnerOf(uint _characterId) {
        require(characterOwner[_characterId] == msg.sender, "You are not the owner of this player");
        _;
    }

    function triggerCooldownTime(Character storage character) internal {
        character.readyTime = uint32(block.timestamp + cooldownTime);
    }

    function isReady(Character storage _character) internal view returns(bool) {
        return (_character.readyTime <= block.timestamp);
    }

    // function setLevelUpFee (uint _fee) external onlyOwner {
    //     levelUpFee = _fee;
    // }

    // modifier aboveLevel (uint _level, uint _characterId) {
    //     require(characters[_characterId].level >= _level, "Your level is too low to call this function");
    //     _;
    // }

    // function levelUp(uint _characterId) external payable {
    //     require(msg.value == levelUpFee);
    //     characters[_characterId].level++;
    // }

    // function changeName (uint _characterId, string calldata _newName) external aboveLevel(10, _characterId) onlyOwnerOf(_characterId) {
    //     characters[_characterId].name = _newName;
    //     console.log("Player's new name", _newName);
    // }

}