// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Bad Example
contract BadStaker {
    mapping(address => uint256) public balances;

    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }

    // we should use nonReentrant module, or first change vulnerables and transfer at end
    function withdraw(uint256 amount) public nonReentrant {
        require(amount > balances[msg.sender]);

        balances[msg.sender] -= amount;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");

    }
}