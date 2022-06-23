// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;

abstract contract ErcStandard{
    function name() public view virtual returns (string memory);
    function symbol() public view virtual returns (string memory);
    function decimals() public view virtual returns (uint8);
    function totalSupply() public view virtual returns (uint256);
    function balanceOf(address _owner) public view virtual returns (uint256 balance);
    function transfer(address _to, uint256 _value) public virtual returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) public virtual returns (bool success);
    function approve(address _spender, uint256 _value) public virtual returns (bool success);
    function allowance(address _owner, address _spender) public view virtual returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);


}

contract Ownership{
    address public ContractOwner;
    address public newOwner;
    event transferOwnerShip(address indexed _from, address indexed _to);
    constructor() {
        ContractOwner=msg.sender;
    }

    function changeOwner(address _to) public{
        require(msg.sender == ContractOwner, 'Only contracts owner can change ownership');
        newOwner=_to;
    }
    function acceptNewOwner() public {
        require(msg.sender == newOwner, 'New owner should only call this contracts');
        emit transferOwnerShip(ContractOwner, newOwner);
        ContractOwner=newOwner;
        newOwner=address(0);

    }
}

contract MyErcToken is ErcStandard,Ownership {
    string public _name;
    string public _symbol;
    uint8 public _decimals;
    uint256 public _totalSupply;
    mapping(address => uint256 ) _tokenBalance;
    mapping(address => mapping(address => uint256)) allowed;


    address public _minter;
    constructor (address minter_){
        _name='Shamoon Shahid';
        _symbol="SS";
        _totalSupply=100000;
        _minter=minter_;
        _tokenBalance[_minter]=_totalSupply;
    }
    
    function name() public view override returns (string memory){
        return _name;
    }
    function symbol() public view override returns (string memory ){
        return _symbol;
    }
    function decimals() public view override returns (uint8){
        return _decimals;
    }
    function totalSupply() public view override returns (uint256){
        return _totalSupply;
    }


    function balanceOf(address _owner) public view override returns (uint256 balance){
        return _tokenBalance[_owner];
    }
    function transfer(address _to, uint256 _value) public override returns (bool success){
        require(_tokenBalance[msg.sender] >= _value,'Insufficient funds');

        _tokenBalance[msg.sender]-=_value;

        _tokenBalance[_to]+=_value;
    
        emit Transfer(msg.sender,_to,_value);
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success){
        uint256  allowedBal=allowed[_from][msg.sender];
        require(allowedBal >= _value,'Insufficient Balance');
        
        _tokenBalance[msg.sender]-=_value;
        _tokenBalance[_to]+=_value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    function approve(address _spender, uint256 _value) public override returns (bool success){
require(_tokenBalance[msg.sender] >= _value ,' Insufficient funds');
        allowed[msg.sender][_spender]=_value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    function allowance(address _owner, address _spender) public view override returns (uint256 remaining){
        return allowed[_owner][_spender];
    }
}