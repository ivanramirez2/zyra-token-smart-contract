// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract ZyraToken is ERC20, Pausable, Ownable {

    // Variables


    // Modifiers

    
    constructor(string memory name_, string memory symbol_) ERC20(name_,symbol_) Ownable(msg.sender) {
        
    }



    // Events

    event TransferNewOwner( address indexed previousOwner, address indexed newOwner);

    event TokenMinted(address to, uint256 amount);
    
    event TokenBurned(address indexed from, uint256 amount);



    // External functions

    function mintTokens(address to_, uint256 amount_) public onlyOwner {
        require(to_ != address(0), "Invalid address");
        require(amount_ > 0, "Amount must be greater than zero");

        _mint(to_, amount_);

        emit TokenMinted(to_, amount_);
    }


    function transferOwnershipCustom(address newOwner_) public onlyOwner {
    emit TransferNewOwner(owner(), newOwner_);
    transferOwnership(newOwner_);
    }
 

    function burn(uint256 amount_) public {
        require(balanceOf(msg.sender) >= amount_, "Insufficient balance to burn");
        require(amount_ > 0, "Amount must be greater than zero");
        _burn(msg.sender, amount_);

        emit TokenBurned(msg.sender, amount_);
    }

    function pause() public onlyOwner{
        _pause();
    }

    function unpause() public onlyOwner{
        _unpause();
    }
 
    // Internal functions
    
}
