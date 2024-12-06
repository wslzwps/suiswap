# Sui-AMM-swap

The first open source AMM swap on the [Sui](https://github.com/MystenLabs).

## [Audit Report](https://movebit.xyz/file/Sui-AMM-swap-Contracts-Audit-Report.pdf)
This code has been audited by MoveBit professional auditing company. 
Audit report click [here](https://github.com/OmniBTC/Sui-AMM-swap/blob/main/Sui-AMM-swap%20Contracts%20Audit%20Report%20(5).pdf)

## cmd for tests
```bash
$ issue XBTC and USDT test coins
XBTC="0x985c26f5edba256380648d4ad84b202094a4ade3::coins::XBTC"
USDT="0x985c26f5edba256380648d4ad84b202094a4ade3::coins::USDT"
SUI="0x2::sui::SUI"

$ sui client publish --gas-budget 10000
package=0xc6f8ce30d96bb9b728e000be94e25cab1a6011d1
global=0x28ae932ee07d4a0881e4bd24f630fe7b0d18a332

$ sui client objects
sui_coin=0x525c0eb0e1f4d8744ae21984de2e8a089366a557
usdt_coin=0x8e81c2362ff1e7101b2ef2a0d1ff9b3c358a1ac9

$ sui client call --gas-budget 10000 \
  --package=$package \
  --module=interface \
  --function=add_liquidity \
  --args $global $sui_coin 1 $usdt_coin 1 \
  --type-args $SUI $USDT
  
lp_sui_usdt=0xdf622fddc8447b0c1d15f8418e010933dd5f0a6c 
pool_sui_usdt=0x5058b90e728df97c4cb5cade5e5c77fcb662a4b9

$ sui client split-coin --gas-budget 10000 \
  --coin-id $lp_sui_usdt \
  --amounts 100000
  
lp_sui_usdt2=0x6cde2fe9277c92e196585fb12c6e3d5aaa4eab34

$ sui client call --gas-budget 10000 \
  --package=$package \
  --module=interface \
  --function=remove_liquidity \
  --args $global $lp_sui_usdt2 \
  --type-args $SUI $USDT

new_usdt_coin=0xc090e45f9461e39abb0452cf3ec297a40efbfdc3
new_sui_coin=0x9c8c1cc38cc61a94264911933c69a772ced07a09

# sui -> usdt
$ sui client call --gas-budget 10000 \
  --package=$package \
  --module=interface \
  --function=swap \
  --args $global $new_sui_coin 1  \
  --type-args $SUI $USDT
  
out_usdt_coin=0x80076d95c8bd1d5a0f97b537669008a1a369ce12

# usdt -> sui
sui client call --gas-budget 10000 \
  --package=$package \
  --module=interface \
  --function=swap \
  --args $global $out_usdt_coin 1 \
  --type-args $USDT $SUI

out_sui_coin=0xaa89836115e1e1a4f5fa990ebd2c7be3a5124d07


$ sui client call --gas-budget 10000 \
  --package=$package \
  --module=interface \
  --function=add_liquidity \
  --args $global $out_sui_coin 100 $new_usdt_coin 1000 \
  --type-args $SUI $USDT
```

sui client call --gas-budget 1000000000 `
--package=0xb83a428af0d053d01b3f235fc5ee69d10bb03feaa9931c17421bb6c854d3005c `
--module=interface `
--function=add_liquidity `
--args 0xa9c5bc03443f96ea3e9fab8a12a68b0370a901d56f676668d7aaa85d39d3a04f 0x5406e4e66382b9a58a4002158dd4eb9e32103016d15a324815bab67af788e4ab `
100000000 0xd0b1f91e1baf56faf7ae4f20faa75681b0e8a7daa3f81340a046fcb1604faf7e 100000000 `
--type-args 0xc02235cd1004933d654a15d58cee67c34f80e7e97d188adf05a938fd76347181::zy::ZY 0xd0b1f91e1baf56faf7ae4f20faa75681b0e8a7daa3f81340a046fcb1604faf7e::usdt::USDT



sui client call --gas-budget 1000000000 \
--package=0xa689c79801e951c89fb8c726718565b69ea73573226331b304821f13dbe10780 \
--module=interface \
--function=add_liquidity \
--args 0xa9c5bc03443f96ea3e9fab8a12a68b0370a901d56f676668d7aaa85d39d3a04f 0x5406e4e66382b9a58a4002158dd4eb9e32103016d15a324815bab67af788e4ab 100000000 0xd0b1f91e1baf56faf7ae4f20faa75681b0e8a7daa3f81340a046fcb1604faf7e::usdt::USDT 100000000 \
--type-args 0xc02235cd1004933d654a15d58cee67c34f80e7e97d188adf05a938fd76347181::zy::ZY 0xd0b1f91e1baf56faf7ae4f20faa75681b0e8a7daa3f81340a046fcb1604faf7e::usdt::USDT


sui client call --gas-budget 1000000000 \
--package=0xa689c79801e951c89fb8c726718565b69ea73573226331b304821f13dbe10780 \
--module=interface \
--function=swap \
--args 0x94699f93a5abfbbca547851d7e486d279c8ab38dea14be14ff4fca06ae6e8c70 0x27dbb05230a106325fdb8b2823789fa24629b61b5eab479d852c24fd59b472a6 0  \
--type-args 0xd0b1f91e1baf56faf7ae4f20faa75681b0e8a7daa3f81340a046fcb1604faf7e::usdt::USDT 0xc02235cd1004933d654a15d58cee67c34f80e7e97d188adf05a938fd76347181::zy::ZY


sui client call --gas-budget 1000000000 \
--package=0xa689c79801e951c89fb8c726718565b69ea73573226331b304821f13dbe10780 \
--module=interface \
--function=remove_liquidity \
--args 0x94699f93a5abfbbca547851d7e486d279c8ab38dea14be14ff4fca06ae6e8c70 0xcc5ee99f9eaace93633549cd4056a65186e9e46a9ff710cc9e0f42cc869f5176
--type-args 0xd0b1f91e1baf56faf7ae4f20faa75681b0e8a7daa3f81340a046fcb1604faf7e::usdt::USDT 0xc02235cd1004933d654a15d58cee67c34f80e7e97d188adf05a938fd76347181::zy::ZY

sui client call --gas-budget 1000000000 \
--package=0x09bd9d584a5c4a33bcecd5098a3a451ae9b5b5ffd059f3ce983b006ef3feb1c4 \
--module=interface \
--function=add_liquidity \
--args 0xca1d5dfdc9611fa55b22db13b1df05ea58a728c22279c1407ac35e9157d71a61 0x5f860a1f3124783efa697532d6191c615124608856e2520eb4a26ff52f1a6ad6::zy::ZY 100000000  0x12964e45403dcec196d214d5d75ddaf27e88f85ef81a852a9e34c2f0d08833cd::usdt::USDT 100000000 \
--type-args 0x5f860a1f3124783efa697532d6191c615124608856e2520eb4a26ff52f1a6ad6::zy::ZY 0x12964e45403dcec196d214d5d75ddaf27e88f85ef81a852a9e34c2f0d08833cd::usdt::USDT


