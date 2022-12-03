const { expect } = require("chai");
const hre = require("hardhat");
// const { time } = require("@nomicfoundation/hardhat-network-helpers");

describe("Soul", function () {
  it("Should set right Token Symbol", async function () {

    const Soul1 = await hre.ethers.getContractFactory("Soul1");
    const soul1 = await Soul1.deploy();
    expect(await soul1.symbol()).to.equal("SOUL");
  });
});

describe("Soul", function () {
  it("Should set right Token Symbol", async function () {

    const Soul1 = await hre.ethers.getContractFactory("Soul1");
    const soul1 = await Soul1.deploy();
    expect(await soul1.symbol()).to.equal("SOUL");
  });
});