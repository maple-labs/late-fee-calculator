pragma solidity ^0.6.7;

import "ds-test/test.sol";

import "./LateFeeCalculator.sol";

contract LateFeeCalculatorTest is DSTest {
    LateFeeCalculator calculator;

    function setUp() public {
        calculator = new LateFeeCalculator();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
