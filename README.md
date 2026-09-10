# Ethernaut writeups
This repo is a default structure of foundry framework.
## Level 0
This level hides solidity code and force us to interact with its abi. Just follow the instructions and we are fine.
## Level 1
*   **Vulnerability:** The `receive()` function contains a critical flaw that grants contract ownership to anyone who triggers it, provided they have made at least one prior contribution.
*   **Exploit:** First, I called `contribute()` with 1 wei to get my address on the contributions ledger. Next, I sent a low-level transaction with 1 wei and no data to trigger the `receive()` function, which overwrote the `owner` variable with my address. Finally, as the new owner, I called `withdraw()` to drain the contract.
*   I did this just through abi and my wallet, no code here :((
## Level 2
*   **Vulnerability:** The contract uses an outdated constructor syntax, but the developer misspelled the function name (`Fal1out` instead of `Fallout`). This turns the intended constructor into a standard, publicly callable function.
*   **Exploit:** I simply called the `Fal1out()` function, which executed `owner = msg.sender`, immediately granting me ownership of the contract. From there, I could call `collectAllocations()` to drain it.
*   Practiced abi and sending transaction with wallet again, no code :((
## Level 3
*   **Vulnerability:** The contract relies on `blockhash(block.number - 1)` to generate "randomness". Because blockchain state is deterministic and public, this value is entirely predictable to other smart contracts.
*   **Exploit:** I deployed a malicious contract `lv3-attacker.sol` that calculates the exact same blockhash equation in the same transaction, effectively pre-computing the correct coin flip before calling the victim contract.
*   **Code:** [Attacker Contract](./src/lv3-attacker.sol) | [Execution Script](./script/lv3-script.s.sol)
*   **Lesson:** use random oracle from chainlink
## Level 4
*   **Vulnerability:** The contract relies on `tx.origin != msg.sender` to authorize ownership changes. While `tx.origin` refers to the original Externally Owned Account (EOA) that signed the transaction, `msg.sender` is only the immediate caller, making authentication vulnerable to intermediary contract proxying or phishing attacks.
*   **Exploit:** I deployed an intermediary `Attacker` contract that forwards a call to `changeOwner(tx.origin)`. Because the transaction originates from my wallet (`tx.origin = player`) but hits the `Telephone` contract via the attacker contract (`msg.sender = attacker`), the inequality condition evaluates to true, successfully transferring ownership to my wallet address.
*   **Code:** [Attacker Contract](./src/lv4-attacker.sol) | [Execution Script](./script/lv4-script.s.sol)
*   **Lesson:** Never use `tx.origin` for access control or authorization; use `msg.sender` instead.