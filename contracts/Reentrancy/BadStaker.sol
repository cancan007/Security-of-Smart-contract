// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Bad Example
contract BadStaker {
    mapping(address => uint256) public balances;

    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(amount > balances[msg.sender]);

        (bool sent, ) = msg.sender.call{value: amount}("");  // this part
        require(sent, "Failed to send Ether");

        balances[msg.sender] -= amount;
    }
}