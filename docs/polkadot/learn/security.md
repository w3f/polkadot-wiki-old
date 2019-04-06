# Security of the network

## Pooled security

Polkadot is designed to have pooled security on the relay chain and across parachains. This means that each parachain that is connected to the Polkadot network will have the same strong security guarantees of the relay chain. 

### Example

Let's compare a non-shared security model like exists on current proof-of-work (PoW) chains to that of the shared security of Polkadot. Chains that are secured by sovereign PoW like Bitcoin, ZCash, Ethereum, and their derivatives all must maintain their own independent networks with its own hash power. Since mining is becoming more and more competitive, the amount of hashing power which is needed to mine a block on the big chains is becoming more as well. This means that smaller chains which cannot maintain the same amount of hash power on their networks could easily be attacked by a large mining cartel if it chooses to direct its power away from Bitcoin and toward a new and less secure chain.

On Polkadot, this disparity between chain security will not be present. When a parachain connects to Polkadot, the relay chain validator set become the securers of that chain's state transitions. The parachain will just need to run a few collator nodes to keep the validators informed with the latest state transitions and proofs. Validators will then check these for the parachains for which they are assigned. In this way, new parachains instantly benefit from the overall security of Polkadot even if they have just been launched.

## How security is related to # of validators

The pooled security of the relay chain is provided by the validator set. Loosely, as the numbers of validators increases so does the security of Polkadot. Security is independent from the number of parachains. 