// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;

contract IterableMapping{
    mapping(address => uint256) balances;
    address [] keys;

    function insert(uint256 _balance) public {
        balances[msg.sender]=_balance;
        keys.push(msg.sender);
    }
    function getFirst() public view returns(uint256){
        return balances[keys[0]];
    }
    function getLast() public view returns(uint256){
        return balances[keys[keys.length-1]];
    }
    function getAnyValue(uint256 index) public view returns(uint256){
        return balances[keys[index]];
    }
}