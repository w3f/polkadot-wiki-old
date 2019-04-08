# Parachain Slots Auction

An old-timey auction mechanism used for the sale of ships in the 16th Century has re-emerged as the auction process for which parachain slots of Polkadot will be sold.

[Candle auctions](https://en.wikipedia.org/wiki/Candle_auction) are also sometimes known as _Sudden Termination Auctions_ and have been used in online auctions to prevent _auction sniping_.

## Mechanics of a candle auction

Candle auctions are a variant of open auctions in which bidders submit bids and the highest bidder wins. However, candle auctions get their name from the "inch of a candle" that determined the duration for which bids were accepted. When the flame extinguished from the candle, the auction would suddenly terminate and the standing bid at that point would win.

For online systems, we usually do not have access to a real world lit candle. Instead, we can simulate the property that the candle provides: randomness. By using a random number, we can determine when an action will end based on the output we are given.

However, this brings to light another problem that is inherent to blockchain systems. Generating a random number trustlessly on a transparent and open network in which other parties must be able to verify is a hard problem. There have been a few solutions that have been put forward, including hash-onions like [RANDAO](https://github.com/randao/randao) and [verifiable random functions](https://en.wikipedia.org/wiki/Verifiable_random_function) (VRFs). The latter is what Polkadot uses as a base for its randomness.

## Why use a candle auction?

Another issue of blockchain systems is that the open nature makes it easy for large holders of tokens to perform some types of attacks. Auctions are a prime example of this, in normal first-price auction mechanisms it is easy for an attacker to _grief_ other participants by sniping the auction at the last minute and winning it with no intention to use it.

For this reason, there has been attention toward [Vickrey auctions](https://en.wikipedia.org/wiki/Vickrey_auction), a variant of second price auction in which bids are hidden and only revealed in a later phase. The candle auction is another solution which does not need the two-step commit and reveal schemes like Vickrey auctions, and for this reason allows smart contracts to participate.

Candle auctions make it so that everyone always know the states of the bid, but not when the auction will be determined to have "ended." This helps to ensure that bidders are willing to bid their true bids early. Otherwise they might find themselves in the situation that the auction was determined to have "ended" before they even bid.

## How it's used in Polkadot

Polkadot will use a _random beacon_ based on the VRF that's used also in other places of the protocol. This will determine the "end-time" of the auction.

When an account bids, they can place bids for any of the available units or ranges in a slot. However, if a parachain (with the same STF) bids then that parachain must bid on a continuous unit or range to the one they already occupy. They will not be able to bid for an overlapping slot (no multiples of the same parachain at the same time) and they will not be able to bid for a future slot if there is a gap in between. In the case a parachain is rebooted after having already reached the conclusion of its slot duration, it will need to be started again from a new genesis (which could be snapshot of all the old state) and will need to be bid from an external account.

## How does bidding work?

```
Parachain slots at genesis

       --6 months--
       v          v
Slot A |     1    |     2    |     3     |     4     |...
Slot B |     1    |     2    |     3     |     4     |...
Slot C |__________|     1    |     2     |     3     |     4     |...
Slot D |__________|     1    |     2     |     3     |     4     |...
Slot E |__________|__________|     1     |     2     |     3     |     4     |...
       ^                                             ^
       ---------------------2 years-------------------      

Each unit of the range 1 - 4 represents a 6-month duration for a total of 2 years
```

Each parachain slot has a maximum duration of 2 years. Each 6 month interval in the slot is divided into its own `unit`. More than one continuous `unit` is a `range`.

Auctions will take place 6 months before the parachain slot begins.

Bidders will submit configuration of bids specifying the DOT amount they are willing to lock up and for which ranges. The slot ranges may be any continuous range of the units 1 - 4.

A bidder configuration for a single bidder may look like this:

```js
Bids [
       {
              range: [1,2,3,4],
              bond_amount: 20, //DOTs
       },
       {
              range: [1,2],
              bond_amount: 30, //DOTs
       },
       {
              range: [2,3,4],
              bond_amount: 25, // DOTs
       }
]
```

The winner selection algorithm will pick bids which may be non-overlapping in order to maximize the amount of staked DOTs over the 4 units of the parachain slot.

A random number is determined at each block which is based on the VRF used by Polkadot. Additionally, each auction will have a threshold that starts at 0 and increases to 1. The random number produced by the VRF is examined next to the threshold to determine if that block is the end of the auction. Additionally, the VRF will pick a block from the last epoch to take the state of bids from (to mitigate some types of attacks from malicious validators).

### Examples

#### Non-compete

There is one parachain slot available.

Alice bids `20 DOTs` for the range 1 - 2.

Bob bids `30 DOTs` for the range 3 - 4.

The auction ends.

Alice bonds `20 DOTs` and will have the parachain slot for the first year.

Bob bonds `30 DOTs` and will have the parachain slot for the second year.

#### Compete

There is one parachain slot available.

Charlie bids `75 DOTs` for the range 1 - 4.

Dave bids `100 DOTs` for the range 3 - 4.

Emily bids `40 DOTs` for the range 1 - 2.

Let's calculate every bidder's valuation according to the algorithm. We do this by multiplying the bond amount by the amount of units in the specified range of the bid.

Charlie - 75 * 4 = 300 for range 1 - 4

Dave - 100 * 2 = 200 for range 3 - 4

Emily - 40 * 2 = 80 for range 1 - 2

Although Dave had the highest bid in accordance to DOT amount, when we do the calculations we see that since he only bid for a range of 2, he would need to share the slot with Emily who bid much less. Together Dave's and Emily's bids only equal a valuation of `280`. 

Charlie's valuation for the entire range is `300` therefore Charlie is awarded the complete range of the parachain slot.

## Why doesn't everyone bid for the max length?

For the duration of the slot the `DOTs` bid in the auction will be locked up. This means that there are opportunity costs from the possibility of using those `DOTs` for something else. For parachains that are beneficial to Polkadot, this should align the interests between parachains and the Polkadot relay chain.
