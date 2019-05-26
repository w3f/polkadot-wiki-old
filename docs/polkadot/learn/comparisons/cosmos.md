# Polkadot and Cosmos: Two visions for a polychain future

Polkadot is a network of heterogeneous multichains with shared security. Cosmos is a network of chains which individually come to finality and manage their own economic security. Both protocols have visions for the future of blockchains incorporating many chains. Each project tackles this problem in distinct ways, this article will start with a high level summary of both protocols then go into the differences between the designs in detail.

## Polkadot / Cosmos on a high level

Polkadot is a network of multiple heterogeneous chains with shared security. 

Cosmos is focused on being a network in which every chain comes to finality individually and maintains their own validator set. Cosmos creates interoperability by being a network of bridges that connect these separate blockchains together. Polkadot aims to enable multiple chains with different functionalities to all share the same security infrastructure and come to finality together. Most chains that connect to Polkadot will be parachains, meaning that they participate in the validation scheme of the relay chain directly. Some parachains may be of a special class and serve as bridges to external chains such as Bitcoin or Ethereum. 

## Trust model (message passing / security) 

- Validator's stake

The trust assumptions of Cosmos and Polkadot revolve around the notion of the stake that is locked by their respective validator sets. A key distinction is what the validator sets come to consensus on. In Polkadot the validators come to consensus on the shared state of the system while Cosmos, the validator set of each chain only comes to consensus on the transactions of that specific chain. This distinction plays into the message passing systems of the respective chains. For more on that see the [section]() below, for now we will only say that the trust model of Polkadot makes it so that you do not need to trust any other set but the validator set of the relay chain. The first distinction we will break down is that between shared security and sovereign security.

### Shared security vs. sovereign security

The Polkadot architecture is designed so that the security of the network pools to the relay chain via the relay chain validator set. The relay chain can share its security to the connected parachains, once the parachain has bonded DOTs to lease a slot. The benefit is that any chain which connects to Polkadot will not need to set up its own economic security or have to worry at all about consensus. Paying out validators to secure a chain is expensive (usually paid by inflation or block reward), and it is anticipated that the parachain slot lease will be cheaper. Additionally, parachains only need to bond their DOTs and not pay them directly.

In Cosmos, all chains are sovereign and expected to maintain their own economic security. Each chain must run a "fast finality" consensus mechanism (which in practice will often be the Tendermint consensus) if it would like to benefit from connection to the Cosmos Hub. <!-- Cosmos may have a notion of shared security and needs input from their team. -->

> Cosmos is a consensus bridge solution and **not** a validation bridge solution. There is no attempt in the Cosmos network to validate the sub-chains, and the hub can track all token transfers. Chains on Cosmos cannot trust each other since each is economically independent. The same Cosmos zone can spend resources on 2 other Cosmos zones and there would be no way for the zones to have information about this double spend unless they get it from the Cosmos hub.

Polkadot has a strong guarantee over the global state of the relay chain and all connected parachains since they all share the same economic security set. Cosmos does not have the same guarantee over the global state, since each chain maintains their own local security. What happens on one chain has no way of coordinating with what happens on another chain unless through some off-chain communications system.

## Interoperability between chains

- Adding extra stuff is harder for Cosmos (like TCP)
- Single machine (shared state) v. multiple machines (not shared state)
- GRANDPA finalizes state (not a list of transactions)
- Sharded state machine, process state transitions in parallel
- Way easier for Polkadot (more synchronous) The parachains have to act on the message in the next couple block. (Not like TCP) Authentication and ordering needs to be figured out
- Multi-hop doesn't need to happen  (trigger messages) (hash of blocks and hash of outgoing messages, bitfield for recipients)
- Validator ensures the message is included in the parachain block
- Authentication is handled by the relay chain
- common security
- Fisherman (Polkadot) - Cosmos calls it something else

Cosmos proposes the Inter-blockchain communication (IBC) protocol for the transmission of messages across chains. Polkadot uses Interchain Message Passing (ICMP) for communication among the parachains.

### Inter-blockchain Communication (IBC)

The [IBC protocol][ibc architecture] is a method by which various ledgers (blockchains) may communicate with each other. It is an infrastructure level protocol that handles data transport, reliability, and authentication. One of the use cases of IBC is to transfer assets via the Cosmos Hub, but it is not limited only to token transfers. The IBC protocol does not rely on the Cosmos Hub and zone model, and can be used for transmitting messages between chains arranged in a variety of network topologies.

Cosmos describes the IBC protocol as similar to the TCP. TCP is a protocol which handles the transmit of messages between multiple machines, each with their separate states. This is a simple design but makes any data transfer that is more complicated than transfers of assets between chains much more difficult to verify. 

Polkadot instead treats each of the parachains and the relay chain as a single state machine. The validators of the relay chain will verify that the messages sent between parachains were executed and include header data into the relay chain blocks. Messages happen in a much more synchronous fashion in Polkadot then they are able to happen in Cosmos. Because the parachains are all reporting their states to the relay chain validators it becomes easier to do complex data transfers with strong guarantees. This leads to constructions like [SPREE][spree], which gives assurance that code is identical across various parachains and allows sureness that a message sent to a parachain will execute exactly as it was supposed to. Something like SPREE would be difficult to design for Cosmos since each chain is responsible for its own validity.

- Bridges to other chains (similar to IBC).

<!-- Illustration of various network topologies such as Hub and spoke, hierarchical relay chain and parachains, two sovereign chains -->

### Interchain Message Passing (ICMP)

The Polkadot ICMP is designed to work in the trustless environment of the relay chain via validator and collator nodes. ICMP allows for arbitrary data to circulate between parachains and the messages to be guaranteed by the relay chain validator set. 

Messages which pass between parachains are strings of arbitrary bytes. Standards will form, similar to the ERC-20 standard for tokens, for how parachains will interpret certain encoding of messages and this will bring some order to the system. Otherwise, parachains have no constraints on how they will receive, interpret, or execute the messages (just that they will execute it). This allows for ICMP to be transfers of assets or more complex functionality such as smart contract calls. 

For fuller details on ICMP please see the [here][icmp].

### SPREE (Semantics of messages)

- Share code between chains
- sure when send a message it goes to same piece of code on another chain
- Same code, therefore mirrors the functionality (security architecture which guarantees) 
- Limits what the other chain can do with its token
- Private consortium chain
- Can not mint additional tokens

- Would be really difficult for Cosmos to do, since Cosmos zones would need to accounting for themselves

## Scalability (reducing the load)

- Scalability (Fisherman and parachain validation)
- 100% validators (security of the parachain is more than the stake of the validators) / data availability and fishermen makes it more secure.**
- Security will scale for these reasons (side chain like securities)**
- Even if shared security happens it won't be as good as Polkadot.  

Scalability in blockchain is two related concepts, 1) increasing the amount of data that is secured and 2) reducing the data load that must be secured. These things may seem almost contradictory but as we will show, it so happens that by cleverly doing the second one, you can also accomplish the first. 

In Polkadot, the scalability of the network is tied to two distinct concepts of validity and availability. These concepts are weaker for the Cosmos system.

### Validity

In Polkadot validity of the entire state of the network is secured by all of the validators. The way this happens is as follows: validators will be shuffled into groups and assigned to be validating for specific parachains. Every time a parachain submits a proof of a new block (state transition), the group of validators will verify its validity using only a proof and the necessary data. The validators must only commit the hash of the parachain header to the relay chain block. In this way, the parachain execution is compressed first into a proof and given to a subset of validators which then compress it further before writing it onto the relay chain.

Cosmos does not treat validity in the same way. Validity for Tendermint chains require the entire validator sets to sign off on every block, and to perform the complete verification on the transactions in the blocks. The acts of compression which take place during Polkadot's validity checking process do not happen during Tendermint's. For this reason, the scalability of Cosmos, which is built on the Tendermint consensus and its validity checking, is skeptical when compared to Polkadot.

### Availability (data)

Polkadot has additional mechanisms which guarantee the availability of data and gives even stronger security assurances. Namely, these are the use of erasure codes for parachain data availability among the entire validator set and fishermen which are bounty hunters that watch for invalid validator behaviors. 

Validators which are assigned to the parachain are the only ones that must keep the data for that parachain.

Which nodes have to keep what data?

- Mechanisms to report invalidity of data, gives more security than just the set of validators

## Consensus

We will compare Cosmos' BFT consensus algorithm, Tendermint, with that of Polkadot's hybrid consensus GRANDPA/BABE. Both consensus mechanisms use PoS as their validator set selection algorithm, but even that has its differences too. 

## Finality

Tendermint comes to finality on individual blocks. GRANDPA comes to consensus on chains of blocks. Both GRANDPA and Tendermint are Byzantine agreements protocol that require 3 communication rounds to decide a value. However, this is where the similarities end. GRANDPA is a finality gadget that is separated from and intended to be placed on and interact with a block production mechanism. Tendermint is a BFT algorithm, heavily inspired by PBFT, that decides on blocks and therefore has wrapped block production with the finality agreements.

## Liveness

Polkadot has stronger liveness than Cosmos. Under similarity conditions of the network, 

Typically, BFT algorithms agree on using 2F + 1 number, where `F` is the number of faulty nodes to determine liveness. This means that when more than 1/3 of the validator set becomes Byzantine (that means go offline, equivocate, or otherwise stop responding like expected), the algorithm safely halts until the validator sets becomes responsive again or get kicked and so that the 2/3 + 1 supermajority is restored. 

The crucial difference is that Tendermint chains will completely stop producing blocks whatsoever and no new progress could be made. However, Polkadot will continue producing blocks and 

## Validator set selection and weights

Polkadot uses an nominated proof-of-stake mechanism (NPoS) while Tendermint uses (a more standard proof-of-stake algorithm?). Additionally, Polkadot weights its validators equally and uses Phragmen's method to distribute the stake as equally as possible among the nominated validators.

Tendermint uses stake-weighted round robin.

## Finality (Old)

Polkadot consensus is composed of the GRANDPA finality gadget, BABE block production, and Nominated Proof-of-Stake (NPoS) validator selection as its consensus framework.

Cosmos uses the [Tendermint][tendermint latest gossip] consensus algorithm with PoS validator selection. The Tendermint consensus algorithm is based on the practical Byzantine-Fault-Tolerant (PBFT) consensus with modifications to make it better suited to high-frequency gossip networks. However, an issue with Tendermint is that it performs a Byzantine agreements protocol on each block, while Polkadot's GRANDPA finality gadget performs a similar agreement on _chains of blocks_. 

Byzantine agreements take 3 communication rounds to decide a value. This has an impact on the scalability of the transaction throughput. To simplify the problem we'll assume that the time required to come to a Byzantine agreement is 6 seconds for both Tendermint and GRANDPA. This means that Tendermint only produces a single block every six seconds. However, due to the fact that Polkadot separated the block production mechanism BABE out from the finality gadget, when GRANDPA comes to finalization in a similar time duration, it would finalize multiple blocks since it has come to agreement about the chain rather than the individual block.

Both the Polkadot relay chain and Cosmos hub will achieve finality under favorable network conditions with the assumption that > 2/3 of the validator set is available and honest. Once > 2/3 of the validator set has signed off on a block (or, in the case of GRANDPA a chain of blocks) those blocks are considered final and unable to be reverted. In comparison, Nakamoto consensus as used in most PoW blockchains can only guarantee probable finality at best.

The time-to-finality of both GRANDPA and Tendermint are limited by the bandwidth limit and latency on the network. As the number of validators increases, so will the number of messages that must get sent between them thereby slowing down the finality mechanism. Both Polkadot and Cosmos are interested in moving to as large of a validator set as possible without horrendously slowing down the network. In practical terms, Cosmos launched with 100 validators and Polkadot will launch with 50 - 100 and quickly scale up to around 1000.

One key difference between Tendermint and the consensus mechanism of Polkadot is how each protocol treats the act of block production. Block production in Polkadot is done through the BABE algorithm. BABE uses a unique random number to determine the block producer for each block. BABE has different security assumptions that the GRANPA finality gadget, so that even if >1/3 validators are Byzantine at one time, block production would not halt like it does in Tendermint. GRANDPA may temporarily cease finalizing blocks but 

GRANDPA comes to consensus on chains and not on individual blocks. This means that 

- Who comes to consensus and what do they come to consensus on?


<div class="grandpa-img">
    <a href="../../../../img/GRANDPA/chain-selection.png" target="_blank">
        <img src="../../../../img/GRANDPA/chain-selection.png" alt="block production"/>
    </a>
    <p>Visual 1.1</p>
</div>

For a visualization of what we mean by GRANDPA comes to finality on "chains" rather than blocks, consider `Visual 1.1`.

<!-- right now this links to Rob's article but later will link to the wiki consensus page -->
_For more on Polkadot consensus please see [here](https://medium.com/polkadot-network/grandpa-block-finality-in-polkadot-an-introduction-part-1-d08a24a021b5)_

## Good things about Cosmos

- Finality for bridge communication between chains 
- Realized they needed a standard
- Tendermint is really simple BFT algorithm
- Tendermint is simpler and easier to implement, Polkadot is more ambitious and solves the problems we want to solve
- Subset of validators will validate on other chains and may get slashed (details)

## Architecture

- Launching with parachains


## Terminology

- Don't hit them hard for implementation
- Compare designs: their vague design is not as good as Polkadot's more refined design.
- Concrete plans for one thing, vague plans for a general thing. Polkadot does all these things easily (IBC v. ICMP)

### Polkadot: Relay chain and parachains

The Polkadot network is composed of the relay chain and a number of (between 1 - 200+) connected parachains. Some of these parachains will  act as bridges to already established networks such as Bitcoin, Ethereum, or Tezos. All of the parachains that are connected to the relay chain will share in the security of the relay chain validator set. All state transitions of the parachains will be recorded on the relay chain and finalized using GRANDPA, the relay chain finality gadget. Eventually Polkadot will scale by becoming a relay chain of relay chains, by utilizing its parachain slots as kinds of relay chains which can connect to parachains of its own.

### Cosmos: Hub and zones

The Cosmos network consists of the Cosmos hub which acts as the central point of routing messages across the connected zones. Cosmos terminology uses _zone_ to mean a chain that is connected to the hub. The hubs and zones are all Tendermint consensus PoS chains with the quality of fast finality. Cosmos does not require that zones be connected to the Cosmos hub, and there are projects such as [Iris network][iris] which have built an alternative hub. This is an important distinction from Polkadot, where the relay chain will be the central pool of security for all the connected parachains.


<!-- ### Similarities and differences?

Both protocols are designed for passing data between blockchains. Cosmos' IBC makes the constraint that the chains must have finality and conform to a specific interface. In comparison, Polkadot imposes that the chains must be connected as parachains.

The major distinction comes when considering the trust assumptions of both methods. In Polkadot, the data going between chains is trustless because it will be secured by the relay chain validator set (which is where all of the security of the system pools). In Cosmos IBC, the security capital is split among the different chains. What this means is that to do something simple such as transfer an asset from one chain to another requires twice the amount of capital lock-up in Cosmos for the same security as it would in Polkadot. We draw this conclusion from a fairly straightforward explanation:

In order to have X worth of tokens locked up for security to send messages between parachains on Polkadot only requires X, while in Cosmos it would multiply by the number of chains which are being interoperated with. X worth of security to pass a message `m` from chain `A` to chain `B` on Cosmos would require X worth of tokens locked on both `A` and `B`. Therefore, `2X` worth of tokens would be locked to give the same security that only `X` locked on Polkadot would give. This means that if the same value of tokens are locked up on both networks in total, Polkadot would have at least twice the security.

In the future both standards will work in harmony, allowing all blockchains to communicate with each other. The relay chain of Polkadot would be able to transmit messages to the Cosmos Hub and back. -->

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
