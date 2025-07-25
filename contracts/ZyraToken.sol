// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ZyraToken is ERC20 {

    // Variables
    address public owner;


    // Modifiers
    modifier onlyOwner(){
        require(msg.sender == owner, "Not the owner");
        _;
    }

    
    constructor(string memory name_, string memory symbol_) ERC20(name_,symbol_) {
        owner = msg.sender;
    }

    // Events
    event TransferNewOwner( address indexed previousOwner, address indexed newOwner);
    event TokenMinted(address to_, uint256 amount_);

    // External functions
    function mintTokens(address to_, uint256 amount_) public onlyOwner {
        require(to_ != address(0), "Invalid address");
        require(amount_ > 0, "Amount must be greater than zero");

        _mint(to_, amount_);

        emit TokenMinted(to_, amount_);
    }

    function transferOwnership (address newOwner_) public onlyOwner {
        require(newOwner_ != address(0), "Invalid new owner address");
        address previousOwner = owner;
        owner = newOwner_;

        emit TransferNewOwner(previousOwner, newOwner_);
    }

    // Internal functions



}
