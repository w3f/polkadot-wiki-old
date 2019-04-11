# Governance

Polkadot uses a sophisticated governance mechanism that allows it to evolve gracefully over time at the ultimate behest of its assembled stakeholders.

In order to do this, we bring together various novel mechanisms, including an amorphous state-transition function stored on-chain and defined in a platform-neutral intermediate language (i.e. WebAssembly) and several on-chain voting mechanisms such as referenda with adaptive super-majority thresholds and batch approval voting.

## Mechanism

### Purpose proposal

Anyone can create a proposal by depositing minimum value in a certain period of time (No. of Blocks). If someone likes the proposal, they could deposit the same amount of tokens to support it. The one with the highest number supported proposal will be selected to allow everyone votes for it that is called referenda. Those tokens will be released once the proposal is tabled.

### Voting on referenda

Essentially, Polkadot introduces an idea called Voluntary Locking that lets the token holders increasing the voting power by declaring how long they are willing to lock-up their DOTs, hence, the maximum number of votes for each token holder will be calculated by the following formula:

Based on the current testnet setting, the maximum number of lock periods could NOT be more than 6.

**Each period takes 2 weeks that means the longest locking time would be 12 weeks.**


```
Votes = tokens * periods 
```

```
Example: 

Peter: Vote `No` with 10 DOTs 12 weeks lock  => 10 * 6 = 60 Votes

Logan: Vote `Yes` with 20 DOTs 2 weeks lock => 20 * 1 = 20 Votes

Kevin: Vote `Yes` with 15 DOTs 4 weeks lock => 15 * 2 = 30 Votes
```

According to the above scenario, even though combining both Logan and Kevin DOTs are more than Peter, the locking period for both of them are far less than Peter that leads the voting power becomes less.


Once voting is finished, only the winning voter’s tokens locked that means if that referendum hurts the network, those who voted against it can immediately get their locked tokens back. They can exit the network and sell their tokens to the market before the proposal becomes effective. Moreover, winning motions are autonomously enacted only after some cool-down period.

 
### Adaptive Quorum Biasing

Polkadot uses an innovative governance mechanism to dynamically adjust the turnout bias. If low turnout rate, super-majority is required in order to pass the motion that means the higher threshold of saying “ayes” has to be reached.

Example: _TODO_


This would be the tentative governance configuration for the polkadot in the initial genesis. It will be changed if any security loopholes have been found after third-party auditing.


## [Council](https://github.com/paritytech/polkadot/wiki/Governance#council)

## [Referenda](https://github.com/paritytech/polkadot/wiki/Governance#referenda)

## [Voting]()

## Usage of DOT

* **Governance** -
Polkadot holders have complete control over the protocol. All privileges, which on other platforms are exclusive to miners, will be given to the relay chain participants (DOT holders), including managing exceptional events such as protocol upgrades and fixes.

* **Operation** - 
Game theory incentivizes token holders to behave in honest ways. Good actors are rewarded by this mechanism whilst bad actors will lose their stake in the network. This ensures the network stays secure.

* **Bonding** - 
New parachains are added by bonding tokens. Outdated or non-useful parachains are removed by removing bonded tokens. This is a form of Proof of Stake.

## Guides

### [How to create a proposal ?]()
### [How to join the council ?]()
### [How to propose a referendum ?]()
