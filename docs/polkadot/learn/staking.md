# Staking Information

Polkadot will use NPoS(Nominated Proof-of-Stake) consensus, which will have a limited amount of slots available at the begining for someone who is interested in running a validator to maintain the network. NPoS is designed to optimize nominator/validator for maximum chain security. Bascially, DOTs holder gets pay more for nominating multiple validators. As a validator, it only takes the role of either validating blocks or ensuring their finality, maintaining the veracity of the network to earn DOTs token, while nominator will choose a set of potential validators candidate by indicating their DOTs as weight.

## Accounts 
There are two different accounts for managing your funds, which is 
Stash & Controller account.

**Stash:** It is reponsible for holding an owner's funds used for staking that are controlled by a cold wallet and bonding DOTs token to the controller. All bonded DOTs are locked. It has to be waited a certain of time (a number of era) in order to access the locked funds.

**Controller:** It is actively reponsible for managing the account operations such as expressing an interest to switch between roles (validator, nominator, idle).

## Operations

_TODO_ - Step-By-Step Guide for nominating potential validators 


## Slashing

Slashing will be applied if a validator has been reported to offline a number of times. Once slashing is determined, a value is deducted from the balance of the validator and all the nominators voted for this validator.

## Reward Calculation
 
 _TODO_ - Explain what session & era are

Validator can create a reward cut that is not shared with the nominators. After value gets deducted, the remaining portion is based on the proportional to their staked value to split in between validaor and all of the nominators who had a vote for this validator.

For example, let say the reward is 100 DOT.
If a validator specify validator payment = 50 DOT, the remaining 50 would split in between the validator and their nominators based on their share they had.


Rewards can be used the same account(controller) to keep accumulating the rewards or stash account (inceaseing the staked value/not increasing the staked value). Also, it is possible to top-up/withdraw partial bonded DOTs without having to complete un-stake everything.

## Inflation
It will be closed to 10% in the first year. Each validator will get 1,000 - 2,000 DOTs per month share with their nominators.

## How many validators will be available for the polkadot ?
Starting from 50 - 100 at the begining, and will be expanding up to 1,000 validators in the future.

The above information is NOT finalized yet. You can take it as a reference instead.


