// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "./npcchampions.sol";

contract RuneAttack is NPCChampions {

    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    // uint rando = 0;
    // uint attackProbability = 70;

    constructor () NPCChampions() {
        console.log("For attacking em players and NPCs");
    }

    function _fight (uint _characterId, uint _targetId) internal onlyOwnerOf(_characterId) {
        require(characterOwner[_targetId] != msg.sender, "You cannot fight yourself");
        Character storage myCharacter = characters[_characterId];
        Character storage targetCharacter = characters[_targetId];
        if (myCharacter.totalExp > targetCharacter.totalExp) {
            myCharacter.totalExp = myCharacter.mainExp.add(50) + myCharacter.battleExp.add(50);
            targetCharacter.totalExp = targetCharacter.mainExp.sub(10) + targetCharacter.battleExp;
        } else {
            myCharacter.totalExp = myCharacter.mainExp.sub(10) + myCharacter.battleExp;
            targetCharacter.totalExp = targetCharacter.mainExp.add(50) + targetCharacter.battleExp.add(50);
        }
        console.log("Player Id now has %d exp", myCharacter.totalExp);
        console.log("Target Id now has %d exp", targetCharacter.totalExp);

    }

    function fightPlayer (string memory _characterId, string memory _targetId) external {
        uint characterid = characterIds[_characterId];
        uint targetid = characterIds[_targetId];        
        _fight(characterid, targetid);
    }

    function fightNPC(string memory character, string memory _name) external {
        uint npcid = npcIds[_name];
        uint characterid = characterIds[character];
        require(characterOwner[characterid] == msg.sender, "You do not own this player");

        Character storage myCharacter = characters[characterid];
        NPC storage npc = npcCharacters[npcid];

        if (myCharacter.totalExp > npc.exp) {
            myCharacter.totalExp = myCharacter.mainExp.add(50) + myCharacter.battleExp.add(50);
            console.log("You won 100 exp");
            console.log("You won a total of %d", myCharacter.totalExp);
        } else {
            console.log("You lost");
        }
    }

    // function randoMod(uint _mod) internal returns (uint) {
    //     rando = rando.add(1);
    //     return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, rando))) % _mod;
    // }

    // function fight (uint _characterId, uint _targetId) external onlyOwnerOf(_characterId) {
    //     require(characterOwner[_targetId] != msg.sender, "You cannot fight yourself");
    //     Character storage myCharacter = characters[_characterId];
    //     Character storage targetCharacter = characters[_targetId];
    //     uint rand = randoMod(100);
    //     console.log("number generated is", rand);
    //     if (rand <= attackProbability) {
    //         myCharacter.winCount = myCharacter.winCount.add(1);
    //         myCharacter.level = myCharacter.level.add(1);
    //         targetCharacter.lossCount = targetCharacter.lossCount.add(1);
    //         triggerCooldownTime(myCharacter);
    //     } else {
    //         myCharacter.lossCount = myCharacter.lossCount.add(1);
    //         targetCharacter.winCount = targetCharacter.winCount.add(1);
    //         triggerCooldownTime(myCharacter);
    //     }

    //     console.log("Player Id is has %d exp", myCharacter.mainExp);
    //     console.log("Target Id is has %d exp", targetCharacter.mainExp);
    // }
}