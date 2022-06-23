// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;


contract Bank{
    mapping( address => uint) balance;
    uint userCount;
    address owner;

    event depositMade(address _to, uint balance);
    event accountOpened(address _accountHolder);
    event balanceWithDrawan(address _accountHolder,uint256 _amount);
    event balanceTransferred(address _to, uint256 _amount);

    constructor() {
           owner=msg.sender;
    }
    modifier checkAccountExists(){
        require(balance[msg.sender]>=0,'Your account already exists');
        _;
    }
    function openAccount() checkAccountExists public returns(uint) {
        balance[msg.sender]=0;
        emit accountOpened(msg.sender);
        return balance[msg.sender];
    }
    function depositBalance(uint256 _amount) public returns(uint){
        balance[msg.sender]+=_amount;
        emit depositMade(msg.sender, balance[msg.sender]);
        return balance[msg.sender];
    }
    function withDrawBalance(uint withDrawAmount) public returns(uint){
        require(withDrawAmount <= balance[msg.sender]," You are withdrawing more amount than balance ");
        if(withDrawAmount <= balance[msg.sender]){
            balance[msg.sender]-=withDrawAmount;
        }
        emit balanceWithDrawan(msg.sender,withDrawAmount);
        return balance[msg.sender];
    }
    function transferBalance(address _to, uint256 _amount) public returns(uint) {
        require(_amount<=balance[msg.sender],'You transfering more than your current balance');
        balance[msg.sender]-=_amount;
        balance[_to]+=_amount;
        emit balanceTransferred(_to,_amount);
        return balance[_to];
    }
    function getAccountBalance() public view returns(uint){
        return balance[msg.sender];
    }

}