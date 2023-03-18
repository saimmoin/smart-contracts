require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-ethers");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: "https://quick-palpable-shard.ethereum-goerli.discover.quiknode.pro/db9d6900093b79890d62b9486d9ff8c3b4850ef8/",
      accounts: ["6dced152d4cb969b301ea0cd032f0491058ac1486d08c34e4fc3ed2011dfb940"],
    },
  },  
  etherscan: {
    apiKey: "N4GVQ76ZPVZ2S7V31GWG4CN45F7SXPS3MV",
  },
};
