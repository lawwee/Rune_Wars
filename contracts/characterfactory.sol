// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./libraries/safemath.sol";

contract CharacterFactory is Ownable {

    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    uint dnaDigits = 16;
    uint dnaModulus = dnaDigits ** 10;
    uint cooldownTime = 1 days;

    mapping (uint => address) public characterOwner;
    mapping (address => uint) public characterOwnerCount;
    mapping (string => uint) internal characterIds;

    event NewCharacter(uint characterId, string name, uint dna);

    struct Character {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
        uint256 mainExp;
        uint256 battleExp;
        uint256 totalExp;
    }

    enum Clans {Fornburg, Rygjafylke, Wulfings, Scavangar}

    Character[] public characters;

    constructor () {
        console.log("Lawwee is here again");
    }

    function _createCharacter (string memory _name, uint dna) internal {
        characters.push(Character(_name, dna, 1, uint32(block.timestamp + cooldownTime), 0, 0, 100, 50, 150));
        uint id = characters.length - 1;
        characterIds[_name] = id;
        characterOwner[id] = msg.sender;
        characterOwnerCount[msg.sender] = characterOwnerCount[msg.sender].add(1);
        emit NewCharacter(id, _name, dna);

        console.log("Name of character:", _name);
        console.log("Dna of character:", dna);
        console.log("Id of character:", id);
    }

    function _generateRandomDna(string memory _name) internal view returns(uint) {
        uint rand = uint(keccak256(abi.encodePacked(_name)));
        return rand % dnaModulus;
    }

    function createCharacter (string memory _name, Clans _clan) public {
        require(characterOwnerCount[msg.sender] == 0, "Can only create one player");      
        uint randDna = _generateRandomDna(_name);
        if (Clans.Fornburg == _clan) {
            randDna = randDna - randDna % 100 + 88; 
            console.log("This is Clan Fornburg");
        }
        if (Clans.Rygjafylke == _clan) {
            randDna = randDna - randDna % 100 + 66; 
            console.log("This is Clan Rygjafylke");
        }
        if (Clans.Wulfings == _clan) {
            randDna = randDna - randDna % 100 + 44; 
            console.log("This is Clan Wulfings");
        }
        if (Clans.Scavangar == _clan) {
            randDna = randDna - randDna % 100 + 22;
            console.log("This is Clan Scavangar");
        }
        _createCharacter(_name, randDna);
    }

}