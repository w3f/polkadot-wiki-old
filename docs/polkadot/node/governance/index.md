# Governance

Polkadot uses a sophisticated governance mechanism that allows it to evolve gracefully over time at the ultimate behest of its assembled stakeholders.

In order to do this, we bring together various novel mechanisms, including an amorphous state-transition function stored on-chain and defined in a platform-neutral intermediate language (i.e. WebAssembly) and several on-chain voting mechanisms such as referenda with adaptive super-majority thresholds and batch approval voting.

## Mechanism

### Creating proposals

Anyone can create a proposal by depositing minimum value in a certain period of time (No. of Blocks). If someone likes the proposal, they could deposit the same amount of tokens to support it. The one with the highest number of supported proposals will be selected. Those tokens will be released once the proposal is tabled.

### Voting on referenda

Essentially, holding only a small amount of DOT tokens does not mean that they do not have the ability to influence the referenda result. Since Polkadot introduces an idea called Voluntary Locking that lets the token holders increasing their voting power by declaring how long they are willing to lock-up their DOTs, hence, the maximum number of votes for each token holder will be calculated by the following formula:

```
Max votes = tokens * periods 
```

Based on the current testnet setting, the maximum number of lock periods could NOT be more than 6.

**Each period takes 2 weeks, which means the longest lock period would be 12 weeks.**

```
Example: 

Peter: Votes `No` with 10 DOTs for a 12 week lock period  => 10 * 6 = 60 Votes

Logan: Votes `Yes` with 20 DOTs for a 2 week lock period => 20 * 1 = 20 Votes

Kevin: Votes `Yes` with 15 DOTs for a 4 week lock period => 15 * 2 = 30 Votes
```

According to the above scenario, even though combining both Logan and Kevin's DOTs is more than Peter, the lock period for both of them is far less than Peter, leading to their voting power counting as less.

Once voting is finished, only the winning voter's tokens are locked, which means if that referendum hurts the network, then those who voted against it can immediately get their locked tokens back. They can exit the network and sell their tokens to the market before the proposal becomes effective. Moreover, winning motions are autonomously enacted only after some cool-down period.

### [Adaptive Quorum Biasing](../../learn/governance.md#vote-counting)

Polkadot uses an innovative governance mechanism to dynamically adjust the turnout bias. If there is a low turnout rate, a super-majority is required in order to pass the motion, which means a higher threshold of "aye" (yes) votes has to be reached.

```
Example:

If the referenda only has 20% turnout, the tally of "aye" votes has to reach 14% in order for it to pass.

In contrast, if it has 50% turnout, the tally of "aye" votes has to reached 29%, which means that as more token holders vote on a referenda, then the super-majority required decreases as the turnout increases.
```

This would be the tentative governance configuration for Polkadot in the initial genesis. It will be changed if any security loopholes have been found after third-party auditing.

## Council

The council is an on-chain entity comprised of a set of account IDs. Its overall purpose is to represent the passive stakeholders whom do not participate in the governance process. Election of council members is done through an approval vote.

The two main tasks of the council are:

- Making sensible proposals for referenda.
- Cancelling any uncontroversially dangerous or malicious referenda.

### How does one join the council?

An account wishing to join the council must first signal their candidacy and submit the required bond. The requisite bond for council membership is configurable by the governance process. The voting process is continuous and voters may at any time register approval of an account for inclusion to the council. Each voting period, the tally is taken for new votes and the winners of the vote are allowed to present themselves as active for the council seat. The council seat is then active for duration of the term. The number of desired seats for the council is a parameter that can be determined by the governance process and is envisioned to be 24 for Polkadot with 12 month terms.

### How are council motions made? What can they do?

### How does one vote for a council member?

Voters must also submit a bond to signal approvals for council seats. If a voter becomes inactive, they may be "reaped" by an external actor and their bond claimed as a reward. The process of the running votes is known as [approval voting](https://en.wikipedia.org/wiki/Approval_voting).

### Resources

- [Governance Description](../../learn/governance.md#council)
- [Council Module](https://github.com/paritytech/)

## Referenda (General Stakeholder Voting)

### Resources

- [Governance Description](../../learn/governance.md#referenda)
- [Democracy Module](https://github.com/paritytech/)

## [Usage of DOT](../../learn/DOT.md#dots-for-governance)

## Guides

### [How to create a proposal]()
### [How to join the council]()
### [How to propose a referendum]()
