// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "./runehelper.sol";

contract RuneAttack is RuneHelper {

    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    uint rando = 0;
    uint attackProbability = 70;

    constructor () RuneHelper() {
        console.log("For attacking em players");
    }

    function randoMod(uint _mod) internal returns (uint) {
        rando = rando.add(1);
        return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, rando))) % _mod;
    }

    function _fight (uint _characterId, uint _targetId) external onlyOwnerOf(_characterId) {
        Character storage myCharacter = characters[_characterId];
        Character storage targetCharacter = characters[_targetId];
        console.log("Character Id is has %d exp", myCharacter.mainExp);
        console.log("Target Id is has %d exp", targetCharacter.mainExp);
        uint rand = randoMod(100);
        console.log("number generated is", rand);
        if (rand <= attackProbability) {
            myCharacter.mainExp = myCharacter.mainExp.add(50);
        } else {
            targetCharacter.mainExp = targetCharacter.mainExp.add(50);
        }
        console.log("Player Id now has %d exp", myCharacter.mainExp);
        console.log("Target Id now has %d exp", targetCharacter.mainExp);
    }

    function fight (uint _characterId, uint _targetId) external onlyOwnerOf(_characterId) {
        require(characterOwner[_targetId] != msg.sender, "You cannot fight yourself");
        Character storage myCharacter = characters[_characterId];
        Character storage targetCharacter = characters[_targetId];
        uint rand = randoMod(100);
        console.log("number generated is", rand);
        if (rand <= attackProbability) {
            myCharacter.winCount = myCharacter.winCount.add(1);
            myCharacter.level = myCharacter.level.add(1);
            targetCharacter.lossCount = targetCharacter.lossCount.add(1);
            triggerCooldownTime(myCharacter);
        } else {
            myCharacter.lossCount = myCharacter.lossCount.add(1);
            targetCharacter.winCount = targetCharacter.winCount.add(1);
            triggerCooldownTime(myCharacter);
        }

        console.log("Player Id is has %d exp", myCharacter.mainExp);
        console.log("Target Id is has %d exp", targetCharacter.mainExp);


    }
}