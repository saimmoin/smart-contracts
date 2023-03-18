const { ethers } = require('hardhat');
const hre = require('hardhat');

async function main() {

    let factoryAddress = "0x6358358d70c6Ff7B342529120c111D4B7C4e8CEc";
    const factory = await ethers.getContractAt("Factory", factoryAddress);
    console.log(factory, factory.address)

    const erc20 = await factory.deployERC20()
    console.log(erc20)

}

const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };

runMain();