//SPDX-License-Identifier: MIT
pragma solidity  0.8.17;

contract Storage{
    string name;
    struct User {
        string name;
        uint8 age;
        uint8 height;
    }

    mapping(uint => User) public userData;
    mapping(address => User) public userData2;

    function setData(uint _cnic, string calldata _name, uint8  _age, uint8  _height)external{
        userData[_cnic] = User(_name, _age, _height);
    }
    function getData(uint _cnic)external view returns (string memory, uint8, uint8){
       return (userData[_cnic].name, userData[_cnic].age, userData[_cnic].height); 
    }
    function setAddress(string calldata _name, uint8 _age, uint8 _height) external {
        userData2[msg.sender] = User(_name, _age, _height);
    }
    function getDataStruct(uint _cnic)external view returns (User memory){
       return userData[_cnic]; 
    }
}