// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

contract SendMoney {
    
    uint public totalAmountRecieved;
    uint public totalAmountSent;
    
    function receiveMoney() public payable {
        // the value attribute of the msg object gives the amount in Wei in the particular transaction
        totalAmountRecieved += msg.value;
    }
    
    /**
     * returns the balance of the this smart contract
     **/
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    /**
     * Transfer the balance to the mentioned address.
     **/
    function transferAmountTo(address payable toAddress) public {
        toAddress.transfer(this.getBalance());
    }
    
    /**
     * Transfer the balance to the caller
     **/
    function transferAmountToCaller() public {
        payable (msg.sender).transfer(this.getBalance());
    }
    

}