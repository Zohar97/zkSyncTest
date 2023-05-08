            
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




            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: BUSL-1.1
pragma solidity >=0.6.12;

////import './IERC20.sol';

interface IDMMPool {
  function mint(address to) external returns (uint256 liquidity);

  function burn(address to) external returns (uint256 amount0, uint256 amount1);

  function swap(
    uint256 amount0Out,
    uint256 amount1Out,
    address to,
    bytes calldata data
  ) external;

  function sync() external;

  function getReserves() external view returns (uint112 reserve0, uint112 reserve1);

  function getTradeInfo()
    external
    view
    returns (
      uint112 _vReserve0,
      uint112 _vReserve1,
      uint112 reserve0,
      uint112 reserve1,
      uint256 feeInPrecision
    );

  function token0() external view returns (IERC20);

  function token1() external view returns (IERC20);

  function ampBps() external view returns (uint32);

  function factory() external view returns (address);

  function kLast() external view returns (uint256);
}




            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT
// OpenZeppelin Contracts (last updated v4.6.0) (utils/math/SafeMath.sol)

pragma solidity ^0.8.0;

// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}




            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT

pragma solidity 0.8.9;

interface ICamelotPair {
  function getReserves()
    external
    view
    returns (
      uint112 reserve0,
      uint112 reserve1,
      uint16 token0feePercent,
      uint16 token1FeePercent
    );
}


            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT

pragma solidity 0.8.9;

interface IVelodromePair {
  function token0() external view returns (address);

  function reserve0() external view returns (uint256);

  function reserve1() external view returns (uint256);

  function getAmountOut(uint256, address) external view returns (uint256);

  function swap(
    uint256 amount0Out,
    uint256 amount1Out,
    address to,
    bytes calldata data
  ) external;
}




            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: GPL-2.0-or-later
pragma solidity >=0.5.0;

/// @title The swap interface for a Kyber ProMM Pool
interface IProMMPool {
  /// @notice Swap token0 -> token1, or vice versa
  /// @dev This method's caller receives a callback in the form of ISwapCallback#swapCallback
  /// @dev swaps will execute up to limitSqrtP or swapQty is fully used
  /// @param recipient The address to receive the swap output
  /// @param swapQty The swap quantity, which implicitly configures the swap as exact input (>0), or exact output (<0)
  /// @param isToken0 Whether the swapQty is specified in token0 (true) or token1 (false)
  /// @param limitSqrtP the limit of sqrt price after swapping
  /// could be MAX_SQRT_RATIO-1 when swapping 1 -> 0 and MIN_SQRT_RATIO+1 when swapping 0 -> 1 for no limit swap
  /// @param data Any data to be passed through to the callback
  /// @return qty0 Exact token0 qty sent to recipient if < 0. Minimally received quantity if > 0.
  /// @return qty1 Exact token1 qty sent to recipient if < 0. Minimally received quantity if > 0.
  function swap(
    address recipient,
    int256 swapQty,
    bool isToken0,
    uint160 limitSqrtP,
    bytes calldata data
  ) external returns (int256 qty0, int256 qty1);
}



            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: GPL-2.0-or-later
pragma solidity >=0.5.0;

/// @title The interface for a Uniswap V3 Pool
/// @notice A Uniswap pool facilitates swapping and automated market making between any two assets that strictly conform
/// to the ERC20 specification
/// @dev The pool interface is broken up into many smaller pieces
interface IUniswapV3Pool {
  /// @notice Swap token0 for token1, or token1 for token0
  /// @dev The caller of this method receives a callback in the form of IUniswapV3SwapCallback#uniswapV3SwapCallback
  /// @param recipient The address to receive the output of the swap
  /// @param zeroForOne The direction of the swap, true for token0 to token1, false for token1 to token0
  /// @param amountSpecified The amount of the swap, which implicitly configures
  /// the swap as exact input (positive), or exact output (negative)
  /// @param sqrtPriceLimitX96 The Q64.96 sqrt price limit. If zero for one, the price cannot be less than this
  /// value after the swap. If one for zero, the price cannot be greater than this value after the swap
  /// @param data Any data to be passed through to the callback
  /// @return amount0 The delta of the balance of token0 of the pool, exact when negative, minimum when positive
  /// @return amount1 The delta of the balance of token1 of the pool, exact when negative, minimum when positive
  function swap(
    address recipient,
    bool zeroForOne,
    int256 amountSpecified,
    uint160 sqrtPriceLimitX96,
    bytes calldata data
  ) external returns (int256 amount0, int256 amount1);
}




            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT

pragma solidity >=0.7.6;
pragma abicoder v2;

interface IRFQ {
  struct OrderRFQ {
    // lowest 64 bits is the order id, next 64 bits is the expiration timestamp
    // highest bit is unwrap WETH flag which is set on taker's side
    // [unwrap eth(1 bit) | unused (127 bits) | expiration timestamp(64 bits) | orderId (64 bits)]
    uint256 info;
    address makerAsset;
    address takerAsset;
    address maker;
    address allowedSender; // null address on public orders
    uint256 makingAmount;
    uint256 takingAmount;
  }

  /// @notice Fills an order's quote, either fully or partially
  /// @dev Funds will be sent to msg.sender
  /// @param order Order quote to fill
  /// @param signature Signature to confirm quote ownership
  /// @param makingAmount Maker amount
  /// @param takingAmount Taker amount
  function fillOrderRFQ(
    OrderRFQ memory order,
    bytes calldata signature,
    uint256 makingAmount,
    uint256 takingAmount
  )
    external
    payable
    returns (
      uint256, /* actualmakingAmount */
      uint256 /* actualtakingAmount */
    );

  /// @notice Main function for fulfilling orders
  /// @param order Order quote to fill
  /// @param signature Signature to confirm quote ownership
  /// @param makingAmount Maker amount
  /// @param takingAmount Taker amount
  /// @param target Address that will receive swapped funds
  function fillOrderRFQTo(
    OrderRFQ memory order,
    bytes calldata signature,
    uint256 makingAmount,
    uint256 takingAmount,
    address payable target
  )
    external
    payable
    returns (
      uint256, /* actualmakingAmount */
      uint256 /* actualtakingAmount */
    );
}




            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT

pragma solidity >=0.5.16;

interface IFireBirdPair {
  event Approval(address indexed owner, address indexed spender, uint256 value);
  event Transfer(address indexed from, address indexed to, uint256 value);

  function name() external view returns (string memory);

  function symbol() external view returns (string memory);

  function decimals() external pure returns (uint8);

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

  function DOMAIN_SEPARATOR() external view returns (bytes32);

  function PERMIT_TYPEHASH() external pure returns (bytes32);

  function nonces(address owner) external view returns (uint256);

  function permit(
    address owner,
    address spender,
    uint256 value,
    uint256 deadline,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external;

  event PaidProtocolFee(uint112 collectedFee0, uint112 collectedFee1);
  event Mint(address indexed sender, uint256 amount0, uint256 amount1);
  event Burn(address indexed sender, uint256 amount0, uint256 amount1, address indexed to);
  event Swap(
    address indexed sender,
    uint256 amount0In,
    uint256 amount1In,
    uint256 amount0Out,
    uint256 amount1Out,
    address indexed to
  );
  event Sync(uint112 reserve0, uint112 reserve1);

  function MINIMUM_LIQUIDITY() external pure returns (uint256);

  function factory() external view returns (address);

  function token0() external view returns (address);

  function token1() external view returns (address);

  function getReserves()
    external
    view
    returns (
      uint112 reserve0,
      uint112 reserve1,
      uint32 blockTimestampLast
    );

  function getCollectedFees() external view returns (uint112 _collectedFee0, uint112 _collectedFee1);

  function getTokenWeights() external view returns (uint32 tokenWeight0, uint32 tokenWeight1);

  function getSwapFee() external view returns (uint32);

  function price0CumulativeLast() external view returns (uint256);

  function price1CumulativeLast() external view returns (uint256);

  function mint(address to) external returns (uint256 liquidity);

  function burn(address to) external returns (uint256 amount0, uint256 amount1);

  function swap(
    uint256 amount0Out,
    uint256 amount1Out,
    address to,
    bytes calldata data
  ) external;

  function skim(address to) external;

  function sync() external;

  function initialize(
    address,
    address,
    uint32,
    uint32
  ) external;
}




            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT

pragma solidity 0.8.9;

interface IKyberLimitOrder {
  struct Order {
    uint256 salt;
    address makerAsset;
    address takerAsset;
    address maker;
    address receiver;
    address allowedSender; // equals to Zero address on public orders
    uint256 makingAmount;
    uint256 takingAmount;
    address feeRecipient;
    uint32 makerTokenFeePercent;
    bytes makerAssetData;
    bytes takerAssetData;
    bytes getMakerAmount; // this.staticcall(abi.encodePacked(bytes, swapTakerAmount)) => (swapMakerAmount)
    bytes getTakerAmount; // this.staticcall(abi.encodePacked(bytes, swapMakerAmount)) => (swapTakerAmount)
    bytes predicate; // this.staticcall(bytes) => (bool)
    bytes permit; // On first fill: permit.1.call(abi.encodePacked(permit.selector, permit.2))
    bytes interaction;
  }

  struct FillBatchOrdersParams {
    Order[] orders;
    bytes[] signatures;
    uint256 takingAmount;
    uint256 thresholdAmount;
    address target;
  }

  function fillBatchOrdersTo(FillBatchOrdersParams memory params)
    external
    returns (
      uint256, /* actualMakingAmount */
      uint256 /* actualTakingAmount */
    );

  function getMakerAmount(
    uint256 orderMakerAmount,
    uint256 orderTakerAmount,
    uint256 swapTakerAmount
  ) external pure returns (uint256);

  function getTakerAmount(
    uint256 orderMakerAmount,
    uint256 orderTakerAmount,
    uint256 swapMakerAmount
  ) external pure returns (uint256);

  function hashOrder(Order memory order) external view returns (bytes32);
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

pragma solidity >=0.6.12;

////import '@openzeppelin/contracts/utils/math/SafeMath.sol';
////import '../interfaces/IERC20.sol';
////import '../interfaces/IDMMPool.sol';

library DMMLibrary {
  using SafeMath for uint256;

  uint256 public constant PRECISION = 1e18;

  // returns sorted token addresses, used to handle return values from pools sorted in this order
  function sortTokens(IERC20 tokenA, IERC20 tokenB) internal pure returns (IERC20 token0, IERC20 token1) {
    require(tokenA != tokenB, 'DMMLibrary: IDENTICAL_ADDRESSES');
    (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
    require(address(token0) != address(0), 'DMMLibrary: ZERO_ADDRESS');
  }

  /// @dev fetch the reserves and fee for a pool, used for trading purposes
  function getTradeInfo(
    address pool,
    IERC20 tokenA,
    IERC20 tokenB
  )
    internal
    view
    returns (
      uint256 reserveA,
      uint256 reserveB,
      uint256 vReserveA,
      uint256 vReserveB,
      uint256 feeInPrecision
    )
  {
    (IERC20 token0, ) = sortTokens(tokenA, tokenB);
    uint256 reserve0;
    uint256 reserve1;
    uint256 vReserve0;
    uint256 vReserve1;
    (reserve0, reserve1, vReserve0, vReserve1, feeInPrecision) = IDMMPool(pool).getTradeInfo();
    (reserveA, reserveB, vReserveA, vReserveB) = tokenA == token0
      ? (reserve0, reserve1, vReserve0, vReserve1)
      : (reserve1, reserve0, vReserve1, vReserve0);
  }

  /// @dev fetches the reserves for a pool, used for liquidity adding
  function getReserves(
    address pool,
    IERC20 tokenA,
    IERC20 tokenB
  ) internal view returns (uint256 reserveA, uint256 reserveB) {
    (IERC20 token0, ) = sortTokens(tokenA, tokenB);
    (uint256 reserve0, uint256 reserve1) = IDMMPool(pool).getReserves();
    (reserveA, reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
  }

  // given some amount of an asset and pool reserves, returns an equivalent amount of the other asset
  function quote(
    uint256 amountA,
    uint256 reserveA,
    uint256 reserveB
  ) internal pure returns (uint256 amountB) {
    require(amountA > 0, 'DMMLibrary: INSUFFICIENT_AMOUNT');
    require(reserveA > 0 && reserveB > 0, 'DMMLibrary: INSUFFICIENT_LIQUIDITY');
    amountB = amountA.mul(reserveB) / reserveA;
  }

  // given an input amount of an asset and pool reserves, returns the maximum output amount of the other asset
  function getAmountOut(
    uint256 amountIn,
    uint256 reserveIn,
    uint256 reserveOut,
    uint256 vReserveIn,
    uint256 vReserveOut,
    uint256 feeInPrecision
  ) internal pure returns (uint256 amountOut) {
    require(amountIn > 0, 'DMMLibrary: INSUFFICIENT_INPUT_AMOUNT');
    require(reserveIn > 0 && reserveOut > 0, 'DMMLibrary: INSUFFICIENT_LIQUIDITY');
    uint256 amountInWithFee = amountIn.mul(PRECISION.sub(feeInPrecision)).div(PRECISION);
    uint256 numerator = amountInWithFee.mul(vReserveOut);
    uint256 denominator = vReserveIn.add(amountInWithFee);
    amountOut = numerator.div(denominator);
    require(reserveOut > amountOut, 'DMMLibrary: INSUFFICIENT_LIQUIDITY');
  }

  // given an output amount of an asset and pool reserves, returns a required input amount of the other asset
  function getAmountIn(
    uint256 amountOut,
    uint256 reserveIn,
    uint256 reserveOut,
    uint256 vReserveIn,
    uint256 vReserveOut,
    uint256 feeInPrecision
  ) internal pure returns (uint256 amountIn) {
    require(amountOut > 0, 'DMMLibrary: INSUFFICIENT_OUTPUT_AMOUNT');
    require(reserveIn > 0 && reserveOut > amountOut, 'DMMLibrary: INSUFFICIENT_LIQUIDITY');
    uint256 numerator = vReserveIn.mul(amountOut);
    uint256 denominator = vReserveOut.sub(amountOut);
    amountIn = numerator.div(denominator).add(1);
    // amountIn = floor(amountIN *PRECISION / (PRECISION - feeInPrecision));
    numerator = amountIn.mul(PRECISION);
    denominator = PRECISION.sub(feeInPrecision);
    amountIn = numerator.add(denominator - 1).div(denominator);
  }

  // performs chained getAmountOut calculations on any number of pools
  function getAmountsOut(
    uint256 amountIn,
    address[] memory poolsPath,
    IERC20[] memory path
  ) internal view returns (uint256[] memory amounts) {
    amounts = new uint256[](path.length);
    amounts[0] = amountIn;
    for (uint256 i; i < path.length - 1; i++) {
      (
        uint256 reserveIn,
        uint256 reserveOut,
        uint256 vReserveIn,
        uint256 vReserveOut,
        uint256 feeInPrecision
      ) = getTradeInfo(poolsPath[i], path[i], path[i + 1]);
      amounts[i + 1] = getAmountOut(amounts[i], reserveIn, reserveOut, vReserveIn, vReserveOut, feeInPrecision);
    }
  }

  // performs chained getAmountIn calculations on any number of pools
  function getAmountsIn(
    uint256 amountOut,
    address[] memory poolsPath,
    IERC20[] memory path
  ) internal view returns (uint256[] memory amounts) {
    amounts = new uint256[](path.length);
    amounts[amounts.length - 1] = amountOut;
    for (uint256 i = path.length - 1; i > 0; i--) {
      (
        uint256 reserveIn,
        uint256 reserveOut,
        uint256 vReserveIn,
        uint256 vReserveOut,
        uint256 feeInPrecision
      ) = getTradeInfo(poolsPath[i - 1], path[i - 1], path[i]);
      amounts[i - 1] = getAmountIn(amounts[i], reserveIn, reserveOut, vReserveIn, vReserveOut, feeInPrecision);
    }
  }
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



            
////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT
// OpenZeppelin Contracts v4.4.1 (utils/math/SafeCast.sol)

pragma solidity ^0.8.0;

/**
 * @dev Wrappers over Solidity's uintXX/intXX casting operators with added overflow
 * checks.
 *
 * Downcasting from uint256/int256 in Solidity does not revert on overflow. This can
 * easily result in undesired exploitation or bugs, since developers usually
 * assume that overflows raise errors. `SafeCast` restores this intuition by
 * reverting the transaction when such an operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 *
 * Can be combined with {SafeMath} and {SignedSafeMath} to extend it to smaller types, by performing
 * all math on `uint256` and `int256` and then downcasting.
 */
library SafeCast {
    /**
     * @dev Returns the downcasted uint224 from uint256, reverting on
     * overflow (when the input is greater than largest uint224).
     *
     * Counterpart to Solidity's `uint224` operator.
     *
     * Requirements:
     *
     * - input must fit into 224 bits
     */
    function toUint224(uint256 value) internal pure returns (uint224) {
        require(value <= type(uint224).max, "SafeCast: value doesn't fit in 224 bits");
        return uint224(value);
    }

    /**
     * @dev Returns the downcasted uint128 from uint256, reverting on
     * overflow (when the input is greater than largest uint128).
     *
     * Counterpart to Solidity's `uint128` operator.
     *
     * Requirements:
     *
     * - input must fit into 128 bits
     */
    function toUint128(uint256 value) internal pure returns (uint128) {
        require(value <= type(uint128).max, "SafeCast: value doesn't fit in 128 bits");
        return uint128(value);
    }

    /**
     * @dev Returns the downcasted uint96 from uint256, reverting on
     * overflow (when the input is greater than largest uint96).
     *
     * Counterpart to Solidity's `uint96` operator.
     *
     * Requirements:
     *
     * - input must fit into 96 bits
     */
    function toUint96(uint256 value) internal pure returns (uint96) {
        require(value <= type(uint96).max, "SafeCast: value doesn't fit in 96 bits");
        return uint96(value);
    }

    /**
     * @dev Returns the downcasted uint64 from uint256, reverting on
     * overflow (when the input is greater than largest uint64).
     *
     * Counterpart to Solidity's `uint64` operator.
     *
     * Requirements:
     *
     * - input must fit into 64 bits
     */
    function toUint64(uint256 value) internal pure returns (uint64) {
        require(value <= type(uint64).max, "SafeCast: value doesn't fit in 64 bits");
        return uint64(value);
    }

    /**
     * @dev Returns the downcasted uint32 from uint256, reverting on
     * overflow (when the input is greater than largest uint32).
     *
     * Counterpart to Solidity's `uint32` operator.
     *
     * Requirements:
     *
     * - input must fit into 32 bits
     */
    function toUint32(uint256 value) internal pure returns (uint32) {
        require(value <= type(uint32).max, "SafeCast: value doesn't fit in 32 bits");
        return uint32(value);
    }

    /**
     * @dev Returns the downcasted uint16 from uint256, reverting on
     * overflow (when the input is greater than largest uint16).
     *
     * Counterpart to Solidity's `uint16` operator.
     *
     * Requirements:
     *
     * - input must fit into 16 bits
     */
    function toUint16(uint256 value) internal pure returns (uint16) {
        require(value <= type(uint16).max, "SafeCast: value doesn't fit in 16 bits");
        return uint16(value);
    }

    /**
     * @dev Returns the downcasted uint8 from uint256, reverting on
     * overflow (when the input is greater than largest uint8).
     *
     * Counterpart to Solidity's `uint8` operator.
     *
     * Requirements:
     *
     * - input must fit into 8 bits.
     */
    function toUint8(uint256 value) internal pure returns (uint8) {
        require(value <= type(uint8).max, "SafeCast: value doesn't fit in 8 bits");
        return uint8(value);
    }

    /**
     * @dev Converts a signed int256 into an unsigned uint256.
     *
     * Requirements:
     *
     * - input must be greater than or equal to 0.
     */
    function toUint256(int256 value) internal pure returns (uint256) {
        require(value >= 0, "SafeCast: value must be positive");
        return uint256(value);
    }

    /**
     * @dev Returns the downcasted int128 from int256, reverting on
     * overflow (when the input is less than smallest int128 or
     * greater than largest int128).
     *
     * Counterpart to Solidity's `int128` operator.
     *
     * Requirements:
     *
     * - input must fit into 128 bits
     *
     * _Available since v3.1._
     */
    function toInt128(int256 value) internal pure returns (int128) {
        require(value >= type(int128).min && value <= type(int128).max, "SafeCast: value doesn't fit in 128 bits");
        return int128(value);
    }

    /**
     * @dev Returns the downcasted int64 from int256, reverting on
     * overflow (when the input is less than smallest int64 or
     * greater than largest int64).
     *
     * Counterpart to Solidity's `int64` operator.
     *
     * Requirements:
     *
     * - input must fit into 64 bits
     *
     * _Available since v3.1._
     */
    function toInt64(int256 value) internal pure returns (int64) {
        require(value >= type(int64).min && value <= type(int64).max, "SafeCast: value doesn't fit in 64 bits");
        return int64(value);
    }

    /**
     * @dev Returns the downcasted int32 from int256, reverting on
     * overflow (when the input is less than smallest int32 or
     * greater than largest int32).
     *
     * Counterpart to Solidity's `int32` operator.
     *
     * Requirements:
     *
     * - input must fit into 32 bits
     *
     * _Available since v3.1._
     */
    function toInt32(int256 value) internal pure returns (int32) {
        require(value >= type(int32).min && value <= type(int32).max, "SafeCast: value doesn't fit in 32 bits");
        return int32(value);
    }

    /**
     * @dev Returns the downcasted int16 from int256, reverting on
     * overflow (when the input is less than smallest int16 or
     * greater than largest int16).
     *
     * Counterpart to Solidity's `int16` operator.
     *
     * Requirements:
     *
     * - input must fit into 16 bits
     *
     * _Available since v3.1._
     */
    function toInt16(int256 value) internal pure returns (int16) {
        require(value >= type(int16).min && value <= type(int16).max, "SafeCast: value doesn't fit in 16 bits");
        return int16(value);
    }

    /**
     * @dev Returns the downcasted int8 from int256, reverting on
     * overflow (when the input is less than smallest int8 or
     * greater than largest int8).
     *
     * Counterpart to Solidity's `int8` operator.
     *
     * Requirements:
     *
     * - input must fit into 8 bits.
     *
     * _Available since v3.1._
     */
    function toInt8(int256 value) internal pure returns (int8) {
        require(value >= type(int8).min && value <= type(int8).max, "SafeCast: value doesn't fit in 8 bits");
        return int8(value);
    }

    /**
     * @dev Converts an unsigned uint256 into a signed int256.
     *
     * Requirements:
     *
     * - input must be less than or equal to maxInt256.
     */
    function toInt256(uint256 value) internal pure returns (int256) {
        // Note: Unsafe cast below is okay because `type(int256).max` is guaranteed to be positive
        require(value <= uint256(type(int256).max), "SafeCast: value doesn't fit in an int256");
        return int256(value);
    }
}



////// SPDX-License-Identifier-FLATTEN-SUPPRESS-WARNING: MIT

pragma solidity 0.8.9;

////import '@openzeppelin/contracts/utils/math/SafeCast.sol';

////import '../libraries/TransferHelper.sol';
////import '../libraries/DMMLibrary.sol';

////import '../interfaces/IERC20.sol';
////import '../interfaces/IWETH.sol';
////import '../interfaces/IKyberLimitOrder.sol';
////import '../interfaces/IFireBirdPair.sol';
////import '../interfaces/IRFQ.sol';
////import '../interfaces/IUniswapV3Pool.sol';
////import '../interfaces/IProMMPool.sol';
////import '../interfaces/IVelodromePair.sol';
////import '../interfaces/ICamelotPair.sol';


interface IZkSyncExecutorHelper {
  event Exchange(address pair, uint256 amountOut, address output);

  struct KyberLimitOrder {
    address kyberLOAddress;
    address makerAsset;
    address takerAsset;
    IKyberLimitOrder.FillBatchOrdersParams params;
  }

  struct UniSwap {
    address pool;
    address tokenIn;
    address tokenOut;
    address recipient;
    uint256 collectAmount; // amount that should be transferred to the pool
    uint256 limitReturnAmount;
    uint32 swapFee;
    uint32 feePrecision;
    uint32 tokenWeightInput;
  }

  struct KyberRFQ {
    address rfq;
    bytes order;
    bytes signature;
    uint256 amount;
    address payable target;
  }

  struct UniSwapV3ProMM {
    address recipient;
    address pool;
    address tokenIn;
    address tokenOut;
    uint256 swapAmount;
    uint256 limitReturnAmount;
    uint160 sqrtPriceLimitX96;
    bool isUniV3; // true = UniV3, false = ProMM
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
}

contract ZkSyncExecutorHelper is IZkSyncExecutorHelper {
  using SafeCast for uint256;

  address public immutable WETH;

  bytes32 public constant POOL_SWAP_CACHED_SLOT = keccak256('POOL_SWAP_CACHED_SLOT');

  address private constant ETH_ADDRESS = address(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);

  /// @dev The minimum value that can be returned from #getSqrtRatioAtTick. Equivalent to getSqrtRatioAtTick(MIN_TICK)
  uint160 internal constant MIN_SQRT_RATIO = 4295128739;
  /// @dev The maximum value that can be returned from #getSqrtRatioAtTick. Equivalent to getSqrtRatioAtTick(MAX_TICK)
  uint160 internal constant MAX_SQRT_RATIO = 1461446703485210103287273052203988822378723970342;

  /// @notice Initialize contract states
  /// @param _WETH Address of the WrapNativeToken contract
  constructor(address _WETH) {
    WETH = _WETH;
  }

  function executeUniSwap(
    uint256 index,
    bytes memory data,
    uint256 previousAmountOut
  ) external payable returns (uint256 tokenAmountOut) {
    UniSwap memory uniSwap = abi.decode(data, (UniSwap));
    // no need to transfer if the collectAmount is set to 0

    uniSwap.collectAmount = uniSwap.collectAmount == 0
      ? 0
      : getSwapAmount(index, previousAmountOut, uniSwap.tokenIn, uniSwap.collectAmount);

    tokenAmountOut = _swapSingleSupportFeeOnTransferTokens(uniSwap);
  }

  function executeUniV3ProMMSwap(
    uint256 index,
    bytes memory data,
    uint256 previousAmountOut
  ) external payable returns (uint256 tokenAmountOut) {
    UniSwapV3ProMM memory uniSwapV3ProMM = abi.decode(data, (UniSwapV3ProMM));
    uniSwapV3ProMM.swapAmount = getSwapAmount(
      index,
      previousAmountOut,
      uniSwapV3ProMM.tokenIn,
      uniSwapV3ProMM.swapAmount
    );

    SwapCallbackDataPath memory swapCallbackDataPath = SwapCallbackDataPath(
      uniSwapV3ProMM.pool,
      uniSwapV3ProMM.tokenIn,
      uniSwapV3ProMM.tokenOut
    );
    SwapCallbackData memory swapCallbackData = SwapCallbackData({
      path: abi.encode(swapCallbackDataPath),
      payer: address(this)
    });

    address poolSwapCached = uniSwapV3ProMM.pool;
    bytes32 slot = POOL_SWAP_CACHED_SLOT;
    assembly {
      sstore(slot, poolSwapCached)
    }

    uint256 amountOutput;
    int256 amount0;
    int256 amount1;
    bool swapDirection = uniSwapV3ProMM.tokenIn < uniSwapV3ProMM.tokenOut;
    address recipient = uniSwapV3ProMM.recipient == address(0) ? address(this) : uniSwapV3ProMM.recipient;
    uint256 balanceBefore = IERC20(uniSwapV3ProMM.tokenOut).balanceOf(recipient);
    if (uniSwapV3ProMM.isUniV3) {
      (amount0, amount1) = IUniswapV3Pool(uniSwapV3ProMM.pool).swap(
        recipient,
        swapDirection,
        uniSwapV3ProMM.swapAmount.toInt256(),
        uniSwapV3ProMM.sqrtPriceLimitX96 == 0
          ? (swapDirection ? MIN_SQRT_RATIO + 1 : MAX_SQRT_RATIO - 1)
          : uniSwapV3ProMM.sqrtPriceLimitX96,
        abi.encode(swapCallbackData)
      );
    } else {
      (amount0, amount1) = IProMMPool(uniSwapV3ProMM.pool).swap(
        recipient,
        uniSwapV3ProMM.swapAmount.toInt256(),
        swapDirection,
        uniSwapV3ProMM.sqrtPriceLimitX96 == 0
          ? (swapDirection ? MIN_SQRT_RATIO + 1 : MAX_SQRT_RATIO - 1)
          : uniSwapV3ProMM.sqrtPriceLimitX96,
        abi.encode(swapCallbackData)
      );
    }

    amountOutput = uint256(-(swapDirection ? amount1 : amount0));
    emit Exchange(uniSwapV3ProMM.pool, amountOutput, uniSwapV3ProMM.tokenOut);

    tokenAmountOut = IERC20(uniSwapV3ProMM.tokenOut).balanceOf(recipient) - balanceBefore;
    require(tokenAmountOut >= uniSwapV3ProMM.limitReturnAmount, 'Router: INSUFFICIENT_OUTPUT_AMOUNT');
  }

  function executeKyberDMMSwap(
    uint256 index,
    bytes memory data,
    uint256 previousAmountOut
  ) external payable returns (uint256 tokenAmountOut) {
    UniSwap memory kyberDMMSwap = abi.decode(data, (UniSwap));
    // no need to transfer if the collectAmount is set to 0
    kyberDMMSwap.collectAmount = kyberDMMSwap.collectAmount == 0
      ? 0
      : getSwapAmount(index, previousAmountOut, kyberDMMSwap.tokenIn, kyberDMMSwap.collectAmount);

    tokenAmountOut = _swapKyberDMMSupportFeeOnTransferTokens(kyberDMMSwap);
  }

  function executeRfqSwap(
    uint256 index,
    bytes memory data,
    uint256 previousAmountOut
  ) external payable returns (uint256 tokenAmountOut) {
    KyberRFQ memory kyberRFQ;
    {
      // can't use the KyberRFQ struct for decoding because of bytes type
      // hence must explicitly specify types and assign to variable
      (address rfq, bytes memory order, bytes memory signature, uint256 amount, address payable target) = abi.decode(
        data,
        (address, bytes, bytes, uint256, address)
      );
      kyberRFQ.rfq = rfq;
      kyberRFQ.order = order;
      kyberRFQ.signature = signature;
      kyberRFQ.amount = amount;
      kyberRFQ.target = target;
    }
    IRFQ.OrderRFQ memory orderRFQ = abi.decode(kyberRFQ.order, (IRFQ.OrderRFQ));
    uint256 balanceBefore = IERC20(orderRFQ.makerAsset).balanceOf(kyberRFQ.target);
    uint256 actualTakerAmount = getSwapAmount(index, previousAmountOut, orderRFQ.takerAsset, kyberRFQ.amount);
    TransferHelper.safeApprove(orderRFQ.takerAsset, kyberRFQ.rfq, actualTakerAmount);
    IRFQ(kyberRFQ.rfq).fillOrderRFQTo(orderRFQ, kyberRFQ.signature, 0, actualTakerAmount, kyberRFQ.target);
    tokenAmountOut = IERC20(orderRFQ.makerAsset).balanceOf(kyberRFQ.target) - balanceBefore;

    emit Exchange(kyberRFQ.rfq, tokenAmountOut, orderRFQ.makerAsset);
  }

  /// @notice Execute the KyberLimitOrder
  /// @param index Index of this pool in the route
  /// @param data Execution data
  /// @param previousAmountOut Previous amountOut to calculate the amountIn of this execution.
  function executeKyberLimitOrder(
    uint256 index,
    bytes memory data,
    uint256 previousAmountOut
  ) external payable returns (uint256 tokenAmountOut) {
    KyberLimitOrder memory kyberLO = abi.decode(data, (KyberLimitOrder));

    kyberLO.params.takingAmount = getSwapAmount(
      index,
      previousAmountOut,
      kyberLO.takerAsset,
      kyberLO.params.takingAmount
    );
    kyberLO.params.target = kyberLO.params.target == address(0) ? address(this) : kyberLO.params.target;

    TransferHelper.safeApprove(kyberLO.takerAsset, kyberLO.kyberLOAddress, kyberLO.params.takingAmount);

    (tokenAmountOut, ) = IKyberLimitOrder(kyberLO.kyberLOAddress).fillBatchOrdersTo(kyberLO.params);

    emit Exchange(kyberLO.kyberLOAddress, tokenAmountOut, kyberLO.kyberLOAddress);
  }

  function executeVelodromeSwap(
    uint256 index,
    bytes memory data,
    uint256 previousAmountOut
  ) external payable returns (uint256 tokenAmountOut) {
    UniSwap memory velodrome = abi.decode(data, (UniSwap));

    velodrome.collectAmount = velodrome.collectAmount == 0
      ? 0
      : getSwapAmount(index, previousAmountOut, velodrome.tokenIn, velodrome.collectAmount);

    if (velodrome.collectAmount > 0) {
      TransferHelper.safeTransfer(velodrome.tokenIn, velodrome.pool, velodrome.collectAmount);
    }

    uint256 reserveTokenIn = velodrome.tokenIn == IVelodromePair(velodrome.pool).token0()
      ? IVelodromePair(velodrome.pool).reserve0()
      : IVelodromePair(velodrome.pool).reserve1();

    uint256 amountIn = IERC20(velodrome.tokenIn).balanceOf(velodrome.pool) - reserveTokenIn;
    tokenAmountOut = IVelodromePair(velodrome.pool).getAmountOut(amountIn, velodrome.tokenIn);

    address recipient = velodrome.recipient == address(0) ? address(this) : velodrome.recipient;

    velodrome.tokenIn < velodrome.tokenOut
      ? IVelodromePair(velodrome.pool).swap(uint256(0), tokenAmountOut, recipient, new bytes(0))
      : IVelodromePair(velodrome.pool).swap(tokenAmountOut, uint256(0), recipient, new bytes(0));

    emit Exchange(velodrome.pool, tokenAmountOut, velodrome.tokenOut);
  }

  function executeCamelotSwap(
    uint256 index,
    bytes memory data,
    uint256 previousAmountOut
  ) external payable returns (uint256 tokenAmountOut) {
    UniSwap memory camelot = abi.decode(data, (UniSwap));

    camelot.collectAmount = camelot.collectAmount == 0
      ? 0
      : getSwapAmount(index, previousAmountOut, camelot.tokenIn, camelot.collectAmount);

    if (camelot.collectAmount > 0) {
      TransferHelper.safeTransfer(camelot.tokenIn, camelot.pool, camelot.collectAmount);
    }

    (uint112 _reserve0, uint112 _reserve1, , ) = ICamelotPair(camelot.pool).getReserves();

    uint256 reserveTokenIn = camelot.tokenIn < camelot.tokenOut ? _reserve0 : _reserve1;

    uint256 amountIn = IERC20(camelot.tokenIn).balanceOf(camelot.pool) - reserveTokenIn;
    tokenAmountOut = IVelodromePair(camelot.pool).getAmountOut(amountIn, camelot.tokenIn);

    address recipient = camelot.recipient == address(0) ? address(this) : camelot.recipient;

    camelot.tokenIn < camelot.tokenOut
      ? IVelodromePair(camelot.pool).swap(uint256(0), tokenAmountOut, recipient, new bytes(0))
      : IVelodromePair(camelot.pool).swap(tokenAmountOut, uint256(0), recipient, new bytes(0));

    emit Exchange(camelot.pool, tokenAmountOut, camelot.tokenOut);
  }

  function _swapSingleSupportFeeOnTransferTokens(UniSwap memory swapData) internal returns (uint256 tokenAmountOut) {
    if (swapData.collectAmount > 0) {
      TransferHelper.safeTransfer(swapData.tokenIn, swapData.pool, swapData.collectAmount);
    }

    uint256 amountOutput;

    {
      (uint256 reserveInput, uint256 reserveOutput, ) = IFireBirdPair(swapData.pool).getReserves();
      if (swapData.tokenIn == IFireBirdPair(swapData.pool).token1()) {
        (reserveInput, reserveOutput) = (reserveOutput, reserveInput);
      }
      uint256 amountInput = IERC20(swapData.tokenIn).balanceOf(swapData.pool) - reserveInput;

      amountOutput = getAmountOut(
        amountInput,
        reserveInput,
        reserveOutput,
        swapData.swapFee,
        swapData.feePrecision
      );
    }

    address recipient = swapData.recipient == address(0) ? address(this) : swapData.recipient;
    uint256 balanceBefore = IERC20(swapData.tokenOut).balanceOf(recipient);

    if (swapData.tokenIn == IFireBirdPair(swapData.pool).token0()) {
      IFireBirdPair(swapData.pool).swap(0, amountOutput, recipient, new bytes(0));
    } else {
      IFireBirdPair(swapData.pool).swap(amountOutput, 0, recipient, new bytes(0));
    }

    emit Exchange(swapData.pool, amountOutput, swapData.tokenOut);

    tokenAmountOut = IERC20(swapData.tokenOut).balanceOf(recipient) - balanceBefore;
    require(tokenAmountOut >= swapData.limitReturnAmount, 'Router: INSUFFICIENT_OUTPUT_AMOUNT');
  }

  function _swapKyberDMMSupportFeeOnTransferTokens(UniSwap memory swapData) internal returns (uint256 tokenAmountOut) {
    if (swapData.collectAmount > 0) {
      TransferHelper.safeTransfer(swapData.tokenIn, swapData.pool, swapData.collectAmount);
    }

    uint256 amountOutput;
    {
      // scope to avoid stack too deep errors
      (
        uint256 reserveIn,
        uint256 reserveOut,
        uint256 vReserveIn,
        uint256 vReserveOut,
        uint256 feeInPrecision
      ) = DMMLibrary.getTradeInfo(swapData.pool, IERC20(swapData.tokenIn), IERC20(swapData.tokenOut));
      uint256 amountInput = IERC20(swapData.tokenIn).balanceOf(address(swapData.pool)) - reserveIn;
      amountOutput = DMMLibrary.getAmountOut(
        amountInput,
        reserveIn,
        reserveOut,
        vReserveIn,
        vReserveOut,
        feeInPrecision
      );
    }
    address recipient = swapData.recipient == address(0) ? address(this) : swapData.recipient;

    uint256 balanceBefore = IERC20(swapData.tokenOut).balanceOf(recipient);
    if (swapData.tokenIn == IFireBirdPair(swapData.pool).token0()) {
      IFireBirdPair(swapData.pool).swap(0, amountOutput, recipient, new bytes(0));
    } else {
      IFireBirdPair(swapData.pool).swap(amountOutput, 0, recipient, new bytes(0));
    }
    emit Exchange(swapData.pool, amountOutput, swapData.tokenOut);

    tokenAmountOut = IERC20(swapData.tokenOut).balanceOf(recipient) - balanceBefore;
    require(tokenAmountOut >= swapData.limitReturnAmount, 'Router: INSUFFICIENT_OUTPUT_AMOUNT');
  }

  /// @notice Returns the swap amount for a execution
  /// @param index Index of this execution in the route. If the index > 0, the swapAmount = previousAmountOut
  /// @param previousAmountOut Previous amountOut
  /// @param tokenSwap Address of the tokenIn
  /// @param amountIn TokenIn amount
  function getSwapAmount(
    uint256 index,
    uint256 previousAmountOut,
    address tokenSwap,
    uint256 amountIn
  ) internal view returns (uint256) {
    uint256 _currentBalance = getBalance(tokenSwap);

    // tokens may have been transferred directly to the pool in case of uni type
    if (_currentBalance == 0) return 0;
    if (index > 0) {
      // Makes sure that on the second swap the output of the first was used
      // so there is not intermediate token leftover
      return previousAmountOut;
    } else {
      // if current balance less than swap amount, use less (in case of deflating token)
      if (amountIn > _currentBalance) {
        return _currentBalance;
      }
    }
    return amountIn;
  }

  /// @notice Returns the token balance of this contract. If the token is a native token, return the WrapNativeToken (WETH) balance
  /// @param token Address of a token
  function getBalance(address token) internal view returns (uint256) {
    if (isETH(token)) {
      return IWETH(WETH).balanceOf(address(this));
    } else {
      return IERC20(token).balanceOf(address(this));
    }
  }

  /// @notice Returns the token balance of this contract. If the token is a native token, return the NativeToken (ETH) balance
  /// @param token Address of a token
  function getBalanceNative(address token) internal view returns (uint256) {
    if (isETH(token)) {
      return address(this).balance;
    } else {
      return IERC20(token).balanceOf(address(this));
    }
  }

  /// @notice Transfer a token from this contract to a recipient. Unwrap if needed.
  /// @param token Address of a token
  /// @param to Address of the recipient
  /// @param amount Transferred amount
  /// @param needUnwrap If the token is the WrapNativeToken (WETH), can choose unwrap it or not
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

  /// @notice Checks a token if a NativeToken (ETH) or not
  /// @param token Address of a token
  function isETH(address token) internal pure returns (bool) {
    return (token == ETH_ADDRESS);
  }

  function getAmountOut(
    uint256 amountIn,
    uint256 reserveIn,
    uint256 reserveOut,
    uint32 swapFee,
    uint32 feePrecision
  ) public pure returns (uint256 amountOut) {
    // validate input
    require(amountIn > 0, 'INSUFFICIENT_INPUT_AMOUNT');
    require(reserveIn > 0 && reserveOut > 0, 'INSUFFICIENT_LIQUIDITY');
    uint256 amountInWithFee = amountIn * (feePrecision - swapFee);

    // special case for equal weights
    return reserveOut * amountInWithFee / (reserveIn * feePrecision + amountInWithFee);
  }
}

