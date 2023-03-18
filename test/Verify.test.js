const {
    time,
    loadFixture,
  } = require("@nomicfoundation/hardhat-network-helpers");
  const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
  const { expect } = require("chai");
  
describe("Verify", function () {
    let Owner;
    let Theif;
    let verifyContract;
    // We define a fixture to reuse the same setup in every test.
    // We use loadFixture to run this setup once, snapshot that state,
    // and reset Hardhat Network to that snapshot in every test.
    async function deployVerifyFixture() {
  
      // Contracts are deployed using the first signer/account by default
      [Owner,Theif] = await ethers.getSigners();
  
      const Verify = await ethers.getContractFactory("Verify");
      verifyContract = await Verify.deploy();
  
    }
  
    describe("Signature Verification", function () {
      
      it('should verify owner address', async() => {
        await loadFixture(deployVerifyFixture);
        let payloadHash = ethers.utils.solidityKeccak256([ "address", "address", 'uint' ], [Owner.address,Owner.address,1 ]);
        let signature = await Owner.signMessage(ethers.utils.arrayify(payloadHash));
  
        let trueResponse = await verifyContract.verifySignature(Owner.address, Owner.address, 1, signature, Owner.address)
        expect(trueResponse).to.be.true
      })
      it('should not verify Theif signature', async() => {
        await loadFixture(deployVerifyFixture);
        let payloadHash = ethers.utils.solidityKeccak256([ "address", "address", 'uint' ], [Owner.address,Owner.address,1 ]);
        let signature = await Owner.signMessage(ethers.utils.arrayify(payloadHash));
  
        let falseResponse = await verifyContract.verifySignature(Owner.address, Owner.address, 1, signature, Theif.address)
        expect(falseResponse).to.be.false
      })
    });
  });