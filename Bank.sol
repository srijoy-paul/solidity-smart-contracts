// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank{
    struct Account{
        address owner;
        uint balance;
        uint accountCreatedTime;
    }
    mapping (address=>Account) public decentralizedSBI;
    event balanceAdded(address owner,uint balance,uint accountCreatedTime);
    event balanceWithdrawal(address owner,uint balance, uint accountCreatedTime);

    modifier minimumAmount(){
        require(msg.value>=1 ether,"Insuffecient amount");
        _;
    }


    function createAccount()public payable minimumAmount{
        decentralizedSBI[msg.sender].owner=msg.sender;
        decentralizedSBI[msg.sender].balance=msg.value;
        decentralizedSBI[msg.sender].accountCreatedTime=block.timestamp;
        emit balanceAdded(msg.sender,msg.value,block.timestamp);
    }

    function fundsDeposit()public payable minimumAmount{
        decentralizedSBI[msg.sender].balance+=msg.value;
        emit balanceAdded(msg.sender,msg.value,block.timestamp);
    }
    function fundsWithdrawal()public payable{
        //address.transfer(amount);
        payable(msg.sender).transfer(decentralizedSBI[msg.sender].balance);
        decentralizedSBI[msg.sender].balance=0;
        emit balanceWithdrawal(msg.sender, msg.value, block.timestamp);
    }
}