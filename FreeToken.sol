// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;



contract FreeToken{
    mapping(address => uint256) balance ; //setting balance for everyone
    uint totalSupply;
    address owner;
    string public name;
    string public symbol;
    uint8 public decimals;

    constructor(){
        owner=msg.sender;
        name="FreeToken";
        symbol="FT";
        decimals=10;
    }

    function setTotalSupply(uint _totalSupply) public {
        require(owner == msg.sender);
        totalSupply=_totalSupply;
    } 
    function getBalance() public view returns(uint256 _balance){
        return balance[msg.sender];
    }

    function purchase(uint _amount) public {
       balance[msg.sender]+=_amount;
       totalSupply-=_amount;
    }

    function transfer(address _to, uint256 _amount) public {
        require(balance[msg.sender] >= _amount,"Insufficient funds");
        balance[msg.sender]-=_amount;
        balance[_to]+=_amount;
    }
}