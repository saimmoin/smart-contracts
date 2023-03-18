//SPDX-License-Identifier: MIT
pragma solidity  0.8.17;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Token {

    uint public _totalSupply = 0;
    uint public constant _decimals = 18;
    string public _symbol = 'SRB';
    string public _name = 'Sirabi Token';
    address public owner;
    address public dev;

    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;

    event Transfer(address from, address to, uint value);
    event Approved(address from, address to, uint value);

    constructor(address _owner, address _dev){
        // balances[msg.sender] += 1 ether;
        owner = _owner;
        dev = _dev;
    }
    modifier OnlyOwner(){
        require(msg.sender == owner,'Owner mint only');
        _;
    }
    function mint(address _to, uint _value) external OnlyOwner {
        require(_to != address(0), 'ZA');
        require(_value > 0,'ZM');
        balances[_to] += _value;
        _totalSupply += _value;
        emit Transfer(address(0), _to, _value);
    }
    function burn(uint _value) external {
        require(_value > 0, 'NZ');
        require(msg.sender != address(0), '0 address');
        balances[msg.sender] -= _value;
        balances[address(0)] += _value;
        _totalSupply -= _value;
        emit Transfer(msg.sender, address(0), _value);
    }
    function approve(address _to, uint _value) external {
        require(_to != address(0), "ZA");
        require(balances[msg.sender]>= _value,'Insufficient bal');
        allowance[msg.sender][_to] += _value;
        emit Approved(msg.sender, _to, _value);
    }

    function transfer(address _to, uint _value) external {
        require(_to != msg.sender, 'ZA');
        require(balances[msg.sender] >= _value,'Insufficient Bal');
        uint deductedAmount = deductAmount(_value);
        balances[msg.sender] -= _value;
        balances[_to] += deductedAmount;
        emit Transfer(msg.sender, _to, deductedAmount);
    }

    function transferFrom(address _from, address _to, uint _value) external{
        require(
            (balances[msg.sender]>= _value || 
            allowance[_from][msg.sender] > 0 || 
            balances[_from]>= _value) ,
            'not Allowed');
        spendAllowance(_from, _to, _value);
        balances[_from] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
    }

    function spendAllowance(address _owner, address spender, uint _value) internal {
       require(allowance[_owner][spender] >= _value,'insufficient allowance');
        allowance[_owner][spender] -= _value;
    }

    function balanceOf(address user) external view returns (uint) {
        return balances[user];
    }
    function totalSupply() external view returns(uint) {
        return _totalSupply;
    }
    function decimals() external pure returns(uint) {
        return _decimals;
    }
    function name() external view returns(string memory) {
        return _name;
    }
    function symbol() external view returns(string memory) {
        return _symbol;
    }

    function deductAmount(uint _value) private returns(uint){
        uint deductedAmount = (_value * 10) / 100;
        uint fivePercent = deductedAmount / 2;
        balances[owner] += fivePercent;
        balances[dev] += fivePercent;
        emit Transfer(msg.sender, owner, fivePercent);
        emit Transfer(msg.sender, dev, fivePercent);

        return _value - deductedAmount;
    }
    


}
