# Compare: Polkadot and Cosmos

Polkadot and Cosmos share similar goals including interoperability among blockchains, and better security guarantees through use of a Byzantine tolerant finalization mechanism. ...

## Architecture

In rough terms we can compare the architecture of both protocols by relating the relay chain and parachains model to that of hubs and zones.

### Polkadot: Relay chain and parachains

The Polkadot network is composed of the relay chain and a number of (between 1 - 200+) connected parachains. Some of these parachains will  act as bridges to already established networks such as Bitcoin, Ethereum, or Tezos. All of the parachains that are connected to the relay chain will share in the security of the relay chain validator set. All state transitions of the parachains will be recorded on the relay chain and finalized using GRANDPA, the relay chain finality gadget. Eventually Polkadot will scale by becoming a relay chain of relay chains, by utilizing its parachain slots as kinds of relay chains which can connect to parachains of its own.

### Cosmos: Hub and zones

The Cosmos network consists of the Cosmos hub which acts as the central point of routing messages across the connected zones. Cosmos terminology uses _zone_ to mean a chain that is connected to the hub. The hubs and zones are all Tendermint consensus PoS chains with the quality of fast finality. Cosmos does not require that zones be connected to the Cosmos hub, and there are projects such as [Iris network][iris] which have built an alternative hub. This is an important distinction from Polkadot, where the relay chain will be the central pool of security for all the connected parachains.

## Consensus

Polkadot uses a trifecta of the GRANDPA finality gadget, BABE block production, and Nominated Proof-of-Stake (NPoS) validator selection as its consensus framework.

Cosmos uses the [Tendermint][tendermint latest gossip] consensus algorithm with PoS validator selection. The Tendermint consensus algorithm is based on the practical Byzantine-Fault-Tolerant (PBFT) consensus with modifications to make it better suited to high-frequency gossip networks.  

For those brave souls who want to know more about how each consensus mechanism compares, we've broken it down into a few sections below.

### Finality

Both the Polkadot relay chain and Cosmos hub will achieve finality under favorable network conditions with the assumption that > 2/3 of the validator set is available and honest. Once > 2/3 of the validator set has signed off on a block (or, in the case of GRANDPA a chain of blocks) those blocks are considered final and unable to be reverted. In comparison, Nakamoto consensus as used in most PoW blockchains can only guarantee probably finality at best.

The time-to-finality of both GRANDPA and Tendermint are limited by the bandwidth limit and latency on the network. As the number of validators increases, so will the number of messages that must get sent between them thereby slowing down the finality mechanism. Both Polkadot and Cosmos are interested in moving to as large of a validator set as possible without horrendously slowing down the network. In practical terms, Cosmos launch with 100 validators and Polkadot will launch with 50 - 100 and quickly scale up to around 1000.

One key difference between Tendermint and the consensus mechanism of Polkadot is how each protocol treats the act of block production. 

### Validity

Tendermint decides validity based on an application specific `validate()` function. And states that:

> In blockchain systems, a value is not valid if it does not contain an appropriate hash of the last value (block) added to the blockchain.

This is different from how GRANDPA comes to consensus on chains. Due to the constraint that Tendermint uses the block and the prior block hash as part of its validity function, it ties its finality gadget to its block production by design.

GRANDPA instead is a finality gadget that is working as a separate process to the block production mechanism (BABE).

Tendermint algorithm is based on a single cornerstone assertion: `n > 3f` where `n` is the total voting power of the system and `f` is the total voting power of "faulty processes" or malicious nodes in the system. This means that the minimum voting power required for Tendermint to continue operation is `n = 3f +1`. 

- Tendermint requires 2 voting steps (three communication exchanges in total) to decide a value.
 

### Availability

Tendermint will safely halt if more than 1/3 of the validator set goes offline.

Similarly GRANDPA will stop finalizing blocks if more than 1/3 of the validator set cannot be reached, however blocks will continue to be produced with BABE. 

### Finality

Finality for both Cosmos' Tendermint and algorithm and Polkadot's GRANDPA finality gadget are bounded by the bandwidth and latency of the messages which are able to propagate among the validator peers in the network. As the numbers of validators increases, the amount of nodes which must sign each message before consensus is reached expands and thereby causes the finality gadget to slow down. Among a small group of nodes, say 5, the latency for coming to consensus under either one of these algorithms could be low and the finality fast. As the numbers of validators increases to 100 and beyond both algorithms would slow down. In a decentralized network, a larger validator set is preferred because it is more resilient to take down, and the security guarantees are higher. Both networks have expressed interest in moving to larger validator sets. 

The key difference between Cosmos and Polkadot is that _block production_ is conflated with the _finality gadget_ in Cosmos' Tendermint while in Polkadot these two things are separate. What this means is that both network's algorithms will reach finality in similar time frames based on the size of the validator set and network latency, but Polkadot will produce blocks faster than the finality time. Tendermint is bounded on the speed of their block production due to the time-to-finality, while Polkadot's block production could potential reach speeds much higher than the time-to-finality.

Additionally, since GRANDPA comes to finality on chains rather than individual blocks in the chain, it could be that under similar conditions (same size validator set) Polkadot will have faster finality on more blocks than is possible under an algorithm like Tendermint where each block must be agreed upon in the consensus algorithm one at a time.

<div class="grandpa-img">
    <a href="../../../../img/GRANDPA/chain-selection.png" target="_blank">
        <img src="../../../../img/GRANDPA/chain-selection.png" alt="block production"/>
    </a>
    <p>Visual 1.1</p>
</div>

For a visualization of what we mean by GRANDPA comes to finality on "chains" rather than blocks, consider `Visual 1.1`.

<!-- right now this links to Rob's article but later will link to the wiki consensus page -->
_For more on Polkadot consensus please see [here](https://medium.com/polkadot-network/grandpa-block-finality-in-polkadot-an-introduction-part-1-d08a24a021b5)_

## Shared security vs. sovereign security

The Polkadot architecture is designed so that the security of the network pools to the relay chain via the relay chain validator set. The relay chain can share its security to the connected parachains, once the parachain has bonded DOTs to lease a slot. The benefit is that any chain which connects to Polkadot will not need to set up its own economic security or have to worry at all about consensus. Paying out validators to secure a chain is expensive (usually paid by inflation or block reward), and it is anticipated that the parachain slot lease will be cheaper. Additionally, parachains only need to bond their DOTs and not pay them directly.

In Cosmos, all chains are sovereign and expected to maintain their own economic security. Each chain must run a "fast finality" consensus mechanism (which in practice will often be the Tendermint consensus) if it would like to benefit from connection to the Cosmos Hub. __Cosmos may have a notion of shared security and needs input from their team.__

> Cosmos is a consensus bridge solution and **not** a validation bridge solution. There is no attempt in the Cosmos network to validate the sub-chains, and the hub can track all token transfers. Chains on Cosmos cannot trust each other since each is economically independent. The same Cosmos zone can spend resources on 2 other Cosmos zones and there would be no way for the zones to have information about this double spend unless they get it from the Cosmos hub.

Polkadot has a strong guarantee over the global state of the relay chain and all connected parachains since they all share the same economic security set. Cosmos does not have the same guarantee over the global state, since each chain maintains their own local security. What happens on one chain has no way of coordinating with what happens on another chain unless through some off-chain communications system.


## Interoperability between chains

Cosmos proposes the Inter-blockchain communication (IBC) standard for the transmission of messages across zones. Polkadot uses Interchain Message Passing (ICMP) for communication among the parachains. The designs and the goals of each standard are notably different due to the two worldviews of Cosmos and Polkadot.

### Inter-blockchain Communication (IBC)

The [IBC protocol][ibc architecture] is a standard by which various ledgers (blockchains) may communicate with each other. It is an infrastructure level protocol that handles data transport, reliability, and authentication. One of the use cases of IBC is to transfer assets via the Cosmos Hub, but it is not limited only to token transfers. The IBC protocol does not rely on the Cosmos Hub and zone model, and can be used for transmitting messages between chains arranged in a variety of network topologies.

<!-- Illustration of various network topologies such as Hub and spoke, hierarchical relay chain and parachains, two sovereign chains -->

### Interchain Message Passing (ICMP)

The Polkadot ICMP is designed to work in the trustless environment of the relay chain via validator and collator nodes. ICMP allows for arbitrary messages to circulate between parachains and the messages to be guaranteed by the relay chain validator set. 

Messages which pass between parachains are strings of arbitrary bytes. Standards will form, similar to the ERC-20 standard for tokens, for how parachains will interpret certain encoding of messages and this will bring some order to the system. Otherwise, parachains have no constraints on how they will receive, interpret, or execute the messages (just that they will execute it). This allows for ICMP to be transfers of assets or more complex functionality such as smart contract calls. 

For fuller details on ICMP please see the [here][icmp].

### Similarities and differences?

Both protocols are designed for messaging between blockchains, but they do not really overlap since ICMP is reliant on the Polkadot architecture of relay chain and parachains while IBC is moving more toward a generic standard over chains with finality. <!-- Check <-- with Cosmos team --> 

In the future both standards will work in harmony, allowing all blockchains to communicate with each other. The relay chain of Polkadot would be able to transmit messages to the Cosmos Hub and back.

## Programming language

Cosmos has been committed to writing their own software using the **Go** programming language. For example, the [`cosmos-sdk`][cosmos-sdk] which contains the `gaia`, the reference implementation of the Cosmos Hub, is written in Go. The IBC protocol should be agnostic to programming language, and it is still undetermined which language will be the first implementation.

The Web3 Foundation has enlisted multiple teams to implement Polkadot [in several languages][implementations] ranging from Rust, C++, Go, and JavaScript. The leading implementation of the Polkadot runtime environment and the most advanced [parachain development kit][pdk] are written in Rust by [Parity Technologies][parity]. Compatibility with Polkadot only places the constraint on the programming language of choice that it must be able to compile to [**WebAssembly (Wasm)**][wasm]. To give an idea of the breadth of the Wasm ecosystem, a non-exhaustive list of languages that support Wasm compilation are Rust, Go, C++, TypeScript (AssemblyScript), OCaml, Brainfuck, and [more](https://github.com/appcypher/awesome-wasm-langs).  

## FAQ

### Do parachains need to connect to the relay chain or can they be sovereign chains like in Cosmos?

Parachains by definition must connect to the Polkadot relay chain to be considered a _parachain_. This is so that the parachain can benefit from the shared security and interoperability of ICMP. Similarly, in order for a Tendermint chain to take advantage of the interchain messages of Cosmos, it is recommended they connect to a hub such as the Cosmos or Iris hubs.

However, if a chain does not wish to take place in the benefits of connecting to the Polkadot relay chain then it is possible for them to use the same tools to create a standalone chain. Using Substrate, a development team can create their own blockchain and later decide if they would want to lease the security from Polkadot by becoming a parachain. In Cosmos, sovereign chains have no choice with regard to where their security comes from. Every chain on Cosmos must have their own validator set regardless of if they connect to a hub or not.

### Is GRANDPA/BABE/NPoS similar to PBFT?

No not really. PBFT is a consensus algorithm (but not a blockchain consensus algorithm) that dictates how messages are circulated through the network. It cannot act as a blockchain consensus by itself due to most notably being exploitable through the _nothing at stake_ problem. There exists some similarity between GRANDPA and Byzantine-fault-tolerant (BFT) algorithms in general since GRANDPA is designed as a Byzantine finality gadget. However, the overall consensus of Polkadot which is composed of the three pieces of GRANDPA, BABE, and NPoS cannot be claimed to be similar to PBFT as it would just cause confusion. Even in Tendermint, which is based on PBFT, the added PoS validator set selection algorithm is needed to make it into a full blockchain consensus mechanism.

### Is Polkadot only going to work with PoS chains? How is it trustless in comparison to Cosmos?

Polkadot is primarily designed to be a very efficient and minimal heterogeneous multi-chain platform. Bridges to pre-existing or "foreign" chains are one potential use-case for it. Such bridges can be to either PoW or PoS chains and in terms of the Polkadot protocol it makes little difference (as it does in some protocols such as Bitcoin's Sidechains that works specifically with SHA256 PoW and Cosmos's zones that works only with Tendermint PoS). Polkadot's parachain abstraction is neither PoS nor PoW specific. If you want to call it anything, it's "PoV" or Proof of Validity. As such Polkadot is entirely agnostic. As long as you can succinctly demonstrate that a block is "valid" under your chain's technology (basically this means being able to build a light client), then you can probably plug it into Polkadot one way or another.

## Quick Facts

|   |Cosmos|Polkadot|
|---|---|---|
|Consensus|Tendermint (modified PBFT + PoS)|GRANDPA/BABE/NPoS|
|Governance|Validator/Delegator Vote|Referendum and Council representing passive stakeholders|
|Interoperability|Inter-blockchain Communication (IBC)|Interchain Message Passing (ICMP)|
|Security|Each zone needs own security|Shared security for parachains|
|Topology|Hub and zones|Relay chain and parachains|
|Token|Atom|Dot|


## Further Reading

https://medium.com/polkadot-network/grandpa-block-finality-in-polkadot-an-introduction-part-1-d08a24a021b5

[iris]: https://www.irisnetwork.cn
[tendermint latest gossip]: https://arxiv.org/pdf/1807.04938.pdf
[ibc architecture]: https://github.com/cosmos/ics/blob/master/ibc/1_IBC_ARCHITECTURE.md
[icmp]: ../interchain.md
[cosmos-sdk]: https://github.com/cosmos/cosmos-sdk
[implementations]: ../implementations.md
[pdk]: ../../build/pdk.md
[parity]: https://parity.io
[wasm]: https://webassembly.org
