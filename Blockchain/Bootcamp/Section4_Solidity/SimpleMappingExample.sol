// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

contract SimpleMappingExample {
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;
    
    function setMyMapping(uint index) public {
        myMapping[index] = true;
    }
    
    function setMyAddressToTrue(address add) public {
        myAddressMapping[add] = true;
    }
    
    function setCallerAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }
}