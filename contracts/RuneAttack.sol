// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

import "./RuneHelper.sol";

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

    function _fight (uint _playerId, uint _targetId) external onlyOwnerOf(_playerId) {
        require(playerOwner[_targetId] != msg.sender, "You cannot fight yourself");
        Player storage myPlayer = players[_playerId];
        Player storage targetPlayer = players[_targetId];
        uint rand = randoMod(100);
        console.log("number generated is", rand);
        if (rand <= attackProbability) {
            myPlayer.winCount = myPlayer.winCount.add(1);
            myPlayer.level = myPlayer.level.add(1);
            targetPlayer.lossCount = targetPlayer.lossCount.add(1);
            triggerCooldownTime(myPlayer);
        } else {
            myPlayer.lossCount = myPlayer.lossCount.add(1);
            targetPlayer.winCount = targetPlayer.winCount.add(1);
            triggerCooldownTime(myPlayer);
        }
        // if (myplayer.level > targetPlayer.level) {
        //     _win();
        // } else if (myPlayer.level < targetPlayer.level) {
        //     _loss();
        // }
        // triggerCooldownTime(myPlayer);
        console.log("Player details:", myPlayer.winCount);
        console.log("Player details:", myPlayer.lossCount);

    }
}