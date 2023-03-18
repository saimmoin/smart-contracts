const {
    time,
    loadFixture,
  } = require("@nomicfoundation/hardhat-network-helpers");
  const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
  const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Factory",  () => {
    let factoryContract;
    let tokenContract;

    async function deploy() {
        const Factory = await ethers.getContractFactory("Factory");
        factoryContract = await Factory.deploy();
    }
    async function loadTokenContract(tx) {
        let receipt = await tx.wait()
        let tokenAddress = receipt?.events?.[1]?.args.tokenAddress;    //optional chaining
        return await ethers.getContractAt("myERC20", tokenAddress);

    }

    describe("Testing Contract", () => {
        it("Deploy Tokens", async() => {
            await loadFixture(deploy);
            let receipt = await factoryContract.deployERC20();
            let waiting = await receipt.wait();
            expect(receipt.address).not.to.be.null;
        })
        it('should load ERC20 contract and validate',async () => {
            await loadFixture(deploy);
            let tx = await factoryContract.deployERC20();
            tokenContract = await loadTokenContract(tx);
            expect((await tx.wait()).events[1].args.tokenAddress).is.eq(tokenContract.address)
        })
        it('should mint some tokens', async () => {
            let [Deployer, Owner, Alice] = await ethers.getSigners();
            await loadFixture(deploy);
            let tx = await factoryContract.deployERC20();
            tokenContract = await loadTokenContract(tx);
            tokenContract.connect(Deployer.address).burn(10);
            tokenContract.connect(Deployer.address).mint()
        })

    })
})