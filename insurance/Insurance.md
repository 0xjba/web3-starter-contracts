**NOT FOR USE IN PRODUCTION**: *This Smart Contract is a barebone's version & is only for educational purpose.*

**Test for the contract isnt included, you can write your own test or do the testing using Ganache, Truffle or Remix. Tests to be included are:**

*- A test to verify that only the policyholder can make a claim.
- A test to verify that claims cannot be made on expired policies.
- A test to verify that only one claim can be made per policy.
- A test to verify that the correct payout amount is transferred to the policyholder when a claim is made.
- A test to verify that the policyholder can only withdraw the premium after the policy has expired.
- A test to verify that the insurer can expire the policy, which prevents further claims from being made.*

**The contract isn't Gas optimised, tips to optimise this contract is given below:**

*- Use uint128 instead of uint256 for premium and payoutAmount variables, since these variables will never exceed the maximum value of a uint128 and using a smaller variable type will reduce the amount of gas required for storage and computation.
- Use block.timestamp instead of now since the latter has been deprecated in the latest version of Solidity.
- Use view instead of pure for the getPolicyDetails function since it only reads data from the contract and does not modify state.
- Use require instead of assert for input validation since require will consume less gas.*

**Explanation of the Smart Contract:**
The contract includes the following state variables:

    insurer: The Ethereum address of the insurer, which is a payable address. This address will receive any payout made by the policyholder in the event of a successful claim.
    
    policyholder: The Ethereum address of the policyholder.
    
    premium: The cost of the insurance policy that the policyholder must pay upfront.
    
    payoutAmount: The amount that will be paid out to the policyholder in the event of a successful claim.
    
    expirationDate: The date and time when the insurance policy will expire.
    
    expired: A boolean variable that will be set to true when the policy has expired.
    
    claimed: A boolean variable that will be set to true when a claim has been made on the policy.

The constructor function takes in the following parameters:

    _insurer: The Ethereum address of the insurer.
    
    _policyholder: The Ethereum address of the policyholder.
    
    _premium: The cost of the insurance policy.
    
    _payoutAmount: The amount that will be paid out to the policyholder in the event of a successful claim.
    
    _durationInDays: The number of days that the insurance policy will be in effect.

The constructor initializes the state variables with the corresponding input parameters and sets the expiration date to _durationInDays days from the current block timestamp.

The contract includes the following functions:

    payPremium(): A payable function that the policyholder can use to pay the premium amount. It requires that the amount sent with the function call is equal to the premium variable.
    
    claim(): A function that the policyholder can use to make a claim. It requires that the function is called by the policyholder, that the policy has not yet expired, and that no claim has been made on the policy before. The function sets the claimed variable to true and transfers the payoutAmount to the insurer.
    
    withdrawPremium(): A function that the policyholder can use to withdraw the premium amount if the policy has expired and no claim has been made. It requires that the function is called by the policyholder, that the policy has expired, and that no claim has been made on the policy before. The function transfers the premium amount back to the policyholder.
    
    expirePolicy(): A function that the insurer can use to expire the policy. It requires that the function is called by the insurer. It sets the expired variable to true.
    
    getPolicyDetails(): A view function that returns all the state variables of the contract.
