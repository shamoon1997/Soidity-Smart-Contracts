// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;
struct Person{
    uint256 age;
    string gender;
    uint256 lendTime;
}
contract PetSanctuary{
    enum AnimalKind {Fish,Cat,Dog,Rabbit,Parrot}
    AnimalKind public  animalKind;
    address public owner;
    mapping(AnimalKind => uint256) public animals;
    mapping(address => bool) buyStatus;
    mapping(address => Person) buyers;

    constructor(){
        owner=msg.sender;
    }
    modifier onlyOwner(){
        require(msg.sender == owner, 'Only owner can give shelter ');
        _;
    }
    function add(AnimalKind _animalKind, uint256 _howManyPieces) onlyOwner public {
        animals[_animalKind]=_howManyPieces;
    }
    function buy(uint256 personAge,string memory _personGender, AnimalKind _animalKind) public {
        require(buyStatus[msg.sender] != true, 'You already have borrowed the animal');
        if(keccak256(bytes(_personGender)) == keccak256(bytes("Male"))){
            require(_animalKind == AnimalKind.Dog,'You can only buy dog or fish');
            require(_animalKind == AnimalKind.Fish,'You can only buy dog or fish');
            buyers[msg.sender]=Person(personAge,_personGender,block.timestamp);
            animals[_animalKind]-=1;
            buyStatus[msg.sender]=true;
        }

         if(keccak256(bytes(_personGender)) == keccak256(bytes("Female"))){
             if(personAge < 40){
                 require(_animalKind != AnimalKind.Cat,'You are not allowed to buy cat');
             }
            buyers[msg.sender]=Person(personAge,_personGender,block.timestamp);
            buyStatus[msg.sender]=true;
         }
    }
    function giveBackAnimal(AnimalKind _animalKind) public {
        require(buyStatus[msg.sender] == true,"You haven't lend the animal yet");
        require(buyers[msg.sender].lendTime+300 < block.timestamp, "It is more than 5 minutes now ");
        buyStatus[msg.sender]=false;
        animals[_animalKind]+=1;
        Person memory person;
        buyers[msg.sender]=person;
    }
}