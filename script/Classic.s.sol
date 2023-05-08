// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

import 'forge-std/Script.sol';
import {IERC20} from '@openzeppelin/contracts/token/ERC20/IERC20.sol';

interface IRouter {
  function addLiquidity(
        IERC20 tokenA,
        IERC20 tokenB,
        address pool,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        uint256[2] memory vReserveRatioBounds,
        address to,
        uint256 deadline
    )
        external
        virtual
        override
        ensure(deadline)
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );
}

contract AddLiq is Script {
  function run() external {
    uint256 deployerPrivateKey = vm.envUint('PRIVATE_KEY');

    address pool = 0xA60Ba5346737F1c7FBD566C8efEec138Be06E6E2;
    address router = 0x161fD047aBf5553676bE54325655940fE2aD69f5;
    address tk1 = 0xB1fe0a5788596CE7e868916873C7D5219bD605Fd;
    address tk2 = 0x1a928903A57e8b57243b8E6A0Aa751935451a618;
    address admin = 0x96202931a23e5349f88D7bCF422AA3e4B811C758;

    vm.startBroadcast(deployerPrivateKey);

    IRouter sc = IRouter(router);

   
    uint256[2] memory vReserveRatioBounds = [0, type(uint256).max];

    
    sc.addLiquidity(
      IERC20(tk1),
      IERC20(tk2),
      pool,
      3000 ether,
      3200 ether,
      0,0,
      vReserveRatioBounds,
      admin,
      type(uint256).max
    );
    vm.stopBroadcast();
  }
}
