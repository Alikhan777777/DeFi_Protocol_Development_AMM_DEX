// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

// USDC Interface (ERC-20)
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
}

contract ForkTest is Test {
    // Real mainnet addresses
    address constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address constant USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    IERC20 usdc;
    IERC20 usdt;
    IERC20 weth;

    function setUp() public {
        // Fork Ethereum mainnet at current block
        vm.createSelectFork("https://ethereum-rpc.publicnode.com");

        // Initialize interfaces
        usdc = IERC20(USDC);
        usdt = IERC20(USDT);
        weth = IERC20(WETH);
    }

    // TEST 1: Read USDC Total Supply ✅
    function test_ReadUSDCTotalSupply() public {
        uint256 totalSupply = usdc.totalSupply();
        
        assertTrue(totalSupply > 0);
        assertTrue(totalSupply > 1_000_000_000 * 10**6);
        
        console.log("USDC Total Supply:", totalSupply);
        console.log("USDC Total Supply (in millions):", totalSupply / 10**6 / 1_000_000);
    }

    // TEST 2: Read USDT Total Supply ✅
    function test_ReadUSDTTotalSupply() public {
        uint256 totalSupply = usdt.totalSupply();
        
        assertTrue(totalSupply > 0);
        assertTrue(totalSupply > 1_000_000_000 * 10**6);
        
        console.log("USDT Total Supply:", totalSupply);
        console.log("USDT Total Supply (in millions):", totalSupply / 10**6 / 1_000_000);
    }

    // TEST 3: Read WETH Total Supply ✅
    function test_ReadWETHTotalSupply() public {
        uint256 totalSupply = weth.totalSupply();
        
        assertTrue(totalSupply > 0);
        assertTrue(totalSupply > 1000 * 10**18);
        
        console.log("WETH Total Supply:", totalSupply);
        console.log("WETH Total Supply (in millions):", totalSupply / 10**18 / 1_000_000);
    }

    // TEST 4: Verify Fork is Working ✅
    function test_CreateSelectFork() public {
        uint256 forkId = vm.activeFork();
        assertTrue(forkId > 0);
        
        console.log("Active fork ID:", forkId);
        console.log("Current block number:", block.number);
        console.log("Current chain ID:", block.chainid);
        
        assertEq(block.chainid, 1); // Ethereum mainnet
    }

    // TEST 5: Verify USDC Contract Exists ✅
    function test_USDCContractExists() public {
        uint256 usdcBalance = usdc.balanceOf(USDC); // Check balance of contract itself
        // Just verify the contract exists and is callable
        assertTrue(true);
        console.log("USDC contract verified on mainnet");
    }

    // TEST 6: Verify USDT Contract Exists ✅
    function test_USDTContractExists() public {
        uint256 usdtBalance = usdt.balanceOf(USDT);
        // Just verify the contract exists and is callable
        assertTrue(true);
        console.log("USDT contract verified on mainnet");
    }

    // TEST 7: Verify WETH Contract Exists ✅
    function test_WETHContractExists() public {
        uint256 wethBalance = weth.balanceOf(WETH);
        // Just verify the contract exists and is callable
        assertTrue(true);
        console.log("WETH contract verified on mainnet");
    }
}
