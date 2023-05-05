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
  const WETH = '0x36fE8F80Cb53925709a9B12e45D36CfC6C8E5be3';


  // ========== bridge goerli to zksync era testnet ==========
  // const depositHandle = await deployer.zkWallet.deposit({
  //   to: deployer.zkWallet.address,
  //   token: utils.ETH_ADDRESS,
  //   amount: '7000000000000000000',
  // });
  // await depositHandle.wait();
  // ========== end bridge ==========


  // const MetaAggregationRouterV2 = await deployer.loadArtifact("MetaAggregationRouterV2");
  // let sc = await deployer.deploy(MetaAggregationRouterV2, [WETH]);
  // console.log(`MetaAggregationRouterV2 was deployed at ${sc.address}`);

  // const AggregationExecutor = await deployer.loadArtifact("AggregationExecutor");
  // let ex = await deployer.deploy(AggregationExecutor, [WETH]);
  // console.log(`AggregationExecutor was deployed at ${ex.address}`);

  const KyberFormula = await deployer.loadArtifact("KyberFormula");
  let gasLimit = await deployer.estimateDeployGas(KyberFormula, []);

  // let formula = await deployer.deploy(KyberFormula, [], {
  //   customData: {
  //     gasPerPubdata: 50000,
  //   },
  //   gasLimit: gasLimit,
  //   maxPriorityFeePerGas: '0',
  // });
  // console.log(`KyberFormula was deployed at ${formula.address}`);

  // const ExecutorHelper1 = await deployer.loadArtifact("ExecutorHelper1");
  // let ex1 = await deployer.deploy(ExecutorHelper1, [formula.address]);
  // console.log(`ExecutorHelper1 was deployed at ${ex1.address}`);

  // const ExecutorHelper2 = await deployer.loadArtifact("ExecutorHelper2");
  // let ex2 = await deployer.deploy(ExecutorHelper2, [formula.address]);
  // console.log(`ExecutorHelper2 was deployed at ${ex2.address}`);


}
