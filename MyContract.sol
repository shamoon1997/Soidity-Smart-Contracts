// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.9;


contract MyContract{
    // enum State { Waiting, Ready, Active }
    // State public state;
    // function setState() public {
    //     state=State.Ready;
    // }
    // function checkState() public view returns(bool) {
    //     return state == State.Active;
    // }
    Person[] public people;
    address owner;
    uint256 openingTime=1655106924;
    constructor() public {
        owner=msg.sender;
    }
    struct Person{
        string firstName;
        string lastName;
    }
    
    modifier OnlyOwner(){
        require(block.timestamp>openingTime);
        _;
        // require(msg.sender==owner);
        // _;
    } 


    function addPeople(string memory _firstname, string memory _lastname) public OnlyOwner {
        people.push(Person(_firstname,_lastname));
    }
 
}