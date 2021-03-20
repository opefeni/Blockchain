// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract Inheritance {
    //define unsigned interger storage
    address owner;
    uint money;
    bool deceased;
    
    //initialise a constructor
    constructor() public payable  {
        owner = msg.sender;
        money = msg.value;
        deceased =  false;
    }
    
    //set modifier to validates our functions
    modifier oneOwner {
        //confirm the owner is the sender
        require(msg.sender == owner, "Unknown Owner");
        _;
    }
    
    modifier isDeceased {
        require(deceased == true, "The owner is still alive");
        _;
    }
    
    //initialise wallet address in  array format
    address[] wallets;
    
    //mapping address to the inheritance
    mapping(address => uint) inheritance;
    
    // call oneOwner modifier to validate before excuting the function
    // the function setUp that takes the wallet address and inheritance as argument
    function setUp(address _wallet, uint _inheritance) public oneOwner {
        wallets.push(_wallet);
        inheritance[_wallet] = _inheritance;
        
    }
    
    // call is modifier to validate the death of the owner
    // this function transfer the inheritance on validation
    function moneyPaid() private isDeceased {
        // loop through the inheritance
        // and transfer the inherited amount
        for(uint i=0; i<wallets.length; i++){
            wallets[i].transfer(inheritance[wallets[i]]);
        }
    }
    
    // this function confirms the owner is dead and then excute the contract
    // this function is validated by oneOwner modifier
    function died() public oneOwner{
        //set deceased to true
        deceased =  true;
        //excute the transfer to the benefiaries.
        moneyPaid();
    }
}