// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract BadCoinFlip {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR = 3744718348473780438565737829;

    constructor() public{
        consecutiveWins = 0;
    }

    // this is not randomness, so someone can predict
    // solution: don't rely on block.timestamp or block.hash, use chainlink VRF
    function flip(bool _guess) public{
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));

        if(lastHash == blockValue){
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;
        side == _guess ? consecutiveWins++ : consecutiveWins = 0;
    }

}