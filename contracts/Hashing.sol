//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Hashing {
    function hash(address addr1, address addr2) external pure returns(bytes32) {
        if(addr1 < addr2){
            return keccak256(abi.encode(addr1, addr2));
        } else{
             return keccak256(abi.encode(addr2, addr1));
        }
       
    }
}