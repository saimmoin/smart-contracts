//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract TodoList {
    struct Todo {
        string header;
        bool iscomp;
        uint time;
    }
    uint public count = 0;

    Todo[] public todoArr;

    // address => id => Todo
    mapping(address => mapping(uint => Todo)) public userTodo;
    // mapping(uint => User) public userData;

    // function addTodo(string calldata _header, bool _iscomp, uint _time) external {
    //     todoArr.push()
    // }
    function addUserTodo(string calldata _header) external {
        userTodo[msg.sender][count] = Todo(_header, false, block.timestamp);
        count ++;
    }

    function getUserTodo(uint _todoID) external view returns (Todo memory){
        return userTodo[msg.sender][_todoID];
    }

    function updateUserTodo(uint _todoID, string calldata _header, bool _iscomp) external {
        userTodo[msg.sender][_todoID].header = _header;
        userTodo[msg.sender][_todoID].iscomp = _iscomp;
    }
    /**
    * contractInstance.addUserTodo({"name",false,new Date()})
     */


}