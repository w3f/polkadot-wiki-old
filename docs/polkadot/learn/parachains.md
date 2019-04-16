# Parachains

## What is a parachain?

Parachains take their name from the concept of "parallelized" chains which share in the security of the Polkadot relay chain. Parachains are _validatable, globally-coherent dynamic data-structures_ which can connect into the Polkadot network and although most commonly will resemble independent blockchains, there is no specific need for them to be blockchain in nature.

Rob Habermeier, a co-founder of Polkadot, [described parachains in the following way](https://medium.com/polkadot-network/polkadot-the-parachain-3808040a769a):

> A parachain (parallelizable chain) is a simpler form of blockchain, which attaches to the security provided by a ‘relay chain’ rather than providing its own. The relay chain provides security to attached parachains, but also provides a guarantee of secure message-passing between them.

The Polkadot architecture allows for the state transitions performed on the parachain to be specified as a Wasm executable. Proofs of new state transitions that occur on a parachain must be validated against the registered state transition function (STF) by validators before the state transition can take place.

## Benefits of parachains

By connecting to Polkadot a parachain gains two major advantages over an independent _sovereign chain:_

- [Pooled security](./security.md)
- [Trust-free interchain transactability](./interchain.md)

## Examples

- Encrypted Consortium Chains
- High Frequency Chains
- Privacy Chains
- Smart Contract Chains

## Collators

Parachains are operated and new blocks are authored by [collator nodes](../node/collator.md) that maintain "full-nodes" of a particular parachain. They retain all necessary information to be able to propose new blocks and execute transactions in a similar way as miners do in traditional PoW blockchains. A block proposed by a collator node will be checked by the validator node before it is accepted as a canonical state transition by the relay chain.

## What is "parachain consensus"

"Parachain consensus" is special in that it will follow the Polkadot relay chain. Parachains cannot use other consensus algorithms that provide their own finality, and if they do will be sovereign chains that must bridge to the relay chain. Parachains have control over how blocks are authored and by who.

## Deploying parachains

Please see the builder's article on [deploying parachains](../build/deploy-parachains.md).
