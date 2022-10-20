// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7;

//Overflow: 1 + 255 = 0
//Underflow: 

contract BadStaking {
    uint public stakePeriod;

    struct StakeInfo{
        uint256 amount;
        uint256 lockedUntil;
    }

    mapping(address => StakeInfo) public staked;

    function stake() public payable{
        staked[msg.sender].amount += msg.sender;
        staked[msg.sender].lockedUntil = block.timestamp + secondsToIncrease;
    }

    function increaseLockTime(uint secondsToIncrease) public{
        staked[msg.sender].lockedUntil += secondsToIncrease;
    }

    function unstake() public{
        require(block.timestamp > staked[msg.sender].lockedUntil);

        uint amountToWithdraw = staked[msg.sender].amount;
        staked[msg.sender].amount = 0;
        staked[msg.sender].lockedUntil = 0;

        (bool success, ) = msg.sender.call{value: amountToWithdraw}("");
        require(success);
    }

    function increaseLockTime(uint secondsToIncrease)
}