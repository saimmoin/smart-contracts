const {
    time,
    loadFixture,
  } = require("@nomicfoundation/hardhat-network-helpers");
  const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
  const { expect } = require("chai");
const { ethers } = require("hardhat");
  
describe("Verify", function () {
    let Owner;
    let Dev;
    let User1;
    let User2;
    let tokenContract;
    // We define a fixture to reuse the same setup in every test.
    // We use loadFixture to run this setup once, snapshot that state,
    // and reset Hardhat Network to that snapshot in every test.
    async function deployVerifyFixture() {
  
      // Contracts are deployed using the first signer/account by default
      [Owner, Dev, User1, User2] = await ethers.getSigners();
  
      const Token = await ethers.getContractFactory("Token");
      tokenContract = await Token.deploy(Owner.address, Dev.address);

    //   console.log(tokenContract)
  
    }
  
    describe("Deducting 10% from the value transfered", function () {
      
      it('Transfering 5% to owners account', async() => {
        await loadFixture(deployVerifyFixture);
  
        const HUNDRED =  ethers.utils.parseUnits("100", "ether");
        const FIVER_PERCENT = ethers.BigNumber.from('5000000000000000000');
        await tokenContract.connect(Owner).mint(User1.address, HUNDRED)
        
        const BeforeBalanceOwner = await tokenContract.balanceOf(Owner.address);
        const BeforeBalanceDev = await tokenContract.balanceOf(Dev.address);

         await tokenContract.connect(User1).transfer(User2.address, HUNDRED)

        let AfterBalanceOwner = await tokenContract.balanceOf(Owner.address);
        let AfterBalanceDev = await tokenContract.balanceOf(Dev.address);
        let AfterBalanceUser1 = await tokenContract.balanceOf(User1.address);
        let AfterBalanceUser2 = await tokenContract.balanceOf(User2.address);

        expect(AfterBalanceOwner).to.be.eq(BeforeBalanceOwner.add(FIVER_PERCENT))
        expect(AfterBalanceDev).to.be.eq(BeforeBalanceDev.add(FIVER_PERCENT))
        expect(AfterBalanceUser1).to.be.eq(0);
        expect(AfterBalanceUser2).to.be.eq(ethers.utils.parseUnits("90", "ether"));

        

      })
    //   it('should not verify Theif signature', async() => {
    //     await loadFixture(deployVerifyFixture);
    //     let payloadHash = ethers.utils.solidityKeccak256([ "address", "address", 'uint' ], [Owner.address,Owner.address,1 ]);
    //     let signature = await Owner.signMessage(ethers.utils.arrayify(payloadHash));
  
    //     let falseResponse = await tokenContract.verifySignature(Owner.address, Owner.address, 1, signature, Theif.address)
    //     expect(falseResponse).to.be.false
    //   })
    });
  });