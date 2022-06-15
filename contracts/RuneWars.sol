// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./libraries/safemath.sol";

contract PlayerFactory is Ownable {

    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    uint dnaDigits = 16;
    uint dnaModulus = dnaDigits ** 10;
    uint cooldownTime = 1 days;

    mapping (uint => address) public playerOwner;
    mapping (address => uint) public playerOwnerCount;

    event NewPlayer(uint playerId, string name, uint dna);

    struct Player {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
        uint16 winCount;
        uint16 lossCount;
    }

    Player[] public players;

    constructor () {
        console.log("Lawwee is here again");
    }

    function _createPlayer (string memory _name, uint dna) internal {
        players.push(Player(_name, dna, 1, uint32(block.timestamp + cooldownTime), 0, 0));
        uint id = players.length - 1;
        playerOwner[id] = msg.sender;
        playerOwnerCount[msg.sender] = playerOwnerCount[msg.sender].add(1);
        emit NewPlayer(id, _name, dna);

        console.log("Name of player:", _name);
        console.log("Dna of player:", dna);
        console.log("Id of player:", id);

        
    }

    function _generateRandomDna(string memory _name) private view returns(uint) {
        uint rand = uint(keccak256(abi.encodePacked(_name)));
        return rand % dnaModulus;
    }

    function createRandomPlayer (string memory _name) public {
        require(playerOwnerCount[msg.sender] == 0, "Can only create one player");
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createPlayer(_name, randDna);
    }

}