# Parachain Slots Auction

An old-timey auction mechanism used for the sale of ships in the 16th Century has re-emerged as the auction process for which parachain slots of Polkadot will be sold.

[Candle auctions](https://en.wikipedia.org/wiki/Candle_auction) are also sometimes known as _Sudden Termination Auctions_ and have been used in online auctions to prevent _auction sniping_.

## Mechanics of a candle auction

Candle auctions are a variant of open auctions in which bidders submit bids and the highest bidder wins. However, candle auctions get their name from the "inch of a candle" that determined the duration for which bids were accepted. When the flame extinguished from the candle, the auction would suddenly terminate and the standing bid at that point would win.

For online systems, we usually do not have access to a real world lit candle. Instead, we can simulate the property that the candle provides: randomness. By using a random number, we can determine when an action will end based on the output we are given.

However, this brings to light another problem that is inherent to blockchain systems. Generating a random number trustlessly on a transparent and open network in which other parties must be able to verify is a hard problem. There have been a few solutions that have been put forward, including hash-onions like [RANDAO](https://github.com/randao/randao) and [verifiable random functions](https://en.wikipedia.org/wiki/Verifiable_random_function) (VRFs). The latter is what Polkadot uses for its randomness.

## How it's used in Polkadot

Polkadot will use a _random beacon_ from the VRF that's used in other places of the protocol to determine the virtual "end-time" of the auction. 

When an account bids, they can place bids for any of the available units or ranges of slots. However, if a parachain (with the same STF) bids then that parachain must bid on a continuous unit or range to the one they already occupy. They will not be able to bid for an overlapping slot (no multiples of the same parachain at the same time) and they will not be able to bid for a future slot if there is a gap in between. In the case a parachain is rebooted after having already reached the conclusion of its slot duration, it will need to be started again from a new genesis (which could be snapshot of all the old state) and will need to be bid for my an external account.

## How does bidding work?

```
Parachain slots at genesis

       --6 months--
       v          v
Slot A |     1    |     2    |     3     |     4     |
Slot B |     1    |     2    |     3     |     4     |
Slot C |__________|     2    |     3     |     4     |
Slot D |__________|     2    |     3     |     4     |
Slot E |__________|__________|     3     |     4     |
       ^                                             ^
       ---------------------2 years-------------------      

Each unit of the range 1 - 4 represents a 6-month duration for a total of 2 years
```

Auctions will take place at 6 months intervals, with the auction for a particular range of units in a slot starting 6 months before the beginning of that range.

For example, if an account would like to bid on the slot range 3-4 then the bidding would start at slot unit 2.

Bidders are allows to bid for a range of a minimum of 1 slot unit to a maximum of 4 slot units. The bids will determine the amount of DOTs they will lock up if they win.

The algorithm tries to maximize the amount of staked DOTs at any particular slot unit.

### Example

There are 2 slots available for the range 1-3.

Alice bids `20 DOTs` for the range 1-3 at unit 0.

Bob bids `30 DOTs` for the unit 1 at unit 0.

Since there are 2 slots available, when the auction settles before unit 1, both Alice and Bob will be winners. A total of `50 DOTs` will be locked. Since Alice won a range, she will be able to keep here parachain there for the entire duration and that slot will not be auctioned again until its duration has elapsed.

A new auction begins at unit 1 for the single remaining range 2-3.

Bob bids `30 DOTs` for unit 2 because he has decided to renew his parachain currently occupying a slot at unit 1.

However, a new comer Charlie has decided to bid `20 DOTs` for the range 2-3. Charlie becomes the new standing bid for the auction since his bid for a range of 2 units counts as 20*2 = `40 DOTs*units`.

Bob sees Charlie's bid only after some time has progressed. Bob places a new bid for the range 2-3 with the same valuation of `30 DOTs`. He once again becomes the standing bid with a valuation of 30*2 = `60 DOTs*units`.

The auction settles before the start of unit 2, the VRF determines which block the "actual" end time of the auction happened.

It is determined that the end time of the auction took place preceding Bob's second bid. Although one would expect him to be rewarded with the range 2-3 with his standing order valued at `60 DOTs`, this does not happen. Instead, the block in which the auction ended was when Charlie had the highest standing bid valued at `40 DOTs`. Charlie becomes the beneficiary of the slot for range 2-3.

## Why doesn't everyone bid for the max length?

For the duration of the slot the `DOTs` bid in the auction will be locked up. This means that there are opportunity costs from the possibility of using those `DOTs` for something else. For parachains that are beneficial to Polkadot, this should align the interests between parachains and the Polkadot relay chain.




<!--
(Should go up to a general mechanics section)We always know the states of the bid, but not when the auction will be determined to have "ended." This helps to ensure that bidders are willing to bid their true bids early. Otherwise they might find themselves in the situation that the auction was determined to have "ended" before they even bid!

-Vickrey auction was considered
-->

