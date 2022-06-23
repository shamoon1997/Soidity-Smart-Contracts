// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.6.9;



contract Counter {
    uint count=0;
    event increment(uint value);
    event decrement(uint value);


    function incrementCount() public{
        count+=1;
        emit increment(count);
    }

    function decrementCount() public {
        count-=1;
        emit decrement(count);
    }

    function incrementWithOut() public {
        count+=1;
    }

    function getCount() view public returns(uint){
        return count;
    }
}