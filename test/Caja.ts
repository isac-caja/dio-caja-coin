
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import hre from "hardhat"

describe("Caja", () => {

  const deployCajaCoinFixture = async () => {
    const [owner, otherAccount] = await hre.ethers.getSigners();
    const CajaCoin = await hre.ethers.getContractFactory("CajaCoin");
    const contract = await CajaCoin.deploy()
    return { contract, owner, otherAccount }
  }


  describe("totalSuply", async () => {
    it("should return total supply", async () => {
      const { contract } = await loadFixture(deployCajaCoinFixture);
      expect(await contract.totalSupply()).to.equal(10_000_000_000_000_000_000n)
    })
  })

  describe("balanceOf", async () => {
    it("should return balance of owner", async () => {
      const { contract, owner } = await loadFixture(deployCajaCoinFixture);
      expect(await contract.balanceOf(owner.address)).to.equal(10_000_000_000_000_000_000n)
    })
  })

  describe("transfer", async () => {
    it("should transfer coins from owner to otherAccount", async () => {
      const { contract, owner, otherAccount } = await loadFixture(deployCajaCoinFixture);
      const approve = await contract.connect(owner).approve(owner.address, 10_000_000n)
      const tx = await contract.connect(owner).transfer(otherAccount.address, 9_000_000n)
      expect(await contract.balanceOf(owner.address)).to.equal(9_999_999_999_991_000_000n)
      expect(await contract.balanceOf(otherAccount.address)).to.equal(9_000_000n)
    })
    
    it("should emit Approve event", async () => {
      const { contract, owner } = await loadFixture(deployCajaCoinFixture);
      const approve = await contract.connect(owner).approve(owner.address, 10_000_000n)
      expect(approve).to.emit(contract, "Approve")
    })
    
  })

})