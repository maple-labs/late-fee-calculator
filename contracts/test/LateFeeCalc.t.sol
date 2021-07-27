// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.6.11;

import { DSTest } from "../../modules/ds-test/src/test.sol";

import { LateFeeCalc } from "../LateFeeCalc.sol";

contract LateFeeCalcTest is DSTest {

    function test_calcType() external {
        assertTrue(new LateFeeCalc(999_999).calcType() == uint8(11));
    }

    function test_name() external {
        assertTrue(new LateFeeCalc(999_999).name() == "FLAT");
    }

    function test_lateFee() external {
        assertEq(new LateFeeCalc(999_999).lateFee(), 999_999);
    }

    function test_getLateFee() external {
        LateFeeCalc lateFeeCalc;

        lateFeeCalc = new LateFeeCalc(1);
        assertEq(lateFeeCalc.getLateFee(1),       0);
        assertEq(lateFeeCalc.getLateFee(10),      0);
        assertEq(lateFeeCalc.getLateFee(100),     0);
        assertEq(lateFeeCalc.getLateFee(1_000),   0);
        assertEq(lateFeeCalc.getLateFee(5_000),   0);
        assertEq(lateFeeCalc.getLateFee(10_000),  1);
        assertEq(lateFeeCalc.getLateFee(20_000),  2);
        assertEq(lateFeeCalc.getLateFee(100_000), 10);

        lateFeeCalc = new LateFeeCalc(10);
        assertEq(lateFeeCalc.getLateFee(1),       0);
        assertEq(lateFeeCalc.getLateFee(10),      0);
        assertEq(lateFeeCalc.getLateFee(100),     0);
        assertEq(lateFeeCalc.getLateFee(1_000),   1);
        assertEq(lateFeeCalc.getLateFee(5_000),   5);
        assertEq(lateFeeCalc.getLateFee(10_000),  10);
        assertEq(lateFeeCalc.getLateFee(20_000),  20);
        assertEq(lateFeeCalc.getLateFee(100_000), 100);

        lateFeeCalc = new LateFeeCalc(100);
        assertEq(lateFeeCalc.getLateFee(1),       0);
        assertEq(lateFeeCalc.getLateFee(10),      0);
        assertEq(lateFeeCalc.getLateFee(100),     1);
        assertEq(lateFeeCalc.getLateFee(1_000),   10);
        assertEq(lateFeeCalc.getLateFee(5_000),   50);
        assertEq(lateFeeCalc.getLateFee(10_000),  100);
        assertEq(lateFeeCalc.getLateFee(20_000),  200);
        assertEq(lateFeeCalc.getLateFee(100_000), 1000);

        lateFeeCalc = new LateFeeCalc(1_000);
        assertEq(lateFeeCalc.getLateFee(1),       0);
        assertEq(lateFeeCalc.getLateFee(10),      1);
        assertEq(lateFeeCalc.getLateFee(100),     10);
        assertEq(lateFeeCalc.getLateFee(1_000),   100);
        assertEq(lateFeeCalc.getLateFee(5_000),   500);
        assertEq(lateFeeCalc.getLateFee(10_000),  1000);
        assertEq(lateFeeCalc.getLateFee(20_000),  2000);
        assertEq(lateFeeCalc.getLateFee(100_000), 10000);

        lateFeeCalc = new LateFeeCalc(10_000);
        assertEq(lateFeeCalc.getLateFee(1),       1);
        assertEq(lateFeeCalc.getLateFee(10),      10);
        assertEq(lateFeeCalc.getLateFee(100),     100);
        assertEq(lateFeeCalc.getLateFee(1_000),   1000);
        assertEq(lateFeeCalc.getLateFee(5_000),   5000);
        assertEq(lateFeeCalc.getLateFee(10_000),  10000);
        assertEq(lateFeeCalc.getLateFee(20_000),  20000);
        assertEq(lateFeeCalc.getLateFee(100_000), 100000);
    }

}
