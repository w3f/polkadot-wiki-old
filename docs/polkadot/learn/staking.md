# Staking

Polkadot uses NPoS (Nominated Proof-of-Stake) as its mechanism for selecting the validator set. Polkadot will have a limited amount of slots available at genesis for those who are interested in running a validator to maintain the network. NPoS is designed to optimize nominator/validator for maximum chain security. Basically, DOT holders get paid more for nominating multiple validators to ensure the network will not be heavily centralized on only a few validators. Validators take the role of both validating blocks and guaranteeing the finality of the chain, while nominator will choose a set of potential validators candidate by indicating their DOTs as weight. Both validators and nominators will earn rewards proportional to the amount that they stake, with validators having the ability to set payment preferences.

Any potential validators can indicate their intention to be a validator candidate. Validators who signal intention will be added to a waiting queue for nominators to elect and become active in the next era if a validator get enough nomination support.      

![staking](../../img/NPoS/article-1.png)

## Accounts

There are three different accounts for managing your funds: `Stash`, `Controller` and `Session` accounts. 

![staking](../../img/NPoS/staking-keys.png)

- **Stash:** This is the primary account that holds the funds and has a portion bonded for participation; The funds can be kept in a cold wallet; All bonded DOTs are locked. After unbonding, users must wait a certain amount of time in order to access the locked funds (600 blocks at the time of writing).
- **Controller** This is used to control the operation of the validator or nominator, switching between validating, nominating and idle; (It only needs enough funds to send transactions when actions are taken). 
- **Session** The seed of this account should be passed to the node using the `--key` parameter. The session account does not need to have funds as it does not need to send any transaction. The best practice is to create a dedicated account to be used as session account. Although a single account can theoretically be used as both `session` and `controller`, it is not recommended to do so. Having a dedicated `session` account would prevent the theft of funds should the validator node be compromised and the `--key` leaked.

For more on how keys are used in Polkadot and the cryptography behind it [see here](./keys.md).

## Validators and nominators

Since validator slots will be limited, most of those who wish to stake their DOTs and contribute economic security to the network will be nominators. Validators do most of the heavy lifting, they produce new block candidates in BABE, vote and come to consensus in GRANDPA, validate STF of parachains, and possibly some other responsibilities in regard to data availability. Nominators, on the other hand do not need to do anything once they have bonded their DOTs. The experience of the nominator is similar to "set it and forget it" while the validator will be doing an actual service for the network by performing the critical operations. For this reason, the validator has certain privileges in regard to the payout of the staking mechanism and will be able to declare its own allocation before the share which is divvied to nominators.

![staking](../../img/NPoS/article-2.png)

### Want to stake DOTs?

- [Nominator Guide](../node/guides/how-to-nominate.md) - Become a nominator on the Alexander testnet.
- [Validator Guide](../node/guides/how-to-validate.md) - Become a validator on the Alexander testnet.

## Slashing

Slashing will be applied if a validator has been reported to be offline for a number of times. Essentially, there are two parameters that will be taken into account whether the slashing will happen or not, these are `Offline Slash Grace` & `Unstake Threshold`. 
`Offline Slash Grace` is configured by the network, and the current testnet configuration is set to `4`, whereas `Unstake Threshold` is decided by the validator. However,the maximum number of `Unstake threshold` is NOT allowed to be set greater than 10 in the current setting.

In short, validators will be slashed if they have been reported offline more than `Offline Slash Grace + Unstake Threshold` times.

At the same time, once slashing is determined, a value will be deducted from the balance of the validator and all the nominators that have voted for this validator.

!!! info
    **Example:**
 
    Offline Slash Grace = 4 (Network define)

    Unstake Threshold   = 5 (Validator define)

    In this case, slashing will only occur if a validator has been reported offline more than 9 times.


## Reward Distribution

Based on the the current configuration in the Alexander testnet, rewards are recorded per session that is roughly 5 minutes and paid per era. It takes 1 hour to finish an era; that means rewards will be distributed to the validators and nominators per hour. 

!!! info
    **Example:**

    PER_ERA * BLOCK_TIME = **Reward Distribution Time**

    600 * 6 = 3600 = 1 Hour

    ***These parameters can be changed by proposing a referendum***

Validator can create a cut of the reward that is not shared with the nominators. After value gets deducted, the remaining portion is based on their staked value and split between the validator and all of the nominators who have voted for this validator.

For example, assume reward is 100 DOTs.
A validator may specify `validator_payment = 50 DOTs` and the remaining 50 DOTs would split between the validator and their nominators based on the portion of stakes they had.

Rewards can be used by the same account (controller) to keep accumulating the rewards or by the stash account (increasing the staked value/not increasing the staked value). Also, it is possible to top-up/withdraw partial bonded DOTs without having to complete un-stake everything.

## Inflation

It will be closed to 10% in the first year. Each validator will get 1,000 - 2,000 DOTs per month to share with their nominators.

![staking](../../img/NPoS/staking-participation-rate.png)

<sub><sup>Source: [Research - Web3 Foundation](https://research.web3.foundation)</sup></sub>

**x-axis**: amount of DOTs staked

**y-axis**: the annualized percentage

**Green line**: return rate based on the staking participation

**Blue line**:  inflation rate

The above chart shows the inflation model of the network. Depending on the staking participation, the inflation rate will be dynamically changed to incentivize / disincentivize token holders to participate in staking. For instance, inflation would be 10% if there is 50% of DOTs being staked to the network.

Determining the ideal staking rate is not an easy task as the network requires enough DOTs to be staked to provide the security guarantees we want and to avoid illiquidity on the market. 

For those who are interested in knowing more about the design of inflation model for the network, please see [here](https://research.web3.foundation/en/latest/polkadot/Token%20Economics/).

## Why stake?

- 10% inflation/year when the network launches
- 50% targeted active staking 
- ~20% annual return

## Why not stake?

- Tokens will be locked for about 12 weeks
- Punishment in case of validator found to be misbehaving

## How many validators will Polkadot have?

The plan is to start with somewhere between 50 to 100 open validator positions and open more gradually. The top bound on the number of validators has not been determined yet, but should only be limited by the bandwidth strain of the network due to frequent and voluminous peer-to-peer message passing. The practical estimation of the number of validators that Polkadot will have at maturity is around 1000.

## Resources

- [How Nominated Proof of Stake will work in Polkadot](https://medium.com/web3foundation/how-nominated-proof-of-stake-will-work-in-polkadot-377d70c6bd43) - Blog post by Web3 Foundation researcher Alfonso Cevallos covering NPoS in Polkadot.
