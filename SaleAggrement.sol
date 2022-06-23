// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


contract SaleAggrement{
    uint value;
    address payable public buyer;
    address payable public seller;
    enum State { created, locked, Inactive}
    State public state;

    constructor()  payable{
        seller=payable(msg.sender);
        value=msg.value;
        state=State.created;
    }
    modifier onlyBuyer(){
        require(msg.sender == buyer, "Only buyer can call this method");
        _;
    }
    modifier onlySeller(){
        require(msg.sender == seller, "Only buyer can call this method");
        _;
    }
    modifier checkState(State _state){
        require(_state == state, "Invalid state");
        _;
    }
    event Aborted();
    event confirmedPurchase();
    event ItemReceived();

    function abort() onlySeller checkState(State.created) public {
        emit Aborted();
        state=State.Inactive;
        seller.transfer(address(this).balance);
    } 

    function confirmPurchase() checkState(State.created) public payable  {
        require(msg.value == value*2, "Value must be double of purhcased items value");
        buyer=payable(msg.sender);
        emit confirmedPurchase();
        state=State.locked;
    }
    function confirmReceive() onlyBuyer checkState(State.locked) public {
        state=State.Inactive;
        emit ItemReceived();
        buyer.transfer(value);
        seller.transfer(address(this).balance);
    }

}