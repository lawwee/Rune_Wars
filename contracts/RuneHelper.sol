// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "./RuneWars.sol";

contract RuneHelper is PlayerFactory {

    uint levelUpFee = 0.001 ether; 

    constructor () PlayerFactory() {
        console.log("This is for helper");
    }

    modifier onlyOwnerOf(uint _playerId) {
        require(playerOwner[_playerId] == msg.sender, "You are not the owner of this player");
        _;
    }

    function triggerCooldownTime(Player storage player) internal {
        player.readyTime = uint32(block.timestamp + cooldownTime);
    }

    function isReady(Player storage _player) internal view returns(bool) {
        return (_player.readyTime <= block.timestamp);
    }

    function setLevelUpFee (uint _fee) external onlyOwner {
        levelUpFee = _fee;
    }

    modifier aboveLevel (uint _level, uint _playerId) {
        require(players[_playerId].level >= _level, "Your level is too low to call this function");
        _;
    }

    function levelUp(uint _playerId) external payable {
        require(msg.value == levelUpFee);
        players[_playerId].level++;
    }

    function changeName (uint _playerId, string calldata _newName) external aboveLevel(10, _playerId) onlyOwnerOf(_playerId) {
        players[_playerId].name = _newName;
        console.log("Player's new name", _newName);
    }

    // function getPlayerAbilities(address _owner) external view returns (uint[] memory) {
    //     uint[] memory result = new uint[](ownerZombieCount[_owner]);
    //     // Start here
    //     uint counter = 0;
    //     for (uint i = 0; i < zombies.length; i++) {
    //         if (zombieToOwner[i] == _owner) {
    //             result[counter] = i;
    //             counter++;
    //         }
    //     }
    //     return result;
    // }

}