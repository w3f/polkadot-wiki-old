# Governance

Polkadot uses a sophisticated governance mechanism that allows it to evolve gracefully over time at the ultimate behest of its assembled stakeholders.

To do this, we bring together various novel mechanisms, including an amorphous state-transition function stored on-chain and defined in a platform-neutral intermediate language (i.e. WebAssembly) and several on-chain voting mechanisms such as referenda with adaptive super-majority thresholds and batch approval voting.

All changes to the protocol must be agreed upon by stake-weighted referenda; the majority of the stake can always command the network.

## Mechanism

In order to make any changes to the network, the idea is to compose of active token holders and council together to administrate the network upgrade decision. No matter whether the proposal is proposed by the public(DOT holders) or council, it finally will have to go through the [referenda](../../learn/governance.md#referenda) to let all DOT holders make the decision.

The following steps are the governance procedure in the Polkadot network:

- [Proposing Referenda](#proposing-referenda) (Involved info: [Referenda](../../learn/governance.md#referenda))
- [Voting for a proposal](#voting-for-a-proposal) (Involved info: [Voluntary Locking](#voluntary-locking))
- [Tallying](#tallying) (Involved info: [Adaptive Quorum Biasing](#adaptive-quorum-biasing))

To better understand how council forms, please read [this section](#council).

### Proposing Referenda

- **Public**: Anyone can propose a referenda by depositing minimum value in a certain period (No. of Blocks). If someone likes the proposal, they could deposit the same amount of tokens to support it. The one with the highest number of supported proposal will be selected to be a referenda. Those tokens will be released once the proposal is tabled. At genesis, every two weeks will have a referenda on the most supported proposal.

- **[Council](#council)**: 

    Unanimous Council - When all members of the council agrees on a proposal, it can be moved to a referenda.

    Majority Council - When agreement from only the simple majority of council members is needed. (More Aye votes to Nay votes for acceptance, more Nay votes to Aye votes for rejection.) 

### Voting for a proposal

To vote, a voter must lock their tokens up for at least the enactment delay period beyond the end of the referenda. This is in order to ensure that some minimal economic buy-in to the result is needed and to dissuade vote selling. At the same time, holding only a small amount of DOT tokens does not mean that they cannot influence the referenda result, you can read more about the [Voluntary Locking](#voluntary-locking).

```
Example: 

Peter: Votes `No` with 10 DOTs for a 12 week lock period  => 10 * 6 = 60 Votes

Logan: Votes `Yes` with 20 DOTs for a 2 week lock period => 20 * 1 = 20 Votes

Kevin: Votes `Yes` with 15 DOTs for a 4 week lock period => 15 * 2 = 30 Votes
```

According to the above scenario, even though combining both Logan and Kevin's DOTs is more than Peter, the lock period for both of them is far less than Peter, leading to their voting power counting as less.

### Tallying

Depending on who are the entity proposed the proposal and whether all council members voted yes, there are three different scenarios. 

We assume that a majority `council` agreement, with no veto, signals a sensible, perhaps an irregular state transition. For this, we use the `majority carries` metric. As an exception to this when there is **complete agreement** within the council we assume that is signals a largely technocratic and uncontroversial protocol change. For this reason we assert that the "burden of proof" should fall on those against the motion and thus we use the `negative turnout bias` metric.

Publicly submitted referenda, being `public`, can easily include malevolent or ill-considered actions. Here the onus must be placed on the proponents and so we bias any abstention votes against the motion, in favor of the (assumed safe, since its functional enough to administer this vote) status quo and use a `positive turnout bias`.

**Super-Majority Approve**

A ``positive turnout bias``, whereby a heavy super-majority of aye votes is required to carry at low turnouts, but as turnout increases towards 100%, it becomes a simple-majority-carriers as below.
$${against \over \sqrt{voters}} < {approve \over \sqrt{electorate}}$$

**Super-Majority Against**

A ``negative turnout bias``, whereby a heavy super-majority of nay votes is required to reject at low turnouts, but as turnout increases towards 100%, it becomes a simple-majority-carriers as below.
$${approve \over \sqrt{voters}} < {against \over \sqrt{electorate}}$$

**Simple-Majority**

Majority-carries, a simple comparison of votes, if there are more aye votes than nay, then the proposal is carried.
$${approve} > {against}$$

We need the following information to calculate the required voting thresholds of proposals:

```
Approve - the number of aye votes

Against - the number of nay votes

Voters - the total number of voting tokens

Electorate - the total number of DOTs tokens issued in the network
```

We use the public proposal as an example so `Super-Majority Approve` formula will be applied. There is no strict quorum, but super-majority required increases as turnout lowers. For simplicity, assume we only have 1,500 DOTs tokens in total.
```
John  - 500 DOTs
Peter - 100 DOTs
Lilly - 150 DOTs
JJ    - 150 DOTs
Ken   - 600 DOTs

John: Votes `Yes`for a 2 week lock period  => 500 * 1 = 500 Votes

Peter: Votes `Yes` for a 2 week lock period => 100 * 1 = 100 Votes

JJ: Votes `No` for a 6 week lock period => 150 * 3 = 450 Votes
```

$${450 \over \sqrt{1050}} < {600 \over \sqrt{1500}}$$

$${13.887} < {15.492}$$

Based on the above result, proposal will be approved. In addition, only the winning voter's tokens are locked, which means if that referenda hurts the network, then those who voted against it can immediately get their locked tokens back. They can exit the network and sell their tokens to the market before the proposal becomes effective. Moreover, winning proposals are autonomously enacted only after some cool-down period.

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

If there is publicly submitted referenda only has 25% turnout, the tally of "aye" votes has to reach 66% for it to pass since we applied the ``Positive Turnout Bias``.

In contrast, when it has 75% turnout, the tally of "aye" votes has to reach 54%, which means that as more token holders vote on referenda, then the super-majority required decreases as the turnout increases.

Suppose there is a unanimous proposal proposed by the council, ``Negative Turnout Bias`` would be used, so that means the proposal is passed by default. Hence, more token holders have to participate in voting to prevent it from passing if they do not like this proposal.

Referring to the above image, when the referenda only has 25% turnout, the tally of "nay" votes has to reach 34% for it to reject.

In short, when turnout rate is low, a super-majority is required to pass the proposal, which means a higher threshold of "aye" (yes) votes have to be reached, but as turnout increases towards 100%, it becomes a simple-majority.

## Council

Since not everyone is interested in participating in governance, there is a council entity to represent the passive token holders. To understand more about what the council is responsible for, please read [here](../../learn/governance.md#council).

### How to be a council member?

![](../../../img/governance/approval-vote.png)

 At genesis, there will be 6 to 12 seats to start. All stakeholders are free to signal their approval (or not) of any of the registered candidates. For every two weeks, one of those seats is up for election and increase over the course of 9 months to 24 people (roughly one extra individual coming on every two weeks). All members have a fixed term (1 year). Council members can be removed early only by a referenda.

To elect a new council member, Polkadot employs `approval voting` method to allow token holders that choose a list of candidates they want to support in equal weight and the one with the most approval votes wins the election, while top-N runners-up remain on the candidates' list for next election. 

Basically, instead of using one person one vote, [approval voting](https://en.wikipedia.org/wiki/Approval_voting) is a more expressive way to indicate their views. Token holders can treat it as boolean voting to support as many candidates as they want.

Let's take a look at the example below.

||||Round 1|||
||:----:|:---:|:---:|:---:|:---:|
|**Token Holders**|||**Candidates**|||
||A|B|C|D|E|
|Peter|X||X|X|X|X|
|Alice||X|||||
|Bob|||X|X|X|
|Kelvin|X||X|||
|**Total**|2|1|3|2|2|

The above example shows that candidate C wins the election in round 1, while candidate A, B, D & E keep remaining on the candidates' list for the next round.

|||Round 2|||
||:----:|:---:|:---:|:---:|
|**Token Holders**||**Candidates**||
||A|B|D|E|
|Peter|X|X|||
|Alice|X|X|||
|Bob|X|X|X|X|
|Kelvin|X|X|||
|**Total**|4|4|1|1|

For the top-N(say 4 in this example) runners-up, they can stay there and keep their votes persist until next election. After round 2, even though candidate A & B get the same votes in this round, candidate A gets elected because after adding the older unused approvals counter still higher than B.

This would be the tentative governance configuration for Polkadot in the initial genesis. It will be changed if any security loopholes have been found after third-party auditing.

### Resources

- [Governance Description](../../learn/governance.md#referenda)
- [Democracy Module](https://github.com/paritytech/substrate/tree/master/srml/democracy/src)

## [Usage of DOT](../../learn/DOT.md#dots-for-governance)

## Guides

### [How to create a proposal]()
### [How to join the council]()
### [How to propose a referenda]()
