// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract RealEstate {
    address payable public owner;

    enum PropertyType { Residential, Commercial }

    struct Property {
        address payable owner;
        string streetAddress;
        string city;
        string state;
        string zipCode;
        PropertyType propertyType;
        uint price;
        bool isSold;
    }

    Property[] public properties;

    event PropertyAdded(uint propertyId);
    event PropertySold(uint propertyId);
    event RentPaid(uint propertyId, address tenant, uint amount);

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }

    function addProperty(string memory _streetAddress, string memory _city, string memory _state, string memory _zipCode, PropertyType _propertyType, uint _price) public onlyOwner {
        properties.push(Property(payable(msg.sender), _streetAddress, _city, _state, _zipCode, _propertyType, _price, false));
        emit PropertyAdded(properties.length - 1);
    }

    function getProperty(uint _propertyId) public view returns (address, string memory, string memory, string memory, string memory, PropertyType, uint, bool) {
        Property storage property = properties[_propertyId];
        return (property.owner, property.streetAddress, property.city, property.state, property.zipCode, property.propertyType, property.price, property.isSold);
    }

    function buyProperty(uint _propertyId) public payable {
        Property storage property = properties[_propertyId];
        require(!property.isSold, "Property is already sold.");
        require(msg.value == property.price, "Incorrect amount sent.");

        property.isSold = true;
        property.owner.transfer(msg.value);
        emit PropertySold(_propertyId);
    }

    function rentProperty(uint _propertyId) public payable {
        Property storage property = properties[_propertyId];
        require(property.propertyType == PropertyType.Residential, "Only residential properties can be rented.");
        require(msg.value > 0, "Rent amount must be greater than zero.");

        emit RentPaid(_propertyId, msg.sender, msg.value);
    }
}
