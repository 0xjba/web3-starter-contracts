pragma solidity ^0.8.0;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract YieldFarm {
    address public owner;
    IERC20 public tokenToFarm;
    IERC20 public rewardToken;
    uint256 public totalStaked;
    mapping(address => uint256) public stakedBalance;
    mapping(address => uint256) public lastClaimTime;

    constructor(address _rewardToken) {
        owner = msg.sender;
        tokenToFarm = IERC20(0x7d1AfA7B718fb893dB30A3aBc0Cfc608AaCfeBB0); // Address of MATIC token
        rewardToken = IERC20(0x2170ed0880ac9a755fd29b2688956bd959f933f8); // Address of ETH token
    }

    function stake(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(tokenToFarm.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        stakedBalance[msg.sender] += amount;
        totalStaked += amount;
        lastClaimTime[msg.sender] = block.timestamp;
    }

    function unstake(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(stakedBalance[msg.sender] >= amount, "Insufficient balance");
        require(tokenToFarm.transfer(msg.sender, amount), "Transfer failed");
        stakedBalance[msg.sender] -= amount;
        totalStaked -= amount;
        lastClaimTime[msg.sender] = block.timestamp;
    }

    function claim() public {
        uint256 reward = calculateReward(msg.sender);
        require(reward > 0, "No reward available");
        require(rewardToken.transfer(msg.sender, reward), "Transfer failed");
        lastClaimTime[msg.sender] = block.timestamp;
    }

    function calculateReward(address user) public view returns (uint256) {
        uint256 timeSinceLastClaim = block.timestamp - lastClaimTime[user];
        uint256 rewardPerToken = rewardToken.balanceOf(address(this)) / totalStaked;
        uint256 reward = stakedBalance[user] * rewardPerToken * timeSinceLastClaim / 86400;
        return reward;
    }

    function withdrawReward() public {
        require(msg.sender == owner, "Only the owner can withdraw the reward");
        uint256 rewardAmount = rewardToken.balanceOf(address(this));
        require(rewardToken.transfer(msg.sender, rewardAmount), "Transfer failed");
    }
}
