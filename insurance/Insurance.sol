// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

contract Insurance {
    
    address payable public insurer;
    address public policyholder;
    uint256 public premium;
    uint256 public payoutAmount;
    uint256 public expirationDate;
    bool public expired;
    bool public claimed;
    
    constructor(address payable _insurer, address _policyholder, uint256 _premium, uint256 _payoutAmount, uint256 _durationInDays) {
        insurer = _insurer;
        policyholder = _policyholder;
        premium = _premium;
        payoutAmount = _payoutAmount;
        expirationDate = block.timestamp + (_durationInDays * 1 days);
        expired = false;
        claimed = false;
    }
    
    function payPremium() public payable {
        require(msg.value == premium, "Premium payment must be equal to the policy premium.");
    }
    
    function claim() public {
        require(msg.sender == policyholder, "Only the policyholder can make a claim.");
        require(block.timestamp < expirationDate, "The policy has expired.");
        require(!claimed, "A claim has already been made on this policy.");
        claimed = true;
        insurer.transfer(payoutAmount);
    }
    
    function withdrawPremium() public {
        require(msg.sender == policyholder, "Only the policyholder can withdraw the premium.");
        require(!claimed, "A claim has already been made on this policy.");
        require(block.timestamp >= expirationDate, "The policy has not yet expired.");
        payable(policyholder).transfer(premium);
    }
    
    function expirePolicy() public {
        require(msg.sender == insurer, "Only the insurer can expire the policy.");
        expired = true;
    }
    
    function getPolicyDetails() public view returns (address, address, uint256, uint256, uint256, bool, bool) {
        return (insurer, policyholder, premium, payoutAmount, expirationDate, expired, claimed);
    }
    
}
