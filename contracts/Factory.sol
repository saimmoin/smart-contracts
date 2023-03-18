
//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Factory {

    event Deploy(address tokenAddress, address factoryContract);
    function deployERC20() external {
        myERC20 myToken = new myERC20(1000 * 10 ** 18);
        emit Deploy(address(myToken), address(this));

    }

}


contract myERC20 is ERC20 {
    constructor(uint256 initialSupply) ERC20("Binance Token", "BNB") {
        _mint(msg.sender, initialSupply);
    }

    function mint(address tokenOwner, uint totalSupply) external {
        _mint(tokenOwner, totalSupply * (10 ** 18));
    }

    function burn(uint amount) external {
        _burn(msg.sender, amount);
    }
}