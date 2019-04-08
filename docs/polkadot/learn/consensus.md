# Polkadot Consensus

## Why do we need consensus?

## Hybrid Consensus


## Probable Finality vs. Provable Finality

Proof of Work blockchains which run versions of [Nakamoto consensus](#nakamoto-consensus) are only able to achieve the notion of _probable finality_. Probably finality, also sometimes termed "eventual consensus", is that under some assumptions about the network and participants, if we see a few blocks building on a given block, we can estimate the probability that it is final. However, finality gadgets such as GRANDPA or Ethereum's Casper are designed to give stronger guarantees on the finality of blocks, that they can never be reverted after some process has taken place. The notion of irreversible consensus is known as _provable finality._

In the GRANDPA paper, it is phrased in this way:

> We say an oracle A in a protocol is _eventually consistent_ if it returns the same value to all participants after some unspecified time.

## What is GRANDPA/BABE?

### GRANDPA: Finality Gadget

### "Polite" GRANDPA

### BABE: Block Production

## Comparisons

### Nakamoto consensus

Probable finality as found in all Proof of Work chains is known as Nakamoto consensus. Nakamoto consensus is _safe_ with up to 50% byzantine nodes, but has the major trade-off that it is not _safe_. The most that Nakamoto consensus can ensure that a block in the past will not be reverted is dependent on the property of probable finality. Probable finality states that a block in the past is only as safe as the number of confirmations it has, or the number of blocks that have been built on top of it. As the more blocks are built on top of a specific block in a Proof of Work chain, the more computational work has been expended behind this particular chain. However, it does not guarantee that the chain containing the block will always remain the agreed-upon chain, since an actor with unlimited resources could potentially build a competing chain and expend enough computational resources to create a chain that did not contain a specific block, and the longest chain rule employed in Bitcoin and other Proof of Work chains would move to this new chain as the canonical one.

### PBFT

### Tendermint

### HoneyBadgerBFT

### Casper CBC

### Avalanche