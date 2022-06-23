// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;


contract ledgerP{
    int price;
    string  name;
    address owner;
    string [] public users=["user1","user2","user3"];

    mapping(uint => string) public student;
    function insertStudent(uint _id, string memory _name) public {
        student[_id]=_name;
    }
    constructor(string memory _name){
        owner=msg.sender;
        name=_name;
    }
    modifier onlyOwner() {
        require(msg.sender == owner,"Only owner can call this function");
        _;

    }
    function getprice() public view onlyOwner returns (int){
        return price;
    }

    function getOwnerAddress() public view returns(address){
        return owner;
    }
    function getName() public view returns(string memory){
        return name;
    }

    function mem() public view {
        string [] memory test=users;
        test[0]="any user there";
    }
    function sto() public {
        string [] storage test=users;
        test[0]="Shamoon1";
    }
}