// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "./characterownership.sol";
import "hardhat/console.sol";

contract NPCCharacters is CharacterOwnership {

    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    struct NPC {
        string name;
        uint dna;
        uint256 mainExp;
    }

    NPC[] internal npcCharacters;

    mapping(string => uint) internal npcIds;

    constructor() CharacterOwnership () {
        console.log("This is for NPC Character creation");
    }

    function _npcCharacter (string memory _name, uint dna, uint _exp) internal {
        npcCharacters.push(NPC(_name, dna, _exp));
        uint id = npcCharacters.length - 1;
        npcIds[_name] = id;
        console.log("Id of NPC is", id);
    }

    function blessing() external {
        uint randDna = _generateRandomDna("Blessing");
        randDna = randDna - randDna % 100;
        _npcCharacter("Blessing", randDna, 10);
    }

    function another() external {
        uint randDna = _generateRandomDna("Blessing");
        randDna = randDna - randDna % 100;
        _npcCharacter("Another", randDna, 10);
    } 

//     function fight(uint _characterId, string memory _name) external {
//         Character storage myCharacter = characters[_characterId];
//         uint id = npcIds[_name];
//         NPC storage npc = npcCharacters[id];

//         if (myCharacter.mainExp > npc.mainExp) {
//             myCharacter.mainExp = myCharacter.mainExp.add(100);
//             console.log("You won 100 exp");   
//         } else {
//             console.log("You lost");
//         }
//     }

    
}