# Staking Information

Polkadot will use NPoS (Nominated Proof-of-Stake) consensus, which will have a limited amount of slots available at the beginning for someone who is interested in running a validator to maintain the network. NPoS is designed to optimize nominator/validator for maximum chain security. Basically, DOTs holder get paid more for nominating multiple validators to ensure the network will not be heavily centralized on only a few validators. As a validator, it only takes the role of either validating blocks or guaranteeing the finality of the chain to earn rewards, while nominator will choose a set of potential validators candidate by indicating their DOTs as weight. 

Any validators can indicate their intention to be a validator candidate in anytime. It will be added to a waiting queue for nominators to elect and become active in the next era if a validator get enough nomination support.      

## Accounts

There are two different accounts for managing your funds, which is 
Stash & Controller account. 

**Stash:** It is reponsible for holding an owner's funds used for staking that are controlled by a cold wallet and bonding DOTs token to the controller. All bonded DOTs are locked. It has to be waited a certain of time in order to access the locked funds.

**Controller:** It is actively reponsible for managing the account operations such as expressing an interest to switch between roles (validator, nominator, idle).

## Operations

_TODO_ - Step-By-Step Guide for nominating potential validators 


## Slashing

Slashing will be applied if a validator has been reported to be offline for a number of times. Once slashing is determined, a value will be deducted from the balance of the validator and all the nominators that have voted for this validator.

## Reward Distribution

Based on the the current configuration in PoC-3 Alexander testnet, it takes 1 hour to finish an era that means rewards will be distributed to the validators and nominators per hour. 

!!! info
    PER_ERA * BLOCK_TIME = **Reward Distribution Time**

    600 * 6 = 3600 = 1 Hour

    ***These parameters can be changed by proposing a referendum***

Validator can create a reward cut that is not shared with the nominators. After value gets deducted, the remaining portion is based on the proportional to their staked value to split in between validaor and all of the nominators who had a vote for this validator.

For example, assume reward is 100 DOTs.
If a validator specify `validator_payment = 50 DOTs`, the remaining 50 would split in between the validator and their nominators based on their share they had.

Rewards can be used the same account (controller) to keep accumulating the rewards or stash account (increasing the staked value/not increasing the staked value). Also, it is possible to top-up/withdraw partial bonded DOTs without having to complete un-stake everything.

## Inflation
It will be closed to 10% in the first year. Each validator will get 1,000 - 2,000 DOTs per month share with their nominators.

## How many validators will be available for the polkadot ?
Starting from 50 - 100 at the begining, and will be expanding up to 1,000 validators in the future.

The above information is NOT finalized yet. You can take it as a reference instead.


