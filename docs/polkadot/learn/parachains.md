# Parachains

## What is a parachain?

Parachains take their name from the concept of "parallelized" chains which are connected to and share in the security of the Polkadot relay-chain. Parachains are validatable, globally-coherent dynamic data-structures. Most commonly they will resemble blockchains but there is no specific need for them to be blockchain in nature.

The only constraints on what type of logic can be implemented for a parachain is that must be able to be bundled in a proof (known as a Proof-of-Verification block) and submitted to validators to be checked.

Rob Habermeier, a co-founder of Polkadot, [described parachains in the following way](https://medium.com/polkadot-network/polkadot-the-parachain-3808040a769a):

> A parachain (parallelizable chain) is a simpler form of blockchain, which attaches to the security provided by a ‘relay chain’ rather than providing its own. The relay chain provides security to attached parachains, but also provides a guarantee of secure message-passing between them.

The Polkadot architecture allows for the state transitions performed on the parachain to be specified as a Wasm executable. Proofs of new state transitions that occur on a parachain must be validated against the registered state transition function (STF) by validators before the state transition can take place.

## Benefits of parachains

By connecting to Polkadot a parachain gains two major advantages over an independent chain:

- [Shared security](./security.md)
- [Trust-free interchain data transmission](./interchain.md)

## Examples

- **Encrypted Consortium Chains** - These are possibly private chains that do not leak any information to the public, but still can be interacted with trustlessly due to the nature of the ICMP protocol. 
- **High Frequency Chains** - These are chains which can compute many transactions in a short amount of time by taking certain trade-offs or making optimizations. 
- **Privacy Chains** - These are chains which do not leak any information to the public through use of novel cryptography.
- **Smart Contract Chains** - These are chains which can have additional logic implemented on them through the deployment of code known as _smart contracts_.

## Collators

Parachains are operated and new blocks are authored by [collator nodes](../node/collator.md) that maintain "full-nodes" of a particular parachain. They retain all necessary information to be able to propose new blocks and execute transactions in a similar way as miners do in traditional PoW blockchains. A block proposed by a collator node will be checked by the validator node before it is accepted as a canonical state transition by the relay-chain.

## Parachain economies

Parachains may have their own economies with their own native tokens. Schemes such as Proof-of-Stake are usually used to select the validator set in order to handle validation and finalization; parachains will not be required to do either of those things. However, since Polkadot is general over what the parachain can implement, it may be the choice of the parachain to implement a staking token, but it's not generally necessary.

Collators may be incentivized through inflation of a native parachain token. There may be other ways to incentivize the collator nodes which do not involve inflating the native parachain token.

Transaction fees in a native parachain token can also be an implementation choice of parachains. Polkadot makes no hard and fast rules for how the parachains decide on original validity of transactions. For example, a parachain may be implemented so that transactions must pay a minimum fee to collators to be valid. The relay chain will enforce this validity. Similarly, a parachain could not include that in their implementation and Polkadot would still enforce its validity.

Parachains are not required to have their own token and if they do it is up to the parachain to make the economic case for their token, not Polkadot.

## FAQ

### What is "parachain consensus"?

"Parachain consensus" is special in that it will follow the Polkadot relay chain. Parachains cannot use other consensus algorithms that provide their own finality, and if they do will be sovereign chains that must bridge to the relay chain. Parachains have control over how blocks are authored and by who.

### How will parachain slots be distributed?

Parachain slots will be acquirable through auction, please see the [parachain slots](./auction.md) article.

### Parachain Development Kits (PDKs)

Parachain Development Kits are a set of tools that enable developers to create their own applications as parachains. For more info see [here](../build/pdk.md). 

### Deploying parachains

Please see the builder's article on [deploying parachains](../build/deploy-parachains.md).
