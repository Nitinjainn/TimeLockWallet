# ⏳ Time-Locked Wallet

## 📌 Overview
This Solidity smart contract implements a **simple time-locked wallet** where funds can only be withdrawn after a **fixed delay** of **7 days**. The contract ensures that once deployed and initialized, the owner must wait for the specified time before withdrawing their funds.

## ⚙️ Features
- **🔒 One-Time Initialization:** The first caller of `initialize()` becomes the owner.
- **⏳ Time-Locked Withdrawals:** Funds can only be withdrawn after 7 days.
- **💰 ETH Deposits:** Anyone can send ETH to the contract.
- **⏱ Check Remaining Time:** A function to check the time left before withdrawal is allowed.
- **👀 View Balance:** A function to check the contract’s ETH balance.

## 📜 Solidity Code Breakdown

```solidity
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
```

## 🚀 How It Works
1. **Deploy the Contract:** No constructor parameters are required.
2. **Initialize the Owner:** The first person to call `initialize()` becomes the owner.
3. **Deposit ETH:** The owner or anyone else can send ETH to the contract.
4. **Wait for 7 Days:** The contract holds the funds until the unlock time is reached.
5. **Withdraw ETH:** The owner can withdraw all funds after the time lock expires.

## 🔒 Security Considerations
- **One-Time Initialization:** Prevents ownership changes after the first initialization.
- **Restricted Withdrawals:** Only the assigned owner can withdraw after the time lock.
- **No Constructor Parameters:** Eliminates potential parameter manipulation during deployment.

## 📌 Use Cases
This contract is useful for:
- **Savings Plans**: Lock ETH for a future date.
- **Trust Accounts**: Secure funds until a predefined time.
- **Delayed Disbursements**: Automate the release of payments.

## 🌍 About VibeTribe
VibeTribe is a community-driven tourism platform that enables users to form travel groups and manage trips efficiently. Users can create communities, select destinations, and collaborate with fellow travelers. By incorporating blockchain-powered solutions like this time-locked wallet, VibeTribe enhances security and trust in financial transactions related to group trips.

## 🔗 Deployed Contract
The **Time-Locked Wallet** contract has been deployed on the **Edu Chain** network at the following address:

**`0x72246D7f946469b39f2dC41B0AAd8B352984d4a4`**

You can interact with the contract using any Ethereum-compatible blockchain explorer or wallet.

## 📝 License
This project is licensed under the **MIT License**.

---
🚀 **Enjoy secure and automated time-locked funds management with Solidity!**
