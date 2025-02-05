// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AITUToken is ERC20 {
    // Struct to store transaction details
    struct TransactionInfo {
        address sender;
        address receiver;
        uint256 amount;
        uint256 timestamp;
    }

    TransactionInfo[] public transactions;

    constructor() ERC20("AITUToken_SE2329", "AITU") {
        // Mint initial supply of 2000 tokens (scaled by 18 decimals)
        _mint(msg.sender, 2000 * 10 ** decimals());
    }

    // Overridden transfer function to track transactions
    function transfer(address to, uint256 amount) public override returns (bool) {
        _logTransaction(msg.sender, to, amount);
        return super.transfer(to, amount);
    }

    // Overridden transferFrom function to track transactions
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override returns (bool) {
        _logTransaction(from, to, amount);
        return super.transferFrom(from, to, amount);
    }

    // Internal function to log transactions
    function _logTransaction(address from, address to, uint256 amount) internal {
        transactions.push(
            TransactionInfo({
                sender: from,
                receiver: to,
                amount: amount,
                timestamp: block.timestamp
            })
        );
    }

    // Function to return the latest transaction's block timestamp in a readable format
    function getLatestTransactionTimestamp() public view returns (uint256) {
        require(transactions.length > 0, "No transactions yet.");
        return transactions[transactions.length - 1].timestamp;
    }

    // Function to retrieve sender of the latest transaction
    function getLatestTransactionSender() public view returns (address) {
        require(transactions.length > 0, "No transactions yet.");
        return transactions[transactions.length - 1].sender;
    }

    // Function to retrieve receiver of the latest transaction
    function getLatestTransactionReceiver() public view returns (address) {
        require(transactions.length > 0, "No transactions yet.");
        return transactions[transactions.length - 1].receiver;
    }
}