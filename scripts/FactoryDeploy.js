const hre = require('hardhat');

async function main() {
    const Factory = await hre.ethers.getContractFactory('Factory');
    const factory = await Factory.deploy();
    await factory.deployed();

    console.log("Contract Deployed To: ", factory.address);

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