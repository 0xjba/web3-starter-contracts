**NOT FOR USE IN PRODUCTION**: *This Smart Contract is a barebone's version & is only for educational purpose.*

**Test for the contract isnt included, you can write your own test or do the testing using Ganache, Truffle or Remix. Tests to be included are:**

- Test that the contract owner is set correctly during deployment.
- Test that the `tokenToFarm` and `rewardToken` addresses are set correctly during deployment.
- Test that the `stake` function adds the correct amount to the staked balance of the caller.
- Test that the `unstake` function subtracts the correct amount from the staked balance of the caller.
- Test that the `claim` function transfers the correct amount of reward tokens to the caller.
- Test that the `calculateReward` function returns the correct amount of reward for a given user.
- Test that the `withdrawReward` function transfers the correct amount of reward tokens to the contract owner.
- Test that the contract reverts when calling `stake`, `unstake`, or `claim` with an amount of 0.
- Test that the contract reverts when calling `unstake` with an amount greater than the caller's staked balance.
- Test that the contract reverts when calling `claim` with no reward available to claim.
- Test that the `calculateReward` function returns 0 when the user has not staked any tokens.
- Test that the `calculateReward` function returns 0 when the last claim time is after the current time.
- Test that the contract reverts when calling `withdrawReward` from an account other than the contract owner.
 
**The contract isn't Gas optimised, tips to optimise this contract is given below:**

- Reordering require statements: In the `stake` and `unstake` functions, it's more gas-efficient to check that the user has sufficient balance to perform the transfer before performing the transfer. This is because if the user doesn't have sufficient balance, the transfer will fail and the transaction will revert anyway, so it's better to fail the transaction earlier to save gas. Therefore, the `require` statement that checks the balance should be moved before the `transfer` statement.
    
- Using local variables: In the `calculateReward` function, the `rewardPerToken` and `timeSinceLastClaim` values are used to calculate the reward amount. These values can be stored in local variables to avoid calling the same functions multiple times, which can save gas.
    
- Using the SafeMath library: The `totalStaked` and `rewardPerToken` values are used to calculate the reward amount in the `calculateReward` function. These calculations involve multiplication and division, which can result in integer overflow or underflow if the values are too large. Using the SafeMath library can prevent these errors and ensure that the calculations are performed safely.

**Explanation of the Smart Contract:**

State Variables:
-   `owner`: The address of the contract owner
-   `tokenToFarm`: An instance of the IERC20 interface representing the token that users need to stake in order to earn rewards
-   `rewardToken`: An instance of the IERC20 interface representing the token that users will receive as rewards for staking the tokenToFarm
-   `totalStaked`: The total amount of the tokenToFarm that is currently staked in the contract
-   `stakedBalance`: A mapping between user addresses and their staked tokenToFarm balance
-   `lastClaimTime`: A mapping between user addresses and the timestamp of their last reward claim

Constructor:
-   `constructor(address _rewardToken)`: Initializes the owner and rewardToken state variables and sets the tokenToFarm variable to the MATIC token.

Functions:
-   `stake(uint256 amount)`: Allows a user to stake a specified amount of tokenToFarm. The function requires that the amount is greater than zero and that the transfer of the token from the user's address to the contract address is successful. If successful, the user's staked balance and the total staked amount are updated, and the last claim time is set to the current block timestamp.
-   `unstake(uint256 amount)`: Allows a user to unstake a specified amount of their tokenToFarm balance from the contract. The function requires that the amount is greater than zero, that the user has sufficient balance to unstake, and that the transfer of the token from the contract to the user's address is successful. If successful, the user's staked balance and the total staked amount are updated, and the last claim time is set to the current block timestamp.
-   `claim()`: Allows a user to claim their reward. The function calculates the reward based on the time since their last claim, their staked balance, and the reward per token (total reward balance divided by the total staked amount). The function requires that the reward amount is greater than zero and that the transfer of the reward token from the contract to the user's address is successful. If successful, the last claim time is set to the current block timestamp.
-   `calculateReward(address user)`: A view function that calculates the reward amount a user is eligible for based on their staked balance and the time since their last claim.
-   `withdrawReward()`: Allows the contract owner to withdraw the total balance of reward tokens from the contract. The function requires that the caller is the contract owner and that the transfer of the reward token from the contract to the owner's address is successful.