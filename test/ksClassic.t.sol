// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import {Test} from 'forge-std/Test.sol';
import {console} from 'forge-std/console.sol';

import {IERC20Metadata} from '@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol';

contract KSClassic is Test {
  uint networkFork;

  address USDC = 0xB1fe0a5788596CE7e868916873C7D5219bD605Fd;

  address admin = 0x96202931a23e5349f88D7bCF422AA3e4B811C758;

  function setUp() public {
    networkFork = vm.createFork('https://testnet.era.zksync.dev');
    vm.selectFork(networkFork);
    vm.rollFork(5148802);
    vm.startPrank(admin);
  }

  function testSetUp() public {
    assertGt(admin.balance, 0);
    string memory n = IERC20Metadata(0x36fE8F80Cb53925709a9B12e45D36CfC6C8E5be3).name();
    console.log('hello');
  }

}
