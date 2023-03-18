//SPDX-License-Identifier: MIT
pragma solidity  0.8.17;

error ZeroAddress(address to);
error LimitNotSet();
error DurationZero();
error TransferError();
error LimitNotPassed(uint currentTime ,uint timeLimit);

contract Time {
    // Create a function to store ethers.
    // Users cannot widthdraw them before a specific time.
    // Include block.timestamp in your code.

    // Steps: 
    // Create a variable name time to store your required time to withdraw.
    // Create function to store ether in your contract.
    // Create a function to convert seconds into minutes.
    // Create a function to withdraw ether.
    // Implement a check to compare the current timestamp converted into minutes with 5 minutes.
    // If the timestamp in minutes is equals to 5 minutes then call the withdraw function to withdraw ether.
    
    uint timeLimit = 0;
    uint public constant WITHDRAW_LIMIT = 1 ether;


    receive() external payable {}
   
    function setTime(uint _duration) external {
        if(_duration <= 0) revert DurationZero();

        timeLimit = block.timestamp + _duration;
    }

    function withdraw(address payable _to) external  {
        if(_to == address(0)) revert ZeroAddress(_to);
        if(block.timestamp <= timeLimit || timeLimit == 0) revert LimitNotPassed(block.timestamp, timeLimit); 

        (bool sent,) = _to.call{value: WITHDRAW_LIMIT}("");
        if(!sent) revert TransferError();
    }
}