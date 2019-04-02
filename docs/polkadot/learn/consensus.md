# Polkadot Consensus

## Why do we need consensus?

## Hybrid Consensus



## What is GRANDPA/BABE?

### GRANDPA: Finality Gadget

### "Polite" GRANDPA

### BABE: Block Production

## Comparisons

### Nakamoto consensus

Probable finality as found in all Proof of Work chains is known as Nakamoto consensus. Nakamoto consensus is _safe_ with up to 50% byzantine nodes, but has the major tradeoff that it is not _safe_. The most that Nakamoto consensus can ensure that a block in the past will not be reverted is dependent on the property of probable finality. Probable finality states that a block in the past is only as safe as the number of confirmations it has, or the number of blocks that have been built on top of it. As the more blocks are built on top of a specific block in a Proof of Work chain, the more computational work has been expended behind this particulat chain. However, it does not guarentee that the chain containing the block will always remain the agreed-upon chain, since an actor with unlimited resources could potentially build a competing chain and expend enough computational resources to create a chain that did not contain a specific block, and the longest chain rule employed in Bitcoin and other Proof of Work chains would move to this new chain as the canonical one.

### PBFT

### Tendermint

### HoneyBadgerBFT

### Casper CBC

### Avalanche