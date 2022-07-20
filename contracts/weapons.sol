// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "./runeattack.sol";

contract WeaponFactory is RuneAttack {

    struct Weapon {
        string name;
        uint exp;
        uint level;
    }

    Weapon[] public weapons;
    mapping (uint => address) public weaponToOwner;
    mapping (address => string[]) public characterWeapons;

    constructor () RuneAttack() {
        console.log("Let's rumble");
    }

    function firstQuest(string memory _characterId) public {
        uint characterid = characterIds[_characterId];
        require(characterOwner[characterid] == msg.sender, "You do not own this character");
        Character storage myCharacter = characters[characterid];

        uint totalExp = myCharacter.mainExp + myCharacter.battleExp;
        require(totalExp > 100, "You do not qualify for this quest");
        (bool success) = fightNPC(_characterId, "blessing");
        if (success) {
            weapons.push(Weapon("Raven's Axe", 100, 1));
            uint id = weapons.length - 1;
            weaponToOwner[id] = msg.sender;
            characterWeapons[msg.sender].push("Raven's Axe");
            console.log("You defeated the NPC");
        } else {
            console.log("try again later");
        }
    }

    function myWeapons(string memory _name) public view returns (string[] memory) {
        uint characterid = characterIds[_name];
        require(characterOwner[characterid] == msg.sender, "You do not own this character");
        address _address = characterOwner[characterid];
        console.log("successful");
        return characterWeapons[_address];
    }

}