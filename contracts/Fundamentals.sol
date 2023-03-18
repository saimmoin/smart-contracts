// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;
import "hardhat/console.sol";

contract Fundamentals {
    string[4] names = ["A", "B", "C", "D"];

    string myName = "ALI";

    modifier checkUser() {
        require((msg.sender != address(0)));
        _;
    }

    ///check if the name of user exists in our record
    ///@return name if exists otherwise empty string
    ///@return index the location of name
    ///@param _name the actual name to find in array
    function getName(string memory _name)
        external
        view
        returns (string memory, uint256 index)
    {
        for (uint256 i; i < names.length; i++) {
            string memory currentName = names[i];

            console.log(names[i]);
            console.log(_name);
            if (
                keccak256((abi.encodePacked(currentName))) ==
                keccak256(abi.encodePacked(_name))
            ) {
                return (names[i], i + 1);
            }
        }
        return ("", 0);
    }

    function hello() external view checkUser {
        // while loop
        uint256 j;
        while (j < 10) {
            j++;
        }
    }

    // Turnanry Function
    function minimalTurnanry(uint256 obtainedMarks)
        external
        pure
        returns (string memory)
    {
        return (
            obtainedMarks >= 90 ? "A*" : obtainedMarks >= 80
                ? "A"
                : obtainedMarks >= 70
                ? "B"
                : obtainedMarks >= 60
                ? "C"
                : "D"
        );
    }


    //If-Else ladder
    function maximulIfElseLadder(uint obtainedMarks) external pure returns (string memory) {
        if(obtainedMarks >= 90)  return "A";
        
        else if(obtainedMarks >= 80)  return "A";
        
        else if(obtainedMarks >= 70) return "B";
        
        else if(obtainedMarks >= 60)  return "C";
        
        else  return "D";
        
    }
}
