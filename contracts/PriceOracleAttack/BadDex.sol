// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

//Solution1: Don't use less liquidity tokens
//Solution2: Be careful when you use TWAP Oracle, we recommend you Chainlink Price Feeds

contract BadDex {
    address public token1;
    address public token2;

    constructor(address _token1, address _token2){
        token1 = _token1;
        token2 = _token2;
    }

    function swap(address from, address to, uint amount) public {
        require((from == token1 && to == token2) || (from == token2 && to == token1), "Invalid tokens");
        require(IERC20(from).balanceOf(msg.sender) >= amount, "Not enough to swap");

        uint swapAmount = getSwapPrice(from, to, amount);

        IERC20(from).transferFrom(msg.sender, address(this), amount);
        IERC20(to).trasfer(msg.sender, swapAmount);
    }

    function getSwapPrice(address from, address to,uint amount) public view returns(uint){
        return(amount * IERC20(to).balanceOf(address(this)) / IERC20(from).balanceOf(address(this)));
    }

    function addLiquidity(address token_address, uint amount) public {
        IERC20(token_address).transferFrom(msg.sender, address(this), amount);
    }
}