// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.9;

contract SendETH{
    address payable wallet;
    mapping(address=>uint256) public balances;
    event Purchased(address buyer, uint256 token);
    constructor(address payable _wallet) public {
        wallet=_wallet;
    }

    function buyToken() public payable  {
        balances[msg.sender]+=1;  // This is buying token
        wallet.transfer(msg.value); // This sending eth
        emit Purchased(msg.sender,1);
    }
} 