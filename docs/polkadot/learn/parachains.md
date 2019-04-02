# Parachains

## What is a parachain?

Polkadot aims to solve the big problems facing blockchain technology today. It does so by employing a multichain protocol that allows for independent chains, called _parachains_, to interoperate. Parachains are able to interoperate since they are connected into the same base layer called the [Polkadot Runtime Environment](./PRE.md). 

Rob Habermeier, a co-founder of Polkadot, [described parachains in the following way](https://medium.com/polkadot-network/polkadot-the-parachain-3808040a769a):

> A parachain (parallelizable chain) is a simpler form of blockchain, which attaches to the security provided by a ‘relay chain’ rather than providing its own. The relay chain [provides] security to attached parachains, but also provides a guarantee of secure message-passing between them.

The Polkadot architecture allows for the state transitions performed on the parachain to be specified as a WASM executable. Proofs of new state transitions that occur on a parachain must be validated against the registered state transition function (STF) by validators before the state transition can take place.

## Benefits of parachains

Parachains have major benefits over the purely sovereign chains that are not connected to Polkadot.

- [Pooled security](./security.md)
- [Interchain messaging](./interchain.md)

## Deploying parachains

Please see the builder's article on [deploying parachains](../build/deploy-parachains.md).
