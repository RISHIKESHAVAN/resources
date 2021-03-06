// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

contract VariableTypes {
    uint256 public myUint;
    
    function setMyUint(uint inputUint) public {
        myUint = inputUint;
    }
    
    bool public myBool;
    
    function setMyBool(bool inputBool) public {
        myBool = inputBool;
    }
    
    uint8 public myUnit8;
    
    function decrementUint8() public {
        unchecked { myUnit8--; }
    }
    
    function incrementUint8() public {
        myUnit8++;
    }
    
    address public myAddress;
    
    function setMyAddress(address inputAddress) public {
        myAddress = inputAddress;
    }
    
    function getBalance(address inputAddress) public view returns(uint) {
        return inputAddress.balance;
    }
    
    function getBalanceOfMyAddress() public view returns(uint) {
        return myAddress.balance;
    }
    
    string public myString;
    
    function setMyString(string memory inputString) public {
        myString = inputString;
    }
}