// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "./npccharacters.sol";

contract NPCChampions is NPCCharacters {

    constructor () NPCCharacters() {
        console.log("Champions to battle");
    }

    function ragnar() external {
        uint randDna = _generateRandomDna("Ragnar Lothbrok");
        randDna = randDna - randDna % 100;
        _npcCharacter("Ragnar Lothbrok", randDna, 70);
    } 

    function bjorn() external {
        uint randDna = _generateRandomDna("Bjorn Ironside");
        randDna = randDna - randDna % 100;
        _npcCharacter("Bjorn Ironside", randDna, 70);
    }

    function thorkell() external {
        uint randDna = _generateRandomDna("Thorkell the Tall");
        randDna = randDna - randDna % 100;
        _npcCharacter("Thorkell the Tall", randDna, 70);
    }

    function sigmund() external {
        uint randDna = _generateRandomDna("Sigmund");
        randDna = randDna - randDna % 100;
        _npcCharacter("Sigmund", randDna, 70);
    }

    function ivar() external {
        uint randDna = _generateRandomDna("Ivar the Boneless");
        randDna = randDna - randDna % 100;
        _npcCharacter("Ivar rhe Boneless", randDna, 70);
    }

    function floki() external {
        uint randDna = _generateRandomDna("Floki");
        randDna = randDna - randDna % 100;
        _npcCharacter("Floki", randDna, 70);
    }

    function askeladd() external {
        uint randDna = _generateRandomDna("Askeladd");
        randDna = randDna - randDna % 100;
        _npcCharacter("Askeladd", randDna, 70);
    }

    function ylva() external {
        uint randDna = _generateRandomDna("Ylva");
        randDna = randDna - randDna % 100;
        _npcCharacter("Ylva", randDna, 70);
    }

    function harrald() external {
        uint randDna = _generateRandomDna("Harrald");
        randDna = randDna - randDna % 100;
        _npcCharacter("Harrald", randDna, 70);
    }

    function asmund() external {
        uint randDna = _generateRandomDna("Asmund Berserkers-Slayer");
        randDna = randDna - randDna % 100;
        _npcCharacter("Asmund Berserkers-Slayer", randDna, 70);
    }

    function beowulf() external {
        uint randDna = _generateRandomDna("Beowulf");
        randDna = randDna - randDna % 100;
        _npcCharacter("Beowulf", randDna, 70);
    }

    function brunhilda() external {
        uint randDna = _generateRandomDna("Brunhilda");
        randDna = randDna - randDna % 100;
        _npcCharacter("Brunhilda", randDna, 70);
    }

    function gudmundr() external {
        uint randDna = _generateRandomDna("Gudmundr");
        randDna = randDna - randDna % 100;
        _npcCharacter("Gudmundr", randDna, 70);
    }

    function sigurd() external {
        uint randDna = _generateRandomDna("Sigurd");
        randDna = randDna - randDna % 100;
        _npcCharacter("Sigurd", randDna, 70);
    }

    function sigvaldi() external {
        uint randDna = _generateRandomDna("Sigvaldi");
        randDna = randDna - randDna % 100;
        _npcCharacter("Sigvaldi", randDna, 70);
    }

    function thorfinn() external {
        uint randDna = _generateRandomDna("Thorfinn");
        randDna = randDna - randDna % 100;
        _npcCharacter("Thorfinn", randDna, 70);
    }

    function rollo() external {
        uint randDna = _generateRandomDna("Rollo");
        randDna = randDna - randDna % 100;
        _npcCharacter("Rollo", randDna, 70);
    }

    function cnut() external {
        uint randDna = _generateRandomDna("Cnut");
        randDna = randDna - randDna % 100;
        _npcCharacter("Cnut", randDna, 70);
    }

    function lagertha() external {
        uint randDna = _generateRandomDna("Lagertha");
        randDna = randDna - randDna % 100;
        _npcCharacter("Lagertha", randDna, 70);
    }

    function halfdan() external {
        uint randDna = _generateRandomDna("Halfdan");
        randDna = randDna - randDna % 100;
        _npcCharacter("Halfdan", randDna, 70);
    }
}
