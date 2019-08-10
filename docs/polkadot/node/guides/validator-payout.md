# Validator Payout Overview

## Payout Scheme

Validators are paid for authoring blocks on the relay chain and signing parachain blocks.  Validator payouts occur at the end of every era (on the Alexander testnet, this is approximately once per hour, although this may be modified on Kusama and the Polkadot mainnet). No matter how much stake is behind a validator (by the validator stash itself, as well as by nominators), all validators split the block authoring payout equally.

For example:

```
Validator Set Size (v): 4
Validator 1 Stake (v1): 18 DOTs
Validator 2 Stake (v2): 9 DOTs
Validator 3 Stake (v3): 8 DOTs
Validator 4 Stake (v4): 7 DOT
Payout (p): 8 DOTs

Payout for each validator (v1 - v4):
p / v = 8 / 4 = 2 DOTs
```

Note that this is different than most other proof-of-stake systems such as Cosmos.  As long as a validator is in the validator set, it does not matter how much stake is behind that particular validator, in terms of rewards.  Validator `v1`, with 18 DOTs staked, received the same reward (2 DOTs) in this era as `v4` who had only 7 DOTs staked.

## Running Multiple Validators

It is possible for a single entity to run multiple validators.  It is often to your benefit, as the following examples will show.  Assuming you have enough DOTs, or enough stake nominates your validator, to ensure that your validators remain in the validator set, running multiple validators will result in a higher return than running a single validator.

Assume you have 18 DOTs to stake - for simplicity's sake, we will ignore nominators and assume all validators are taking a 0% cut.  Running a single validator, as in the example above, would net you 2 DOTs in this era.

```
Validator Set Size (v): 4
Validator 1 Stake (v1): 18 DOTs <- Your validator
Validator 2 Stake (v2): 9 DOTs
Validator 3 Stake (v3): 8 DOTs
Validator 4 Stake (v4): 7 DOTs
Payout (p): 8 DOTs

Your payout = (p / v) * 1 = (8 / 4) * 1 = 2
```

Running two validators, and splitting the stake equally, would result in the original validator `v4` to be kicked out of the validator set, as only the top `v` validators (as measured by stake) are selected to be in the validator set.  More importantly, it would also double the amount of rewards that you get from each era.

```
Validator Set Size (v): 4
Validator 1 Stake (v1): 9 DOTs <- Your first validator
Validator 2 Stake (v2): 9 DOTs <- Your second validator
Validator 3 Stake (v3): 9 DOTs
Validator 4 Stake (v4): 8 DOTs
Payout (p): 8 DOTs

Your payout = (p / v) * 1 = (8 / 4) * 2 = 4
```

You may now think, if two validators are good, perhaps three would be better?  However, if you continue to split your stake equally, you will soon find yourself without enough stake to keep yourself in the validator set.  In the following example, assume that there are other potential validators with 6.5 DOTs staked.  If you split your stake equally among all three of your validators (18 / 3 = 6 DOTs), none of your validators can make it into the validator set.  The original `v4`, who had 7 DOTs staked, and another validator who has 6.5 DOTs staked, enter the validator set and none of your validators join.

```
Validator Set Size (v): 4
Validator 1 Stake (v1): 9 DOTs <- (previous v3)
Validator 2 Stake (v2): 8 DOTs <- (previous v4)
Validator 3 Stake (v3): 7 DOTs <- (v4 in original example)
Validator 4 Stake (v4): 6.5 DOTs <- (other validator)
Payout (p): 8 DOTs

Your payout = (p / v) * 1 = (8 / 4) * 0 = 0
```

In this era, you received no payout, since none of your validators were in the validator set.

The incentives of the system favor validators each having similar amounts of stake.  However, this will most likely be a dynamic, rather than static, equilibrium.  Potential validators will run different numbers of validators and apply different amounts of stake to them as time goes on, and in response to the actions of other validators on the network.

## Nominators and Validator Payments

Validators can choose to keep a percentage of their rewards, to "reimburse" themselves for the cost of running a validator node.  Other than that, all rewards are shared equally between the stake behind each validator.  This includes the stake of the validator itself, plus any stake bonded by nominators.  Nominated stake allows you to "vote" for validators and share in the rewards without running a validator node yourself.

In the following examples, we can see the results of several different validator payment schemes and split between nominator and validator stake.  We will assume a single nominator for each validator.  However, there can be numerous nominators for each validator.  Rewards are still distributed proportionally - for example, if the total rewards to be given to nominators is 2 DOTs, and there are four nominators with equal stake bonded, each will receive 0.5 DOTs.  Note also that a single nominator may stake different validators.

Each validator in the example has selected a different validator payment (that is, reward set aside directly for the validator before sharing with all bonded stake).  The percentage of the validator payment is listed in brackets (`[]`) next to each validator.  Note that since the validator payment is public knowledge, having a low or non-existent validator payment may attract more stake from nominators, since they know they will receive a larger percentage of the reward.

```
Validator Set Size (v): 4
Validator 1 Stake (v1) [10%]: 18 DOTs (9 validator, 9 nominator)
Validator 2 Stake (v2) [20%]: 9 DOTs  (3 validator, 6 nominator)
Validator 3 Stake (v3) [5%]: 8 DOTs   (4 validator, 4 nominator)
Validator 4 Stake (v4) [0%]: 6 DOT    (1 validator, 5 nominator)
Payout (p): 8 DOTs

Payout for each validator (v1 - v4):
p / v = 8 / 4 = 2 DOTs

v1:
2 * 0.1 = 0.2 DOTs -> validator payment
(2 - 0.2) = 1.8 -> shared between all stake
(9 / 18) * 1.8 = 0.9 -> validator stake share
(9 / 18) * 1.8 = 0.9 -> nominator stake share
v1 validator total reward: 0.2 + 0.9 = 1.1 DOTs
v1 nominator reward: 0.9 DOTs

v2:
2 * 0.2 = 0.4 DOTs -> validator payment
(2 - 0.4) = 1.6 -> shared between all stake
(3 / 9) * 1.6 = 0.53 -> validator stake share
(6 / 9) * 1.6  = 1.07 -> nominator stake share
v2 validator total reward: 0.4 + 0.53 = 0.93 DOTs
v2 nominator reward: 1.07 DOTs

v3:
2 * 0.05 = 0.1 DOTs -> validator payment
(2 - 0.1) = 1.9 -> shared between all stake
(4 / 8) * 1.9 = 0.95 -> validator stake share
(4 / 8) * 1.9  = 0.95 -> nominator stake share
v3 validator total reward: 0.1 + 0.95 DOTs = 1.05 DOTs
v3 nominator reward: 0.95 DOTs

v4:
2 * 0 = 0 DOTs -> validator payment
(2 - 0) = 2.0 -> shared between all stake
(1 / 6) * 2 =  0.33 -> validator stake share
(5 / 6) * 2  = 1.67 -> nominator stake share
v4 validator total reward: 0 + 0.33 DOTs = 0.33 DOTs
v4 nominator reward: 1.67 DOTs
```
