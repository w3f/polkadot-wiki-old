# How does Polkadot compare to Cosmos?

There is a lot of interest surrounding the comparison of Polkadot to Cosmos. Understandably so, since Cosmos as a blockchain interoperability protocol shares some of the same goals as Polkadot. However, there are a few key differences between the two protocols which should be understood before comparing them further.

## Hubs and Zones vs. Relay chain and parachains

In Cosmos, a chain is referred to as a _zone_ and each uses an individual instance of the Tendermint consensus algorithm. Interchain communication is handled via a master _hub_ chain and is limited to transfers of currencies rather than the communication of arbitrary information across chains (like Polkadot allows). The roughly synonymous terms to compare Cosmos to Polkadot is that a _zone_ maps to _parachain_ and _hub_ maps to _relay chain_ BUT these are only loose comparisons and do not have the exact same properties or functions. One thing to point out is that Polkadot assumes that there will be a single canonical relay chain, with the potential for parachains to be relay chains themselves, but overall connecting to the top level Polkadot relay chain. Cosmos, however allows open deployment of hubs and zones and makes no such requirement that they must be connected at all. 

## Consensus

Cosmos uses the [Tendermint](https://tendermint.com/docs/introduction/what-is-tendermint.html#what-is-tendermint) consensus algorithm which is based on the practical Byzantine-Fault-Tolerant (PBFT) algorithm. For a general overview of PBFT, please see the overview [here]
(https://crushcrypto.com/what-is-practical-byzantine-fault-tolerance/). In general, it is a family of consensus protocols that can handle no more than 1/3 byzantine nodes (malicious or offline nodes). 

Polkadot uses a combination of block production mechanism with a finality gadget, respectively termed BABE and GRANDPA. BABE is similar to Ouroboros Praos and GRANDPA is a finality gadget based on GHOST in the same vein as Casper FFG. It is **not** PBFT.

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

## Pooled Security

Polkadot is designed to _pool_ security through the relay chain validator set. This means that any chain which connects to the Polkadot network will not need to set up its own consensus or manage its own economic security, but will benefit from the strong economic security of the relay chain.

This is remarkably different from Cosmos, since Cosmos posits that each chain is sovereign first and must run its own instance of Tendermint consensus with its own consensus algorithm. Cosmos now claims to have a notion of shared security similar to what is offered by Polkadot, but it is not implemented today and seems to be a recent addition.

> Cosmos is a consensus bridge solution and **not** a validation bridge solution. There is no attempt in the Cosmos network to validate the sub-chains, and the hub can track all token transfers. Chains on Cosmos cannot trust each other since each is economically independent. The same Cosmos zone can spend resources on 2 other Cosmos zones and there would be no way for the zones to have information about this double spend unless they get it from the Cosmos hub.

Polkadot has much stronger guarantees than Cosmos in ensuring the economic security over the global state of the relay chain and of the parachains. It also gives greater levels of flexibility to parachain developers to use their own consensus and custom interchain logic.

## Interchain Communication

Cosmos allows each of its zones to transfer assets to other zones granted they are connected to the _Cosmos Hub_. Notably, the interchain communication in Cosmos is limited **only to transfer of assets.**

Polkadot allows arbitrary messages to circulate among its parachains. Parachains will communicate with each other with the validators only having enough knowledge required of the messages to verify that the interchain messages are being processed correctly. The messages of Polkadot's interchain system can encapsulate assets or more complicated functionality since at the core they are just a string of bytes. In fact, Polkadot is so flexible in its interchain communication that it even allows parachains to parse the same message in different ways, this is a ridiculous thing to implement but the chain logic would allow it and it holds no bearing on the state of any other parachain besides the one which does the interpreting.

For more on interchain messaging in Polkadot please see the dedicated [wiki page](./interchain.md).

## Programming Language

Cosmos has written the [`cosmos-sdk`](https://github.com/cosmos/cosmos-sdk) in Golang, and has not signaled any desire or plan to support other languages. This is okay if you are a skilled Go developer or are willing to hire Go programmers or learn the Go language, but not very helpful if otherwise. In comparison, Polkadot uses the language-agnostic WebAssembly standard (Wasm) as the compilation target of its runtime and parachain validation functions and runtimes. Many programming languages support Wasm compilation or will support Wasm compilation in the future. A non-exhaustive list of languages that support Wasm compilation are Rust, Go, C++, TypeScript (AssemblyScript), OCaml, Brainfuck, and [more](https://github.com/appcypher/awesome-wasm-langs).  To create a blockchain that will connect to the Polkadot network, it's possible to write your blockchain application in any of these languages. With Cosmos, you have no choice and must write in Go.

## FAQ

Follows are responses to questions which are often brought up in the comparison of Cosmos and Polkadot.

### Do parachains need to connect to the relay chain or can they be sovereign chains like in Cosmos?

The simple answer is _yes_, if a chain would like to benefit from the pooled security and interchain communication enabled by Polkadot then it must become a parachain to the Polkadot relay chain. However, a chain built using Substrate does not need to connect to Polkadot if it does not want to share in these benefits and it can implement its own consensus and security just as each Cosmos zone does. The difference between them is that in Cosmos, there is no choice, a chain must have its own security and validator set running Tendermint consensus. While Polkadot/Substrate allows a chain to be sovereign with its own security by implementing one of the provided consensus algorithms or by developing a custom one. If the chain chooses it can make its consensus compatible with Polkadot and become a parachain.

### Is GRANDPA / BABE similar to PBFT?

No. This is a misunderstanding. GRANDPA, the finality gadget, and BABE, the block production mechanism, are novel developments in consensus and they are very far away from PBFT. GRANDPA is derived from GHOST similar to Ethereum's Casper and BABE is a block production mechanism similar to Ouroboros Praos. Neither of these technologies are based on PBFT. (This is not the case for Cosmos however, since Tendermint is based on a modified PBFT).

### Is Polkadot only going to work with POS chains? How is it trust-less in comparison to Cosmos?

Polkadot is primarily designed to be a very efficient and minimal heterogeneous multi-chain platform. Bridges to preexisting or "foreign" chains are one potential use-case for it. Such bridges can be to either PoW or PoS chains and in terms of the Polkadot protocol it makes little difference (as it does in some protocols such as Bitcoin's Sidechains that works specifically with SHA256 PoW and Cosmos's Zones that works only with Tendermint PoS). Polkadot's parachain abstraction is neither PoS nor PoW specific. If you want to call it anything, it's "PoV" or Proof of Validity. As such Polkadot is entirely agnostic. As long as you can succinctly demonstrate that a block is "valid" under your chain's technology (basically this means being able to build a light client), then you can probably plug it into Polkadot one way or another.

## Quick Facts

|   |Cosmos|Polkadot|
|---|---|---|
|Consensus|Tendermint (BFT)|GRANDPA/BABE|
|Governance|Validator/Delegator Vote|Referendum and Council representing stakeholders|
|Models|Hub and Zones|Relay chain and parachains|
|Security|Each zone has its own security|Pooled security|
|Native token|Atom|Dot|


## Further Reading

https://medium.com/polkadot-network/grandpa-block-finality-in-polkadot-an-introduction-part-1-d08a24a021b5
