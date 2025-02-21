// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TimelockWallet {
    address private owner;
    uint256 private unlockTime;

    // Hardcoded unlock delay (e.g., 7 days)
    uint256 constant DELAY = 7 days;

    // Set owner and unlock time only once
    function initialize() external {
        require(owner == address(0), "Already initialized");
        owner = msg.sender;
        unlockTime = block.timestamp + DELAY;
    }

    // Deposit ETH to the contract
    receive() external payable {}

    // Withdraw funds after unlock time
    function withdraw() external {
        require(msg.sender == owner, "Not the owner");
        require(block.timestamp >= unlockTime, "Funds are locked");

        payable(owner).transfer(address(this).balance);
    }

    // Check remaining lock time
    function timeLeft() external view returns (uint256) {
        return block.timestamp >= unlockTime ? 0 : unlockTime - block.timestamp;
    }

    // Check contract balance
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
