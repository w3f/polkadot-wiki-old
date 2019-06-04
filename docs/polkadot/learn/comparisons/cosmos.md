# Polkadot vs. Cosmos: Design Comparison

> Disclaimer: This article compares Polkadot to "Cosmos v1.0" meaning the original Cosmos design as explained in the Cosmos whitepaper. At a later date another comparison can be made regarding new Cosmos proposals and comparing them to the next generation features of Polkadot v2.0.

Polkadot is a heterogeneous multichain with scalable security and the ability to send messages between each other.

Cosmos is a network of individual chains which have their own security and bridges between them that enables the transfer of assets.

## Architecture

Polkadot is composed of a singular relay-chain which sits in the middle of the multichain and is where the validator set pools the security. Parachains, something of cross between a sidechain and a shard, connect to the Polkadot relay-chain and can share in the security of the validator set. Validators are able to verify that messages get routed between all connected parachains without needing to also be full validating nodes of the parachain. This is done through the work of collator nodes which are the full nodes of parachains and have the responsibility of processing the extrinsics (more general form of transaction). They then hand a proof of validity block to the subset of validators that have been selected for each individual parachain. Validators must only perform a check of validity against the state transition verification function and in this way are able to scale to higher throughput.

Cosmos takes the sovereign-first approach of all of their chains and say they must run Tendermint consensus with individual economic security and their own validator sets. In order to solve scalability Cosmos uses the notion of Hub and spokes to create a central chain which will bridge to other chains (called zones). The idea is that the central chain that bridges to all other chains, called the Cosmos Hub, will be in charge of transferring assets around the network.

## Trust model

The trust model of both Polkadot and Cosmos revolve around the notion of validator's stake and the ability to slash validators if they go Byzantine or commit a wrongdoing. 

In Polkadot, however, the trust model is to trust the relay-chain validators since the relay-chain is where all of the security is pooled. The validators are responsible for the _shared state_ of the entire Polkadot network, so if one parachain is corrupted they will be able to revert the incorrect state transitions and slash the wrongdoing validators.

Cosmos places trust on every independent validator sets of all the chains which are bridged. This leads to some problems since Cosmos cannot really guarantee that coins will not get double spent by being sent to two isolated chains. To try to mitigate this, they introduced the Cosmos Hub which is aware of the state of all connected bridges, but the solution is sub-optimal because there is no way to slash a double-spending chain's validators.

## Interoperability 

Polkadot and Cosmos both claim blockchain interoperability.

Polkadot uses the Interchain Message Passing (ICMP) protocol to send messages between parachains. The messages which are passed can be any arbitrary string of bytes, meaning they could be encoded to be asset transfers or more complex cross-chain calls. ICMP is trustless because it is verified by the validator as part of the validity check of each new parachain block that the messages will be included. Validators only accept new parachain blocks if they've included all of the incoming messages from other parachains (given a one or two blocks buffer). Additionally, the Shared Protected Runtime Execution Environment (SPREE) gives even stronger guarantees that the messages will trigger the same exact code across parachains.

Cosmos, in comparison, is only able to achieve asset transfers between its bridges. Further work is being done to specify their Inter-blockchain communication (IBC) protocol into a TCP-like transfer protocol between the Cosmos bridge chains. IBC treats each blockchain like its own process because Cosmos has no notion of shared state, unlike in Polkadot where all parachains are considered one state with the relay-chain. Additionally, Polkadot will incorporate bridges to external pre-existing chains and this may look somewhat like IBC.

> Protip: For more on SPREE see here.

## Validity

In Polkadot validity of the entire state of the network is secured by 100% of the validators. The way this happens is as follows: validators will be shuffled into groups (subsets) and assigned to be validating for specific parachains. Every time a parachain submits a proof of a new block (i.e. the state transition), the subset of validators will verify its validity using only a proof and the necessary data. The validators then must only commit the hash of the parachain header to the relay chain block in order to include it. In this way, the parachain execution is compressed first into a proof and given to a subset of validators which then compress it further before writing it onto the relay chain.

Cosmos does not treat validity in the same way. Validity for Cosmos chains require the entire validator sets of each chain to sign off on every block, and to perform the complete verification on the transactions in the blocks. The acts of compression which take place during Polkadot's validity checking process do not happen during Cosmos' process. For this reason, the scalable security of Cosmos is much more skeptical when compared to Polkadot.

## Availability

Polkadot has additional mechanisms which guarantee the availability of data and gives even stronger security assurances. Namely, these are the use of erasure codes for parachain data availability among the entire validator set and fishermen which are bounty hunters that watch for invalid validator behaviors. 

Cosmos chains must keep the entire data for the chains they are validating, and for bridge chains will need to be also a light client of that chain. Cosmos does not use erasure codes or fishermen.

## Consensus

Polkadot uses a hybrid consensus composed of BABE, a block production mechanism and GRANDPA, a Byzantine finality gadget.

Cosmos uses Tendermint BFT consensus, which is closely inspired by Practical Byzantine Fault Tolerance (PBFT).

### Finality

Polkadot's GRANDPA finality gadget comes to finality on _chains of blocks_ rather than individual blocks. This is largely different from Cosmos, which comes to consensus on every block. In fact, Cosmos' Tendermint algorithm conflates the act of block production with the finality, which means that blocks can only be produced if they have been finalized. GRANDPA, instead is placed on top of the block production (BABE), and can finalize more than one block at once, making the overall consensus process run quicker.

### Liveness

Polkadot has stronger liveness than Cosmos' Tendermint.

In Tendermint, block production will stop along with the finality, once more than 1/3 of the validator set has become Byzantine. 

While Polkadot's GRANDPA will also stop finalizing blocks once more than 1/3 of the validator set is Byzantine, BABE will continue to produce blocks. Once the validator set has been restored by either kicking out the unresponsive validators or validators coming back online, GRANDPA will start to finalize on all the blocks BABE has produced in the meantime.

### Validator selection (PoS)

Polkadot uses a nominated Proof-of-Stake (NPoS) scheme to elect its validator set. Since the NPoS algorithm gives equal voting weights to each validator, an equalizing algorithm known as Phragmen's method is used to distribute the nominated DOTs equally among all validators as evenly as possible.

Tendermint uses a weight-based proof-of-stake algorithm which gives validators voting power based on the amount of ATOM tokens they hold (or are delegated). This means that the top stakers on the Cosmos Hub are more centralized. Currently only 15 out of 100 validators control 1/3 of the stake[cite] and thus could halt the finalization procedure of the network. In Polkadot, the number of validators will always be 33% of the total (so with 100 validators, 33). 

## Programming languages

Cosmos favors the Go programming language and has currently constructed the Cosmos-SDK in Go. A JavaScript library also exists.

In comparison, Polkadot currently has 5 in progress implementations in the languages: Rust, Go, JavaScript, Go (there are two), and C++. Additionally, Polkadot is made to use Web Assembly for its runtime compilation target, which means that any language that can compile to Wasm could be used to construct a parachain or write a smart contract for a Polkadot parachain.

## Conclusion

We have seen that Polkadot has a shared state multichain architecture compared to the Cosmos independent bridged chains network. Further, we have demonstrated that the trust model of Polkadot is more robust than that of Cosmos. The ICMP of Polkadot is also more generic, faster, and safer to use than that of Cosmos' IBC. Polkadot makes innovations in validity and availability that are simply not present in the Cosmos design. The hybrid BABE/GRANDPA consensus is shown to be able to reach finality more rapidly on chains of blocks than Tendermint's algorithm which can only finalize one block at a time. There are additionally stronger liveness guarantees because of the BABE block production. Validator set selection using the Phragmen method in Polkadot is more advanced than Cosmos' stake weighted voting. Finally, Polkadot embraces a broad ecosystem of programming languages thanks to its backbone of WebAssembly, while Cosmos favors the Go programming language.

## FAQ

### Do parachains need to connect to the relay chain or can they be sovereign chains like in Cosmos?

Parachains by definition must connect to the Polkadot relay chain to be considered a _parachain_. This is so that the parachain can benefit from the shared security and interoperability of ICMP. Similarly, in order for a Tendermint chain to take advantage of the interchain messages of Cosmos, it is understood they connect to a hub.

However, if a chain does not wish to take place in the benefits of connecting to the Polkadot relay chain then it is possible for them to use the same tools to create a standalone chain. Using Substrate, a development team can create their own blockchain and later decide if they would want to lease the security from Polkadot by becoming a parachain. In Cosmos, sovereign chains have no choice with regard to where their security comes from. Every chain on Cosmos must have their own validator set regardless of if they connect to a hub or not.

### Is GRANDPA/BABE/NPoS similar to PBFT?

No not really. PBFT is a consensus algorithm (but not a blockchain consensus algorithm) that dictates how messages are circulated through the network. It cannot act as a blockchain consensus by itself due to most notably being exploitable through the _nothing at stake_ problem. There exists some similarity between GRANDPA and Byzantine-fault-tolerant (BFT) algorithms in general since GRANDPA is designed as a Byzantine finality gadget. However, the overall consensus of Polkadot which is composed of the three pieces of GRANDPA, BABE, and NPoS cannot be claimed to be similar to PBFT as it would just cause confusion. Even in Tendermint, which is based on PBFT, the added PoS validator set selection algorithm is needed to make it into a full blockchain consensus mechanism.

### Is Polkadot only going to work with PoS chains? How is it trustless in comparison to Cosmos?

Polkadot is primarily designed to be a very efficient and minimal heterogeneous multi-chain platform. Bridges to pre-existing or "foreign" chains are one potential use-case for it. Such bridges can be to either PoW or PoS chains and in terms of the Polkadot protocol it makes little difference (as it does in some protocols such as Bitcoin's Sidechains that works specifically with SHA256 PoW and Cosmos's zones that works only with Tendermint PoS). Polkadot's parachain abstraction is neither PoS nor PoW specific. If you want to call it anything, it's "PoV" or Proof of Validity. As such Polkadot is entirely agnostic. As long as you can succinctly demonstrate that a block is "valid" under your chain's technology (basically this means being able to build a light client), then you can probably plug it into Polkadot one way or another.

## Quick Facts

|   |Cosmos|Polkadot|
|---|---|---|
|Consensus|Tendermint (modified PBFT + PoS)|GRANDPA/BABE/NPoS|
|Governance|Signaling only|Referendum and Council representing passive stakeholders|
|Interoperability|Inter-blockchain Communication (IBC)|Interchain Message Passing (ICMP)|
|Security|Each zone needs own security|Shared security for parachains|
|Topology|Hub and zones|Relay chain and parachains|
|Token|Atom|Dot|


## Further Reading

[iris]: https://www.irisnetwork.cn
[tendermint latest gossip]: https://arxiv.org/pdf/1807.04938.pdf
[ibc architecture]: https://github.com/cosmos/ics/blob/master/ibc/1_IBC_ARCHITECTURE.md
[icmp]: ../interchain.md
[cosmos-sdk]: https://github.com/cosmos/cosmos-sdk
[implementations]: ../implementations.md
[pdk]: ../../build/pdk.md
[parity]: https://parity.io
[wasm]: https://webassembly.org
[spree]: ../spree.md

# Message passing 

- design is better
- shared state  (relay chain defines what is happening on parachains)
- pass data in one relay chain block
- data is passed than how fast finality is
- message passing is quicker
