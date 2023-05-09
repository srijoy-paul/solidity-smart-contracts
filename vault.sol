// SPDX-License-Identifier: MIT
// Create a Vault with Solidity
// Introduction

// What is a vault?
// What features do we need?
// What objects can we make to store things?
// We want to store money in a vault for a period of time. 
// The withdraw function can be designed in a way where we CHECK the time before the money can be taken out.

pragma solidity ^0.8.0;

contract Vault{

    address public owner;
    constructor(){
        owner=msg.sender;
    }
    struct Account{
        uint balance;
        uint timePeriod;
    }
mapping(uint=>Account) public vault;
event added(address owner,uint balance,uint timePeriod);
event withdraw(address owner,uint balance,uint timePeriod);

uint counter=0;
function storeVault(uint _time)public payable{
    counter++;
    // vault[counter].owner=msg.sender;
    vault[counter].balance=msg.value;
    vault[counter].timePeriod=_time;
    emit added(msg.sender,msg.value,_time);
}

function withdrawVault(uint _vaultNumber)public payable{
    require(block.timestamp>=vault[_vaultNumber].timePeriod,"You cannot withdraw, right now.");
    payable(msg.sender).transfer(vault[_vaultNumber].balance);
    vault[_vaultNumber].balance=0;
    emit withdraw(msg.sender,msg.value,block.timestamp);
}

}