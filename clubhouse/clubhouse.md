**NOT FOR USE IN PRODUCTION**: *This Smart Contract is a barebone's version & is only for educational purpose.*

**Test for the contract isnt included, you can write your own test or do the testing using Ganache, Truffle or Remix. Tests to be included are:**

- Test that a user can join a room as a speaker, a user can join a room as a listener, and a user can't join a room that doesn't exist.
- Test that a speaker can leave a room, a listener can leave a room, and a user can't leave a room that doesn't exist.
- Test that getting details for an existing room returns the correct values, and getting details for a non-existent room returns default values.
 
**The contract isn't Gas optimised, tips to optimise this contract is given below:**

-  Use `memory` instead of `storage` where possible: The `Room` struct contains arrays of addresses for speakers and listeners. Since these arrays are not intended to be persisted across function calls, we can save gas by defining these arrays in memory instead of storage.
-  Use `bytes32` instead of `string`: Solidity `string` type is relatively expensive in terms of gas cost. We can use `bytes32` type instead to represent the room name.
-  Use `uint32` instead of `uint256` where possible: `uint256` type is more expensive than `uint32` or `uint16` in terms of gas cost. We can use smaller integer types where we don't need a full 256 bits of precision.
-  Use `view` or `pure` functions where possible: If a function doesn't modify the state of the contract, it can be marked as `view` or `pure` to indicate this to the compiler. This can help reduce the gas cost of calling the function.
- **IMP**:Use alternative data structures to `for` loops where possible: `for` loops in smart contracts can be gas-intensive, and in some cases, it may be possible to use alternative data structures to perform the same operation. For example, instead of using a `for` loop to search an array for a specific value, you could use a mapping to keep track of whether a value is present. However, it's important to balance the potential gas savings against the complexity and maintainability of the code.

**Explanation of the Smart Contract:**

**State Variables**

-   `rooms`: This is a private mapping that maps host addresses to an array of `Room` structs. Each `Room` struct contains information about the room, including the name, host address, start and end times, capacity, speakers, and listeners.

**Functions**

-   `createRoom`: This function creates a new room with the given parameters and adds it to the array of rooms for the calling host.
-   `getRooms`: This function returns an array of all the rooms created by the specified host.
-   `joinAsSpeaker`: This function adds the caller to the speakers array of the specified room, subject to various checks.
-   `joinAsListener`: This function adds the caller to the listeners array of the specified room, subject to various checks.
-   `leaveRoom`: This function removes the caller from either the speakers or listeners array of the specified room, subject to various checks.

**Function Parameters**

-   `createRoom`: This function takes in the following parameters:
    
    -   `_name`: The name of the room being created.
    -   `_startTime`: The start time of the room in UNIX timestamp format.
    -   `_endTime`: The end time of the room in UNIX timestamp format.
    -   `_capacity`: The maximum number of speakers and listeners allowed in the room.
-   `getRooms`: This function takes in the following parameter:
    
    -   `_host`: The address of the host for whom the rooms should be retrieved.
-   `joinAsSpeaker`: This function takes in the following parameters:
    
    -   `_host`: The address of the host of the room being joined.
    -   `_roomId`: The index of the room in the array of rooms for the specified host.
-   `joinAsListener`: This function takes in the following parameters:
    
    -   `_host`: The address of the host of the room being joined.
    -   `_roomId`: The index of the room in the array of rooms for the specified host.
-   `leaveRoom`: This function takes in the following parameters:
    
    -   `_host`: The address of the host of the room being left.
    -   `_roomId`: The index of the room in the array of rooms for the specified host.