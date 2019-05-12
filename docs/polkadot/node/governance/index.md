# Governance

Polkadot uses a sophisticated governance mechanism that allows it to evolve gracefully over time at the ultimate behest of its assembled stakeholders.

To do this, we bring together various novel mechanisms, including an amorphous state-transition function stored on-chain and defined in a platform-neutral intermediate language (i.e. WebAssembly) and several on-chain voting mechanisms such as referenda with adaptive super-majority thresholds and batch approval voting.

All changes to the protocol must be agreed upon by stake-weighted referendum; the majority of the stake can always command the network.

## Mechanism

In order to make any changes to the network, the idea is to compose of active token holders and council together to administrate the network upgrade decision. No matter whether the proposal is proposed by the public(DOTs holders) or council, it finally will have to go through the [referenda](#referenda) to let all DOTs holders make the decision.

The following steps are the governance procedure in the Polkadot network:

- Proposing proposals (Involved info: [Referenda](#referenda))
- Voting in a referendum (Involved info: Voluntary Locking)
- Vote Counting (Involved info: [Adaptive Quorum Biasing](#adaptive-quorum-biasing))

To better understand how council forms and what they are responsible for, please read [this section](#council).

### Proposing motions/proposals

- **Public**: Anyone can propose a proposal by depositing minimum value in a certain period (No. of Blocks). If someone likes the proposal, they could deposit the same amount of tokens to support it. The one with the highest number of supported proposal will be selected to be a referendum. Those tokens will be released once the proposal is tabled. At genesis, every two weeks will have a referendum on the most supported proposal.

- **[Council](#council)**: 

    Unanimous Council - Where everyone in the council thinks that is a good proposal, it can move to the referenda.

    Majority Council - Where Simple majority council agreement must have more aye votes to nay votes to be accepted.

### Voting in a referendum

Essentially, holding only a small amount of DOT tokens does not mean that they cannot influence the referenda result. Since Polkadot introduces an idea called `Voluntary Locking` that lets the token holders increasing their voting power by declaring how long they are willing to lock-up their DOTs, 
hence, the maximum number of votes for each token holder will be calculated by the following formula:

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

### Vote Counting

_TODO_

Once voting is finished, only the winning voter's tokens are locked, which means if that referendum hurts the network, then those who voted against it can immediately get their locked tokens back. They can exit the network and sell their tokens to the market before the proposal becomes effective. Moreover, winning motions are autonomously enacted only after some cool-down period.


## Adaptive Quorum Biasing

Polkadot introduces a concept "Adaptive Quorum Biasing", which functions as a lever that the council can use to alter the effective supermajority required to make it easier or more difficult for a proposal to pass in the case that there is no clear majority of voting power backing it or against it.

If a proposal is proposed by the public(DOTs holders), it would be ``Positive Turnout Bias``.

![](../../../img/governance/adaptive-quorum-biasing.png)

Let's use the above image as an example.

if the referenda only has 25% turnout, the tally of "aye" votes has to reach 66% for it to pass.

In contrast, when it has 75% turnout, the tally of "aye" votes has to reach 54%, which means that as more token holders vote on referenda, then the super-majority required decreases as the turnout increases.

Suppose there is a unanimous proposal proposed by the council, ``Negative Turnout Bias`` would be used, so that means the proposal is passed by default. Hence, more token holders have to participate in voting to prevent it from passing if they do not like this proposal.

Referring to the above image, when the referenda only has 25% turnout, the tally of "nay" votes has to reach 34% for it to reject.

In short, when turnout rate is low, a super-majority is required to pass the proposal, which means a higher threshold of "aye" (yes) votes have to be reached, but as turnout increases towards 100%, it becomes a simple majority.

## Referenda

Referenda are simple, inclusive, stake-based voting schemes. Each referendum has a specific proposal associated with it which takes the form of a privileged function call in the runtime (that includes the most powerful call: `set_code`, which is able to switch out the entire code of the runtime, achieving what would otherwise require a "hard fork"). They are discrete events, have a fixed period where voting happens, and then are tallied and the function call is made if the vote is approved.

Referenda can be started in three ways:

- Publicly submitted proposals;
- Proposals submitted by the council, either through a no-veto majority or unanimously;
- Proposals submitted as part of the enactment of a prior referendum.

All referendums have an enactment delay associated with them. This is the period of time between the referendum ending and, assuming the proposal was approved, the changes being enacted. For the first two ways that a referendum is launched, this is fixed, (for Polkadot, it is likely to be two weeks). For the third type, it can be set as desired.

## Council

Since not everyone is interested in participating in governance, there is a council entity to represent the passive token holders. Election of council members is done through an approval vote. There is no particular voting period for a seat but rather a continuous election process. All stakeholders are free to signal their approval (or not) of any of the registered candidates. Council members can be removed early only by a referendum.

The council is called upon primarily for two tasks of governance: proposing sensible referenda and canceling uncontroversially dangerous or malicious referenda. 

For a referendum to be proposed by the council, a strict majority of members must be in favour, with no member exercising a veto. Vetos may be exercised only once by a member for any single proposal; if, after a cool-down period, the proposal is resubmitted, they may not veto it a second time. In the case that all members vote in favour, the vote is considered unanimous and is treated as uncontroversial.

For a referendum to be cancelled, there must be a unanimous vote to do so. Since unanimity is a high requirement, it is expected that this measure will only be used when it is an entirely uncontroversial move. This may function as a last-resort if there is an issue found late in the day with a referendum's proposal such as a bug in the code of the runtime that the proposal would institute.

### How to be a council member?

At genesis, there will be 6 to 12 seats to start. For every two weeks, one of those seats is up for election and increase over the course of 9 months to 24 people (roughly one extra individual coming on every two weeks). All members have a fixed term (1 year). To elect a new council member, Polkadot employs `approval voting` method to allow token holders that choose a list of candidates they want to support in equal weight and the one with the most approval votes wins the election, while top-N runners-up remain on the candidates' list for next election.

Basically, instead of using one person one vote, [approval voting](https://en.wikipedia.org/wiki/Approval_voting) is a more expressive way to indicate their views. Token holders can treat it as boolean voting to support as many candidates as they want.

Let's take a look at the example below.
```
                                Round 1

                                Candidates
                |   A   |   B   |   C   |   D   |   E   |

Token Holders

Peter               X               X       X       X

Alice                       X

Bob                                 X       X       X

Kelvin              X               X

                    2       1       3       2       2
```
The above example shows that candidate C wins the election in round 1, while candidate A, B, D & E keep remaining on the candidates' list for the next round.
```
                                Round 2

                                Candidates
                |   A   |   B   |   D   |   E   |

Token Holders

Peter               X       X              

Alice               X       X

Bob                 X       X       X       X

Kelvin              X       X

                    4       4       1       1
```
For the top-N(say 4 in the example) runners-up, they can stay there and keep their votes for the next seat. After round 2, even though candidate A & B get the same votes in this round, candidate A gets elected because after adding the older unused approvals counter still higher than B.

This would be the tentative governance configuration for Polkadot in the initial genesis. It will be changed if any security loopholes have been found after third-party auditing.

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
