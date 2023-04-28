import { Wallet, utils } from "zksync-web3";
import * as ethers from "ethers";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { Deployer } from "@matterlabs/hardhat-zksync-deploy";
import * as dotenv from 'dotenv';
dotenv.config();

// An example of a deploy script that will deploy and call a simple contract.
export default async function (hre: HardhatRuntimeEnvironment) {
  console.log(`Running deploy script zkSync Era`);
  const wallet = new Wallet(process.env.PRIVATE_KEY);
  const deployer = new Deployer(hre, wallet);
  const artifactFactory = await deployer.loadArtifact("Factory");
  const vestPeriod = "300";
  const factorySC = await deployer.deploy(artifactFactory, [vestPeriod]);
  //obtain the Constructor Arguments
  console.log("constructor args:" + factorySC.interface.encodeDeploy([vestPeriod]));
  const contractAddress = factorySC.address;
  console.log(`${factorySC.contractName} was deployed to ${contractAddress}`);
}
