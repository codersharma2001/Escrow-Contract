// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;
    bool public isApproved;


    constructor (address _arbiter , address _beneficiary ) payable {
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }
    event Approved (uint beneficiary);
    
    function approve() external {
        require(msg.sender == arbiter);
        uint balance = address(this).balance;
        (bool sent, ) = beneficiary.call{value : address(this).balance}("");
        require(sent , "Failed to approved");
        isApproved = true;
        emit Approved(balance);
    }
}
