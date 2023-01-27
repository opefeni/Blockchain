// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract Coin{

    //create a variable minter with address type 
    // and public scope to make it available to other contracts
    address public minter;
    // create a variable balance with mapping data type
    // mapping address to unsigned interger
    // and public scope
    mapping(address => uint) public balance;

    // call send event
    event Send(address from, address to, uint amount);

    // call the constructor which will only
    // runs when the contract is created
    constructor(){
        minter = msg.sender;
    }

    // create a function to send coin to only the 
    // creator of the contract
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balance[receiver] += amount;
    }

    //error InsufficientBalance;
    //InsufficientBalance(uint requested, uint available);

    // create a function to send coin
    function send(uint amount, address receiver) public{
        //
        
        // perform credit and debit transactions
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
        emit Send(msg.sender, receiver, amount);
    }

}