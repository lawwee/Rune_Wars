// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "./characterownership.sol";
import "hardhat/console.sol";

contract NPCBattles is CharacterOwnership {

    struct NPC {
        string name;
        uint dna;
        uint256 mainExp;
    }

    NPC[] internal npcCharacters;

    constructor() CharacterOwnership () {
        console.log("This is for NPC Character creation");
    }

    function _npcCharacter (string memory _name, uint dna) internal {
        npcCharacters.push(NPC(_name, dna, 100));
        uint id = npcCharacters.length - 1;
        console.log("Id of NPC is", id);
    }

    function createNPC (uint npcId) public {
        uint randDna = _generateRandomDna("Blessing");
        randDna = randDna - randDna % 100;
        _npcCharacter("Blessing", randDna);

        NPC storage npc = npcCharacters[npcId];
        
        console.log("Name of NPC is", npc.name);
        console.log("Exp of NPC is", npc.mainExp);
    }
}