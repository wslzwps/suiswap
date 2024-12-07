// Copyright 2022 OmniBTC Authors. Licensed under Apache-2.0 License.
module implements::implements {
    use std::string::{Self, String};

    use sui::balance::{Self, Supply, Balance};
    use sui::coin::{Self, Coin};
    use sui::object::{Self, ID, UID, delete};
    use sui::token::value;
    use sui::transfer;
    use std::ascii;


    /// The Pool token that will be used to mark the pool share
    /// of a liquidity provider. The parameter `X` and `Y` is for the
    /// coin held in the pool.
    struct LP<phantom X, phantom Y> has drop, store {}

    /// The pool with exchange.
    struct Pool<phantom X, phantom Y> has store {
        global: ID,
        coin_x: Balance<X>,
        fee_coin_x: Balance<X>,
        coin_y: Balance<Y>,
        fee_coin_y: Balance<Y>,
        lp_supply: Supply<LP<X, Y>>,
        min_liquidity: Balance<LP<X, Y>>,
        has_paused: bool,
        market_address: address,
        burn_address: address,
        free_ratio: u8,
        tax_coin: ascii::String,
    }

    /// Get most used values in a handy way:
    /// - amount of Coin<X>
    /// - amount of Coin<Y>
    /// - total supply of LP<X,Y>
    public fun get_reserves_size<X, Y>(pool: &Pool<X, Y>): (u64, u64, u64) {
        (
            balance::value(&pool.coin_x),
            balance::value(&pool.coin_y),
            balance::supply_value(&pool.lp_supply)
        )
    }

}
