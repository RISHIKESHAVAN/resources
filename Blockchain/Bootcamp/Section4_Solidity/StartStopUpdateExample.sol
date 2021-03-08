// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

contract StartStopUpdate {
    
    address owner;
    bool public transactionPaused;
    
    constructor() {
        owner = msg.sender;
    }
    
    function pauseTransaction(bool pauseTrigger) public {
        require(owner == msg.sender, "You are not the owner.");
        transactionPaused = pauseTrigger;
    }
    
    function receiveMoney() public payable {
        
    }
    
    function sendAllMoney(address payable toAddress) public {
        require(owner == msg.sender, "You are not the owner. Don't try to steal all the money!!");
        require(!transactionPaused, "The Contract is paused. The owner has to unpause it to proceed with transactions.");
        toAddress.transfer(address(this).balance);
    }
    
    function destroySmartContract(address payable toAddress) public {
        require(owner == msg.sender, "You are not the owner.");
        selfdestruct(toAddress);
    }
}