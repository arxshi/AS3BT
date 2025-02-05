// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AITUTokenNew is ERC20 {
    struct TransactionInfo {
        address sender;
        address receiver;
        uint256 amount;
        uint256 timestamp;
    }

    TransactionInfo[] public transactions;

    constructor(uint256 initialSupply) ERC20("AITUTokenNew_SE2329", "AITUN") {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        _logTransaction(msg.sender, to, amount);
        return super.transfer(to, amount);
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        _logTransaction(from, to, amount);
        return super.transferFrom(from, to, amount);
    }

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

    function getLatestTransactionTimestamp() public view returns (uint256) {
        require(transactions.length > 0, "No transactions yet.");
        return transactions[transactions.length - 1].timestamp;
    }

    function getLatestTransactionSender() public view returns (address) {
        require(transactions.length > 0, "No transactions yet.");
        return transactions[transactions.length - 1].sender;
    }

    function getLatestTransactionReceiver() public view returns (address) {
        require(transactions.length > 0, "No transactions yet.");
        return transactions[transactions.length - 1].receiver;
    }
}
