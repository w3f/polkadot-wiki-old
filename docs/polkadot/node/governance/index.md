# Governance

Polkadot uses a sophisticated governance mechanism that allows it to evolve gracefully over time at the ultimate behest of its assembled stakeholders.

To do this, we bring together various novel mechanisms, including an amorphous state-transition function stored on-chain and defined in a platform-neutral intermediate language (i.e. WebAssembly) and several on-chain voting mechanisms such as referenda with adaptive super-majority thresholds and batch approval voting.

All changes to the protocol must be agreed upon by stake-weighted referendum; the majority of the stake can always command the network.

## Mechanism

In order to make any changes to the network, the idea is to compose of active token holders and council together to administrate the network upgrade decision. No matter whether the proposal is proposed by the public(DOT holders) or council, it finally will have to go through the [referenda](#referenda) to let all DOT holders make the decision.

The following steps are the governance procedure in the Polkadot network:

- [Proposing referenda](#proposing-proposals) (Involved info: [Referenda](#referenda))
- [Voting in a referendum](#voting-in-a-referendum) (Involved info: [Voluntary Locking](#voluntary-locking)
- [Vote Counting](#vote-counting) (Involved info: [Adaptive Quorum Biasing](#adaptive-quorum-biasing))

To better understand how council forms and what they are responsible for, please read [this section](#council).

### Proposing proposals

- **Public**: Anyone can propose a proposal by depositing minimum value in a certain period (No. of Blocks). If someone likes the proposal, they could deposit the same amount of tokens to support it. The one with the highest number of supported proposal will be selected to be a referendum. Those tokens will be released once the proposal is tabled. At genesis, every two weeks will have a referendum on the most supported proposal.

- **[Council](#council)**: 

    Unanimous Council - Where everyone in the council thinks that is a good proposal, it can move to the referenda.

    Majority Council - Where simple-majority council agreement must have more aye votes to nay votes to be accepted.

### Voting in a referendum

To vote, a voter must lock their tokens up for at least the enactment delay period beyond the end of the referendum. This is in order to ensure that some minimal economic buy-in to the result is needed and to dissuade vote selling. At the same time, holding only a small amount of DOT tokens does not mean that they cannot influence the referenda result, you can read more about the [Voluntary Locking](#voluntary-locking).

```
Example: 

Peter: Votes `No` with 10 DOTs for a 12 week lock period  => 10 * 6 = 60 Votes

Logan: Votes `Yes` with 20 DOTs for a 2 week lock period => 20 * 1 = 20 Votes

Kevin: Votes `Yes` with 15 DOTs for a 4 week lock period => 15 * 2 = 30 Votes
```

According to the above scenario, even though combining both Logan and Kevin's DOTs is more than Peter, the lock period for both of them is far less than Peter, leading to their voting power counting as less.

### Vote Counting

Depending on who are the entity proposed the proposal and whether all council members voted yes, there are three different scenarios. 

We assume that a majority `council` agreement, with no veto, signals a sensible, perhaps an irregular state transition. For this, we use the `majority carries` metric. As an exception to this when there is **complete agreement** within the council we assume that is signals a largely technocratic and uncontroversial protocol change. For this reason we assert that the "burden of proof" should fall on those against the motion and thus we use the `negative turnout bias` metric.

Publicly submitted referenda, being `public`, can easily include malevolent or ill-considered actions. Here the onus must be placed on the proponents and so we bias any abstention votes against the motion, in favor of the (assumed safe, since its functional enough to administer this vote) status quo and use a `positive turnout bias`.

**Super-Majority Approve**

A ``positive turnout bias``, whereby a heavy super-majority of aye votes is required to carry at low turnouts, but as turnout increases towards 100%, it becomes a simple- majority-carriers as below.
$${against \over \sqrt{voters}} < {approve \over \sqrt{electorate}}$$

**Super-Majority Against**

A ``negative turnout bias``, whereby a heavy super-majority of nay votes is required to reject at low turnouts, but as turnout increases towards 100%, it becomes a simple-majority-carriers as below.
$${approve \over \sqrt{voters}} < {against \over \sqrt{electorate}}$$

**Simple-Majority**

Majority-carries, a simple comparison of votes, if there are more aye votes than nay, then the proposal is carried.
$${approve} > {against}$$

To calculate the voting for a proposal, we need this four information.

```
Approve - the number of aye votes

Against - the number of nay votes

Voters - the total number of voting tokens

Electorate - the total number of DOTs tokens issued in the network
```

We use the public proposal as an example so `Super-Majority Approve` formula will be applied. There is no strict quorum, but super-majority required increases as turnout lowers. For simplicity, assume we only have 1,000 DOTs tokens in total.
```
John  - 500 DOTs
Peter - 100 DOTs
Lilly - 150 DOTs
JJ    - 150 DOTs
Ken   - 100 DOTs

John: Votes `Yes`for a 2 week lock period  => 500 * 1 = 500 Votes

Peter: Votes `Yes` for a 2 week lock period => 100 * 1 = 100 Votes

JJ: Votes `No` for a 6 week lock period => 150 * 3 = 450 Votes
```

$${450 \over \sqrt{1050}} < {600 \over \sqrt{1000}}$$

$${13.887} < {18.974}$$

Based on the above result, proposal will be approved. In addition, only the winning voter's tokens are locked, which means if that referendum hurts the network, then those who voted against it can immediately get their locked tokens back. They can exit the network and sell their tokens to the market before the proposal becomes effective. Moreover, winning proposals are autonomously enacted only after some cool-down period.

## Voluntary Locking

Polkadot utilize an idea called `Voluntary Locking` that lets the token holders increasing their voting power by declaring how long they are willing to lock-up their DOTs, hence, the maximum number of votes for each token holder will be calculated by the following formula:

```
Max votes = tokens * periods 
```

Based on the current testnet setting, the maximum number of lock periods could NOT be more than 6.

**Each period takes 2 weeks, which means the longest lock period would be 12 weeks.**


## Adaptive Quorum Biasing

Polkadot introduces a concept "Adaptive Quorum Biasing", which functions as a lever that the council can use to alter the effective super-majority required to make it easier or more difficult for a proposal to pass in the case that there is no clear majority of voting power backing it or against it.

![](../../../img/governance/adaptive-quorum-biasing.png)

Let's use the above image as an example.

if there is publicly submitted referenda only has 25% turnout, the tally of "aye" votes has to reach 66% for it to pass since we applied the ``Positive Turnout Bias``.

In contrast, when it has 75% turnout, the tally of "aye" votes has to reach 54%, which means that as more token holders vote on referenda, then the super-majority required decreases as the turnout increases.

Suppose there is a unanimous proposal proposed by the council, ``Negative Turnout Bias`` would be used, so that means the proposal is passed by default. Hence, more token holders have to participate in voting to prevent it from passing if they do not like this proposal.

Referring to the above image, when the referenda only has 25% turnout, the tally of "nay" votes has to reach 34% for it to reject.

In short, when turnout rate is low, a super-majority is required to pass the proposal, which means a higher threshold of "aye" (yes) votes have to be reached, but as turnout increases towards 100%, it becomes a simple-majority.

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

For a referendum to be proposed by the council, a strict majority of members must be in favor, with no member exercising a veto. Veto may be exercised only once by a member for any single proposal; if, after a cool-down period, the proposal is resubmitted, they may not veto it a second time. In the case that all members vote in favor, the vote is considered unanimous and is treated as uncontroversial.

For a referendum to be cancelled, there must be a unanimous vote to do so. Since unanimity is a high requirement, it is expected that this measure will only be used when it is an entirely uncontroversial move. This may function as a last-resort if there is an issue found late in the day with a referendum's proposal such as a bug in the code of the runtime that the proposal would institute.

### How to be a council member?

![](../../../img/governance/approval-vote.png)

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
For the top-N(say 4 in this example) runners-up, they can stay there and keep their votes persist until next election. After round 2, even though candidate A & B get the same votes in this round, candidate A gets elected because after adding the older unused approvals counter still higher than B.

This would be the tentative governance configuration for Polkadot in the initial genesis. It will be changed if any security loopholes have been found after third-party auditing.

## Referenda (General Stakeholder Voting)

### Resources

- [Governance Description](../../learn/governance.md#referenda)
- [Democracy Module](https://github.com/paritytech/)

## [Usage of DOT](../../learn/DOT.md#dots-for-governance)

## Guides

### [How to create a proposal]()
### [How to join the council]()
### [How to propose a referendum]()
