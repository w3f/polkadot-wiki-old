# Polkadot Consensus

## Why do we need consensus?

Consensus is a method for coming to agreement over a shared state. In order for the state of the blockchain to continue to build and move forward, all nodes in the network must agree and come to consensus. It is the way that the nodes in a decentralized network are able to stay synced with each other. Without consensus for the decentralized network of nodes in a blockchain, there is no way to ensure that the state one node believes is true will be shared by the other nodes. Consensus aims to provide the _objective_ view of the state amid participants which each have their own _subjective_ views of the network. It is the process for which these nodes communicate and come to agreement, and are able to build new blocks.

## Probable Finality vs. Provable Finality

Proof of Work blockchains which run versions of [Nakamoto consensus](#nakamoto-consensus) are only able to achieve the notion of _probable finality_. Probably finality, also sometimes termed "eventual consensus", is that under some assumptions about the network and participants, if we see a few blocks building on a given block, we can estimate the probability that it is final. However, finality gadgets such as GRANDPA or Ethereum's Casper are designed to give stronger guarantees on the finality of blocks, that they can never be reverted after some process has taken place. The notion of irreversible consensus is known as _provable finality._

In the GRANDPA paper, it is phrased in this way:

> We say an oracle A in a protocol is _eventually consistent_ if it returns the same value to all participants after some unspecified time.

## What is GRANDPA/BABE?

### Hybrid Consensus

There are two acronyms we use when we talk about the consensus protocol of Polkadot, GRANDPA and BABE.

### GRANDPA: Finality Gadget

GRANDPA (GHOST-based Recursive ANcestor Deriving Prefix Agreement) is the finality gadget that is implemented for the Polkadot relay chain.

It works in partially synchronous network models and can cope with 1/5 Byzantine nodes in an asynchronous setting.

A notable distinction is that GRANDPA reaches agreements on chains rather than blocks.

### "Polite" GRANDPA

### BABE: Block Production

## Comparisons

### Nakamoto consensus

Probable finality as found in all Proof of Work chains is known as Nakamoto consensus. Nakamoto consensus is _safe_ with up to 50% byzantine nodes, but has the major trade-off that it is not _safe_. The most that Nakamoto consensus can ensure that a block in the past will not be reverted is dependent on the property of probable finality. Probable finality states that a block in the past is only as safe as the number of confirmations it has, or the number of blocks that have been built on top of it. As the more blocks are built on top of a specific block in a Proof of Work chain, the more computational work has been expended behind this particular chain. However, it does not guarantee that the chain containing the block will always remain the agreed-upon chain, since an actor with unlimited resources could potentially build a competing chain and expend enough computational resources to create a chain that did not contain a specific block, and the longest chain rule employed in Bitcoin and other Proof of Work chains would move to this new chain as the canonical one.

### PBFT

### Tendermint

### HoneyBadgerBFT

### Casper FFG

The two main differences between GRANDPA and Casper FFG (Friendly Finality Gadget) are:

 - in GRANDPA, different voters can cast votes simultaneously for blocks at different heights
 - GRANDPA only depends on finalized blocks to affect the fork-choice rule of the underlying block production mechanism

### Casper CBC

_Coming soon!_

### Avalanche

## Resources

- [GRANDPA paper](https://github.com/w3f/consensus/blob/master/pdf/grandpa.pdf) - The academic description of the GRANDPA finality gadget. Contains formal proofs of the algorithm.
- [Rust implementation](https://github.com/paritytech/finality-grandpa) - The reference implementation and the accompanying [Substrate runtime module](https://github.com/paritytech/substrate/blob/master/srml/grandpa/src/lib.rs).