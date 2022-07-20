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
    mapping (address => string) public characterClan;
    mapping (Clans => uint) public clanTotal;

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
    }

    enum Clans { Raven_Clan, Wolf_Clan, Bear_Clan, Scavangar }

    Character[] public characters;

    constructor () {
        console.log("Lawwee is here again");
    }

    function _createCharacter (string memory _name, uint dna) internal {
        characters.push(Character(_name, dna, 1, uint32(block.timestamp + cooldownTime), 0, 0, 100, 50));
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
        if (Clans.Raven_Clan == _clan) {
            characterClan[msg.sender] = "Raven's Clan";
            clanTotal[Clans.Raven_Clan] = clanTotal[Clans.Raven_Clan].add(1);
            randDna = randDna - randDna % 100 + 88; 
            console.log("This is Clan Raven's Clan");
        }
        if (Clans.Wolf_Clan == _clan) {
            characterClan[msg.sender] = "Wolf_Clan";
            clanTotal[Clans.Wolf_Clan] = clanTotal[Clans.Wolf_Clan].add(1);
            randDna = randDna - randDna % 100 + 66; 
            console.log("This is Clan Wolf_Clan");
        }
        if (Clans.Bear_Clan == _clan) {
            characterClan[msg.sender] = "Bear_Clan";
            clanTotal[Clans.Bear_Clan] = clanTotal[Clans.Bear_Clan].add(1);
            randDna = randDna - randDna % 100 + 44; 
            console.log("This is Clan Bear_Clan");
        }
        if (Clans.Scavangar == _clan) {
            characterClan[msg.sender] = "Scavangar";
            clanTotal[Clans.Scavangar] = clanTotal[Clans.Scavangar].add(1);
            randDna = randDna - randDna % 100 + 22;
            console.log("This is Clan Scavangar");
        }
        _createCharacter(_name, randDna);
    }

    function checkClan(string memory _character) public view returns (string memory) {
        address _address = characterOwner[characterIds[_character]];
        /**
         Breakdown of the above Code is as follows:
         The characterIds mapping takes the _character as argument herein returning an uint
         The charaterOwner mapping then takes the uint and is being passed as a direct argument to return the right address  
        */
        console.log("This character's clan is", characterClan[_address]);
        return characterClan[_address];
    }

    function clanNumbers (Clans _clan) public view returns (uint) {
        console.log("Total number that belongs to this clan is", clanTotal[_clan]);
        return clanTotal[_clan];
    }

}