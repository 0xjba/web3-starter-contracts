**NOT FOR USE IN PRODUCTION**: *This Smart Contract is a barebone's version & is only for educational purpose.*

**Test for the contract isnt included, you can write your own test or do the testing using Ganache, Truffle or Remix. Tests to be included are:**

- Test should verify that a token can be minted with the correct certificate information and that the certificate information can be retrieved using the `getCertificate` function.
- Test should verify that a non-owner of a token cannot burn it using the `burn` function.
- Test should verify that a burned token cannot be transferred using the `safeTransferFrom` function.
 
**The contract isn't Gas optimised, tips to optimise this contract is given below:**

- Use a more efficient data structure for storing certificates. Instead of using a `mapping` to store each certificate object, we could use an array or a mapping of arrays to store the individual fields of each certificate. This would reduce the storage costs associated with the `mapping` and make it more gas-efficient.
    
- Use `memory` instead of `storage` when passing function arguments. Since most of the function arguments are only used temporarily within the function, we can pass them as `memory` variables instead of `storage` variables. This would reduce the storage costs associated with the function arguments.
    
- Use `bytes32` instead of `string` for the certificate fields. Since the certificate fields are fixed length, we can use `bytes32` instead of `string` to reduce gas costs associated with string manipulation.
    
- Avoid using `delete`. The `delete` keyword is gas-expensive, so we should avoid using it when possible. Instead of deleting the certificate object when burning a token, we could set a flag indicating that the token has been burned, and use this flag to prevent further use of the token.
    
- Use `require` instead of `assert`. The `require` keyword is less gas-expensive than `assert`, so we should use it whenever possible. We can use `require` to check for input parameters, state variables, and other conditions that must be met in order for the function to execute successfully.

**Explanation of the Smart Contract:**

- `safeMint` function is marked as `public` and can be called by anyone, but it is restricted to the contract owner using the `onlyOwner` modifier. This means that only the owner of the contract can create new certificates.

-  `getCertificate` function is marked as `public` and can be called by anyone. It takes a `tokenId` as an input parameter and returns the corresponding `Certificate` object.

-  `burn` function is marked as `external` and can be called by anyone, but it is restricted to the token owner. It takes a `tokenId` as an input parameter and deletes the token and its corresponding `Certificate` object.

- `_beforeTokenTransfer` function is marked as `internal` and is called automatically before a token is transferred. It checks if the token is being transferred to an address other than 0 (burned), in which case it reverts the transaction, ensuring that the token cannot be transferred.

- `_burn` function is marked as `internal` and is called by the `burn` function. It overrides the `_burn()` function of the ERC721 contract and deletes the token and its corresponding `Certificate` object.

Overall, the smart contract provides a simple way to create, retrieve, and delete unique certificates using the ERC721 standard. It ensures that each certificate has a unique token ID and can only be created, deleted, and transferred by its owner.