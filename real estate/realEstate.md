**NOT FOR USE IN PRODUCTION**: *This Smart Contract is a barebone's version & is only for educational purpose.*

**Test for the contract isnt included, you can write your own test or do the testing using Ganache, Truffle or Remix. Tests to be included are:**

- A test that verifies a property can be added to the contract by checking that the values set during the transaction match the expected values.
- A test that verifies a property can be bought by a buyer and that the correct values are set during the transaction, including the buyer and the "is sold" flag.
 - A test that verifies a property can be rented by a renter and that the correct values are set during the transaction, including the renter, the rent amount, and the emission of the "RentPaid" event.

**The contract isn't Gas optimised, tips to optimise this contract is given below:**

- Use `uint32` instead of `uint256` for `PropertyType`    The    `PropertyType` enum only has two values, and can therefore be       represented using a smaller data type like `uint32` instead of the      default `uint256` to reduce gas costs.
Use `bytes32` instead of `string`    For the `streetAddress`, `city`, `state`, and `zipCode` fields of the    `Property` struct,    using `bytes32` instead of `string` can save gas    costs since    `bytes32` is a fixed-size data type and requires less gas    to    store.
- Remove `onlyOwner` modifier from `getProperty`    Since `getProperty` is a read-only function that doesn't modify the       state of the contract, the `onlyOwner` modifier can be removed to       save gas costs.
- Use `view` function modifier for `getProperty`    The `getProperty` function only reads data from the contract and       doesn't modify its state, so it can be marked as `view` to save gas     costs.
- Mark `buyProperty` and `rentProperty` as `payable`    Since `buyProperty` and `rentProperty` receive Ether from the caller,       they should be marked as `payable`.

**Explanation of the Smart Contract:**

    -   `owner`: an `address payable` variable that stores the address of the contract owner.
    -   `PropertyType`: an `enum` that defines two types of properties: Residential and Commercial.
    -   `Property`: a `struct` that defines the properties of each property, including the owner, street address, city, state, zip code, property type, price, and whether the property is sold or not.
    -   `properties`: an array of `Property` structs that stores all of the properties added to the contract.
    -   `event PropertyAdded`: an event that is emitted when a new property is added.
    -   `event PropertySold`: an event that is emitted when a property is sold.
    -   `event RentPaid`: an event that is emitted when rent is paid on a property.
    -   `onlyOwner`: a `modifier` that restricts access to functions only to the contract owner.
    -   `addProperty()`: a function that adds a new property to the `properties` array, using the `onlyOwner` modifier to ensure that only the owner can add properties.
    -   `getProperty()`: a function that returns the property information for a given property ID.
    -   `buyProperty()`: a function that allows someone to buy a property by transferring the appropriate amount of Ether to the property owner and marking the property as sold.
    -   `rentProperty()`: a function that allows someone to rent a residential property by transferring the appropriate amount of Ether to the contract and emitting a `RentPaid` event.