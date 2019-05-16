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

Both the Polkadot relay chain and Cosmos hub will achieve finality under favorable network conditions with the assumption that > 2/3 of the validator set is available and honest. Once > 2/3 of the validator set has signed off on a block (or, in the case of GRANDPA a chain of blocks) those blocks are considered final and unable to be reverted. In comparison, Nakamoto consensus as used in most PoW blockchains can only guarantee probable finality at best.

The time-to-finality of both GRANDPA and Tendermint are limited by the bandwidth limit and latency on the network. As the number of validators increases, so will the number of messages that must get sent between them thereby slowing down the finality mechanism. Both Polkadot and Cosmos are interested in moving to as large of a validator set as possible without horrendously slowing down the network. In practical terms, Cosmos launched with 100 validators and Polkadot will launch with 50 - 100 and quickly scale up to around 1000.

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

## Shared Security

Polkadot is designed to share or _pool_ security through the relay chain validator set. This means that any chain which connects to the Polkadot network will not need to set up its own consensus or manage its own economic security, but will benefit from the strong economic security of the relay chain.

This is remarkably different from Cosmos, since Cosmos posits that each chain is sovereign first and must run its own instance of Tendermint consensus with its own consensus algorithm. Cosmos now claims to have a notion of shared security similar to what is offered by Polkadot, but it is not implemented today and seems to be a recent addition.

> Cosmos is a consensus bridge solution and **not** a validation bridge solution. There is no attempt in the Cosmos network to validate the sub-chains, and the hub can track all token transfers. Chains on Cosmos cannot trust each other since each is economically independent. The same Cosmos zone can spend resources on 2 other Cosmos zones and there would be no way for the zones to have information about this double spend unless they get it from the Cosmos hub.

Polkadot has much stronger guarantees than Cosmos in ensuring the economic security over the global state of the relay chain and of the parachains. It also gives greater levels of flexibility to parachain developers to use their own consensus and custom interchain logic.

## Interchain Communication

Cosmos uses the inter-blockchain communication (IBC) standard for the transmission of messages across its zones. The specification for IBS is in progress on [this pull request](https://github.com/cosmos/ics/pull/68) and is described in a series of tweets [here](https://twitter.com/cosmossdk/status/1107729527004762112).

It is difficult to describe the Cosmos IBC protocol with fairness since the specification provided is a work-in-progress and does not necessarily reflect what is implemented in the live Cosmos hub today. As far as we can tell, Cosmos IBC is limited to only the transfer of assets (tokens) across chains which are running Tendermint. They specify it is agnostic to chains as long as it fits the two properties of "fast finality" and "accumulator proofs" but as neither of these things are well-specified it must be assumed it only works with the Tendermint software (in other words, not truly agnostic). 

Previously believed that:
```
Cosmos IBC allows each of its zones to transfer assets to other zones granted they are connected to the _Cosmos Hub_. Notably, the interchain communication in Cosmos is limited **only to transfer of assets.**
```

In comparison, Polkadot allows arbitrary messages to circulate among its parachains. Parachains are able to communicate with each other and validators only need enough data to verify that the interchain messages are being processed correctly. The messages of Polkadot's interchain system can encapsulate assets or more complicated functionality. They are strings of arbitrary bytes. In fact, Polkadot is so flexible in its interchain communication that it even allows parachains to parse the same message in different ways. Although this is a ridiculous thing for parachains to implement, it is allowed. The way that one parachain interprets a message is independent of how any other parachain interprets messages. Of course, the impact a message has on one parachain's state can not effect the state of another parachain (unless it sets off a domino effect of interchain messages by initiating the receiving parachain to send a new message to other parachains).

For more on parachain messaging in Polkadot please see the [interchain page](../interchain.md).

## Programming Language

Cosmos has written the [`cosmos-sdk`](https://github.com/cosmos/cosmos-sdk) in Golang, and has not signaled any desire or plan to support other languages. This is okay if you are a skilled Go developer or are willing to hire Go programmers or learn the Go language, but not very helpful if otherwise. In comparison, Polkadot uses the language-agnostic WebAssembly standard (Wasm) as the compilation target of its runtime and parachain validation functions and runtimes. Many programming languages support Wasm compilation or will support Wasm compilation in the future. A non-exhaustive list of languages that support Wasm compilation are Rust, Go, C++, TypeScript (AssemblyScript), OCaml, Brainfuck, and [more](https://github.com/appcypher/awesome-wasm-langs).  To create a blockchain that will connect to the Polkadot network, it's possible to write your blockchain application in any of these languages. With Cosmos, you have no choice and must write in Go.

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
|Architecture|Hub and zones|Relay chain and parachains|
|Security|Each zone needs own security|Shared security|
|Native token|Atom|Dot|


## Further Reading

https://medium.com/polkadot-network/grandpa-block-finality-in-polkadot-an-introduction-part-1-d08a24a021b5

[iris]: https://www.irisnetwork.cn
[tendermint latest gossip]: https://arxiv.org/pdf/1807.04938.pdf
