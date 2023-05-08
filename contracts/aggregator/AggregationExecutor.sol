            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}




            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT

pragma solidity >=0.6.12;

interface IHashflow {
  enum RFQType {
    TAKER,
    MAKER
  }

  struct Quote {
    RFQType rfqType;
    address pool;
    address eoa;
    address trader;
    address effectiveTrader;
    address baseToken;
    address quoteToken;
    uint256 effectiveBaseTokenAmount;
    uint256 maxBaseTokenAmount;
    uint256 maxQuoteTokenAmount;
    uint256 fees;
    uint256 quoteExpiry;
    uint256 nonce;
    bytes32 txid;
    bytes signedQuote;
  }

  function tradeSingleHop(Quote memory quote) external payable;
}




            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT
// OpenZeppelin Contracts v4.4.1 (access/Ownable.sol)

pragma solidity ^0.8.0;

////import "../utils/Context.sol";

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}




            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT

pragma solidity >=0.7.6;

pragma abicoder v2;

////import './IHashflow.sol';

interface IMultihopRouter {
  event Exchange(address pair, uint256 amountOut, address output);
  struct Swap {
    bytes data;
    bytes4 functionSelector;
  }

  struct SwapCallbackData {
    bytes path;
    address payer;
  }
  struct SwapCallbackDataPath {
    address pool;
    address tokenIn;
    address tokenOut;
  }

  function WETH() external view returns (address);

  function multihopBatchSwapExactIn(
    Swap[][] memory swapSequences,
    address tokenIn,
    address tokenOut,
    uint256 minTotalAmountOut,
    address to,
    uint256 deadline,
    bytes memory destTokenFeeData
  ) external payable returns (uint256 totalAmountOut);
}





            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT

pragma solidity >=0.6.12;

interface IAggregationExecutor {
  function callBytes(bytes calldata data) external payable; // 0xd9c45357

  // callbytes per swap sequence
  function swapSingleSequence(bytes calldata data) external;

  function finalTransactionProcessing(
    address tokenIn,
    address tokenOut,
    address to,
    bytes calldata destTokenFeeData
  ) external;
}




            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT

pragma solidity >=0.5.0;

interface IWETH {
  function deposit() external payable;

  function transfer(address to, uint256 value) external returns (bool);

  function withdraw(uint256) external;

  function balanceOf(address account) external view returns (uint256);
}




            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT

pragma solidity >=0.5.16;

interface IERC20 {
  event Approval(address indexed owner, address indexed spender, uint256 value);
  event Transfer(address indexed from, address indexed to, uint256 value);

  function name() external view returns (string memory);

  function symbol() external view returns (string memory);

  function decimals() external view returns (uint8);

  function totalSupply() external view returns (uint256);

  function balanceOf(address owner) external view returns (uint256);

  function allowance(address owner, address spender) external view returns (uint256);

  function approve(address spender, uint256 value) external returns (bool);

  function transfer(address to, uint256 value) external returns (bool);

  function transferFrom(
    address from,
    address to,
    uint256 value
  ) external returns (bool);
}




            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: GPL-3.0-or-later

pragma solidity >=0.5.16;

// helper methods for interacting with ERC20 tokens and sending ETH that do not consistently return true/false
library TransferHelper {
  function safeApprove(
    address token,
    address to,
    uint256 value
  ) internal {
    // bytes4(keccak256(bytes('approve(address,uint256)')));
    (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));
    require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: APPROVE_FAILED');
  }

  function safeTransfer(
    address token,
    address to,
    uint256 value
  ) internal {
    // bytes4(keccak256(bytes('transfer(address,uint256)')));
    if (value == 0) return;
    (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
    require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FAILED');
  }

  function safeTransferFrom(
    address token,
    address from,
    address to,
    uint256 value
  ) internal {
    // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
    if (value == 0) return;
    (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
    require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FROM_FAILED');
  }

  function safeTransferETH(address to, uint256 value) internal {
    if (value == 0) return;
    (bool success, ) = to.call{value: value}(new bytes(0));
    require(success, 'TransferHelper: ETH_TRANSFER_FAILED');
  }
}




            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: GPL-3.0-or-later

pragma solidity >=0.7.6;

/*
“Copyright (c) 2019-2021 1inch 
Permission is hereby granted, free of charge, to any person obtaining a copy of this software
and associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions: 
The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software. 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE”.
*/

library RevertReasonParser {
  function parse(bytes memory data, string memory prefix) internal pure returns (string memory) {
    // https://solidity.readthedocs.io/en/latest/control-structures.html#revert
    // We assume that revert reason is abi-encoded as Error(string)

    // 68 = 4-byte selector 0x08c379a0 + 32 bytes offset + 32 bytes length
    if (data.length >= 68 && data[0] == '\x08' && data[1] == '\xc3' && data[2] == '\x79' && data[3] == '\xa0') {
      string memory reason;
      // solhint-disable no-inline-assembly
      assembly {
        // 68 = 32 bytes data length + 4-byte selector + 32 bytes offset
        reason := add(data, 68)
      }
      /*
                revert reason is padded up to 32 bytes with ABI encoder: Error(string)
                also sometimes there is extra 32 bytes of zeros padded in the end:
                https://github.com/ethereum/solidity/issues/10170
                because of that we can't check for equality and instead check
                that string length + extra 68 bytes is less than overall data length
            */
      require(data.length >= 68 + bytes(reason).length, 'Invalid revert reason');
      return string(abi.encodePacked(prefix, 'Error(', reason, ')'));
    }
    // 36 = 4-byte selector 0x4e487b71 + 32 bytes integer
    else if (data.length == 36 && data[0] == '\x4e' && data[1] == '\x48' && data[2] == '\x7b' && data[3] == '\x71') {
      uint256 code;
      // solhint-disable no-inline-assembly
      assembly {
        // 36 = 32 bytes data length + 4-byte selector
        code := mload(add(data, 36))
      }
      return string(abi.encodePacked(prefix, 'Panic(', _toHex(code), ')'));
    }

    return string(abi.encodePacked(prefix, 'Unknown(', _toHex(data), ')'));
  }

  function _toHex(uint256 value) private pure returns (string memory) {
    return _toHex(abi.encodePacked(value));
  }

  function _toHex(bytes memory data) private pure returns (string memory) {
    bytes16 alphabet = 0x30313233343536373839616263646566;
    bytes memory str = new bytes(2 + data.length * 2);
    str[0] = '0';
    str[1] = 'x';
    for (uint256 i = 0; i < data.length; i++) {
      str[2 * i + 2] = alphabet[uint8(data[i] >> 4)];
      str[2 * i + 3] = alphabet[uint8(data[i] & 0x0f)];
    }
    return string(str);
  }
}



////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT

pragma solidity 0.8.9;

////import './libraries/RevertReasonParser.sol';
////import './libraries/TransferHelper.sol';

////import './interfaces/IERC20.sol';
////import './interfaces/IWETH.sol';
////import './interfaces/IAggregationExecutor.sol';
////import './interfaces/IMultihopRouter.sol';

////import '@openzeppelin/contracts/access/Ownable.sol';

contract AggregationExecutor is IAggregationExecutor, IMultihopRouter, Ownable {
  address private constant ETH_ADDRESS = address(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);
  uint16 internal constant BPS = 10000;

  address public immutable WETH;
  bytes32 public constant POOL_SWAP_CACHED_SLOT = keccak256('POOL_SWAP_CACHED_SLOT');

  mapping(bytes4 => address) public executorOf;

  // fee data in case taking in dest token
  struct DestTokenFeeData {
    address feeReceiver;
    bool isInBps; // true if taking the fee in percentage, with 100% is 1 BPS
    uint256 feeAmount; // in bps unit or in dest token unit
  }

  struct SwapExecutorDescription {
    Swap[][] swapSequences;
    address tokenIn;
    address tokenOut;
    uint256 minTotalAmountOut;
    address to;
    uint256 deadline;
    bytes destTokenFeeData;
  }

  modifier ensure(uint256 deadline) {
    require(deadline >= block.timestamp, 'Router: EXPIRED');
    _;
  }

  constructor(address _WETH) {
    WETH = _WETH;
  }

  receive() external payable {}

  function rescueFunds(address token, uint256 amount) external onlyOwner {
    if (isETH(token)) {
      TransferHelper.safeTransferETH(msg.sender, amount);
    } else {
      TransferHelper.safeTransfer(token, msg.sender, amount);
    }
  }

  // **** SWAP ****
  function callBytes(bytes calldata data) external payable override {
    SwapExecutorDescription memory swapExecutorDescription = abi.decode(data, (SwapExecutorDescription));

    multihopBatchSwapExactIn(
      swapExecutorDescription.swapSequences,
      swapExecutorDescription.tokenIn,
      swapExecutorDescription.tokenOut,
      swapExecutorDescription.minTotalAmountOut,
      swapExecutorDescription.to,
      swapExecutorDescription.deadline,
      swapExecutorDescription.destTokenFeeData
    );
  }

  function multihopBatchSwapExactIn(
    Swap[][] memory swapSequences,
    address tokenIn,
    address tokenOut,
    uint256 minTotalAmountOut,
    address to,
    uint256 deadline,
    bytes memory destTokenFeeData
  ) public payable virtual override ensure(deadline) returns (uint256 totalAmountOut) {
    if (isETH(tokenIn)) {
      IWETH(WETH).deposit{value: msg.value}();
    }

    uint256 balanceBefore;
    if (!isETH(tokenOut)) {
      balanceBefore = IERC20(tokenOut).balanceOf(to);
    }

    for (uint256 i = 0; i < swapSequences.length; i++) {
      uint256 tokenAmountOut;
      for (uint256 k = 0; k < swapSequences[i].length; k++) {
        tokenAmountOut = _swapSinglePool(swapSequences[i][k], k, tokenAmountOut);
      }

      // This takes the amountOut of the last swap
      totalAmountOut = tokenAmountOut + totalAmountOut;
    }

    uint256 tokenOutBalance = getBalance(tokenOut);
    // make only one unwrap
    if (isETH(tokenOut)) IWETH(WETH).withdraw(tokenOutBalance);

    if (destTokenFeeData.length > 0) {
      // taking fee in dest token, assume tokenOut should have been transferred to this Executor first
      DestTokenFeeData memory feeData = abi.decode(destTokenFeeData, (DestTokenFeeData));
      feeData.feeAmount = feeData.feeReceiver == address(0) ? 0 : feeData.isInBps
        ? (feeData.feeAmount * totalAmountOut) / BPS
        : feeData.feeAmount;
      totalAmountOut -= feeData.feeAmount;
      tokenOutBalance -= feeData.feeAmount;
      transferToken(tokenOut, feeData.feeReceiver, feeData.feeAmount, false);
    }
    transferToken(tokenOut, to, tokenOutBalance, false);
    transferToken(tokenIn, to, getBalance(tokenIn), true);

    if (isETH(tokenOut)) {
      require(totalAmountOut >= minTotalAmountOut, 'ERR_LIMIT_OUT');
    } else {
      require(IERC20(tokenOut).balanceOf(to) - balanceBefore >= minTotalAmountOut, '<minTotalAmountOut');
    }
  }

  // Swap a single sequence, only works when:
  // 1. the tokenIn is not the native token
  // 2. the first pool of each sequence should be able to receive the token before calling swap
  function swapSingleSequence(bytes calldata data) external override {
    Swap[] memory swapData = abi.decode(data, (Swap[]));
    // the first pool must be able to receive the token before calling swap func,
    // i.e: UNI, DMM types

    uint256 tokenAmountOut;
    for (uint256 i = 0; i < swapData.length; i++) {
      tokenAmountOut = _swapSinglePool(swapData[i], i, tokenAmountOut);
    }
  }

  // finalize all information after swap
  // in case taking fee in dest token, transfer fee to the fee receiver
  function finalTransactionProcessing(
    address tokenIn,
    address tokenOut,
    address to,
    bytes calldata destTokenFeeData
  ) external override {
    uint256 tokenOutBalance = getBalance(tokenOut);
    // make only one unwrap
    if (isETH(tokenOut)) IWETH(WETH).withdraw(tokenOutBalance);

    if (destTokenFeeData.length > 0) {
      // taking fee in dest token, assume tokenOut should have been transferred to this Executor first
      DestTokenFeeData memory feeData = abi.decode(destTokenFeeData, (DestTokenFeeData));
      feeData.feeAmount = feeData.feeReceiver == address(0) ? 0 : feeData.isInBps
        ? (feeData.feeAmount * tokenOutBalance) / BPS
        : feeData.feeAmount;
      tokenOutBalance -= feeData.feeAmount;
      transferToken(tokenOut, feeData.feeReceiver, feeData.feeAmount, false);
    }

    transferToken(tokenOut, to, tokenOutBalance, false);
    transferToken(tokenIn, to, getBalance(tokenIn), true);
  }

  function _swapSinglePool(
    Swap memory swap,
    uint256 index,
    uint256 tokenAmountOut
  ) internal virtual returns (uint256) {
    bytes4 functionSelector = swap.functionSelector;
    address executor = executorOf[functionSelector];
    require(executor != address(0), "AggregationExecutor: Executor for dex doesn't existed");

    (bool success, bytes memory returnData) = executor.delegatecall(
      abi.encodePacked(functionSelector, abi.encode(index, swap.data, tokenAmountOut))
    );

    if (!success) {
      revert(RevertReasonParser.parse(returnData, 'swapSinglePool failed: '));
    }
    return abi.decode(returnData, (uint256));
  }

  function updateExecutor(bytes4 functionSelector, address executor) external onlyOwner {
    executorOf[functionSelector] = executor;
  }

  function updateBatchExecutors(bytes4[] memory functionSelectors, address[] memory executors) external onlyOwner {
    require(functionSelectors.length == executors.length, 'invalid length');
    for (uint256 i = 0; i < functionSelectors.length; ++i) {
      executorOf[functionSelectors[i]] = executors[i];
    }
  }

  // **** CALLBACK ****
  function uniswapV3SwapCallback(
    int256 amount0Delta,
    int256 amount1Delta,
    bytes calldata _data
  ) external {
    _handleSwapCallback(amount0Delta, amount1Delta, _data);
  }

  function swapCallback(
    int256 deltaQty0,
    int256 deltaQty1,
    bytes calldata data
  ) external {
    _handleSwapCallback(deltaQty0, deltaQty1, data);
  }

  function _handleSwapCallback(
    int256 amount0Delta,
    int256 amount1Delta,
    bytes calldata _data
  ) internal {
    require(amount0Delta > 0 || amount1Delta > 0); // swaps entirely within 0-liquidity regions are not supported

    bytes32 poolSwapCached;
    bytes32 slot = POOL_SWAP_CACHED_SLOT;
    assembly {
      poolSwapCached := sload(slot)
    }
    require(msg.sender == address(uint160(uint256(poolSwapCached))), 'Router: invalid sender callback');

    SwapCallbackData memory data = abi.decode(_data, (SwapCallbackData));
    SwapCallbackDataPath memory dataPath = abi.decode(data.path, (SwapCallbackDataPath));

    uint256 amountToPay = amount0Delta > 0 ? uint256(amount0Delta) : uint256(amount1Delta);
    // pay with tokens already in the contract (for the exact input multihop case)
    TransferHelper.safeTransfer(dataPath.tokenIn, msg.sender, amountToPay);
  }

  // **** HELPER ****
  function transferToken(
    address token,
    address to,
    uint256 amount,
    bool needUnwrap
  ) internal {
    if (amount == 0) return;
    if (isETH(token)) {
      if (needUnwrap) IWETH(WETH).withdraw(amount);
      TransferHelper.safeTransferETH(to, amount);
    } else {
      TransferHelper.safeTransfer(token, to, amount);
    }
  }

  function getBalance(address token) internal view returns (uint256) {
    if (isETH(token)) {
      return IWETH(WETH).balanceOf(address(this));
    } else {
      return IERC20(token).balanceOf(address(this));
    }
  }

  function isETH(address token) internal pure returns (bool) {
    return (token == ETH_ADDRESS);
  }
}

