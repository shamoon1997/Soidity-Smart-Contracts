// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;


contract Bank{
    mapping( address => uint) balance;
    uint userCount;
    address owner;

    event depositMade(address _to, uint balance);

    constructor() payable{
        require(msg.value == 15 ether, 'Initial 15 ether required for contract to run');
        owner=msg.sender;
    }
    function openAccount() public payable returns(uint) {
        if(userCount<=3){
            balance[msg.sender]= 5 ether;
        }
        else{
            balance[msg.sender]=0 ether;
        }
        userCount++;
        return balance[msg.sender];
    }
    function depositMoney() public payable returns(uint){
        balance[msg.sender]+=msg.value;
        emit depositMade(msg.sender, balance[msg.sender]);
        return balance[msg.sender];
    }
    function withDrawMoney(uint withDrawAmount) public payable returns(uint){
        if(withDrawAmount <= balance[msg.sender]){
            balance[msg.sender]-=withDrawAmount;
            payable(msg.sender).transfer(withDrawAmount);
        }
        return balance[msg.sender];
    }
    function getAccountBalance() public view returns(uint){
        return balance[msg.sender];
    }
}