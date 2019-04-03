# Polkadot compared to {Cosmos, Ethereum, Tezos}

Polkadot is a blockchain technology but makes some innovations that sets it apart from other popular chains.

## Ethereum

[Ethereum](https://ethereum.org) is a smart contract platform blockchain which allows for general computation to be deployed on-chain and operated across the p2p network.

### Ethereum 1.x

Ethereum 1.x refers to the current Ethereum release (at the time of writing at the Constantinople hard fork) and the immediately planned future upgrades.

The difference between the current Ethereum and Polkadot is quite large. Ethereum is a single chain which allows developers to extend its functionality through the deployment of blobs of code onto the chain (called smart contracts). Polkadot, as described in the whitepaper, is a fully extensible and scalable blockchain development, deployment and interaction test bed. It aims to be able to assimilate new blockchains, high-frequency chains, and even consortium chains with ease.

In practical terms, this means that the layer of abstraction between these two projects is remarkably different for developers. While in Ethereum developers code to deploy in a permissionless environment where smart contracts can interoperate seamlessly, this is not the case in Polkadot. Rather, Polkadot development currently takes the form as Substrate runtime modules, which are simply WASM blobs which dictate the entire logic for the chain State Transition Function (STF).

### Ethereum 2.0

Ethereum 2.0 refers to the planned Ethereum sharded chain which is currently being implemented and exists in the [spec](https://github.com/ethereum/eth2.0-specs/tree/0.4.0).

On the surface, it may appear that the Eth2.0 spec for the beacon chain and shard chains is comparable to the Polkadot relay chain and parachains. However, a key distinction is that Eth2.0 shards are _homogenous_ while Polkadot parachains are _heterogenous_. This means that in Polkadot there is much more flexibility in the logic of the chain which can share the security with the Polkadot network, while Eth2.0 shards all are strictly the same logic. 

The Eth2.0 beacon chain uses LMD (Latest Message-Driven) GHOST as its fork-choice rule while Polkadot relay chain uses BABE for block production and GRANDPA as its finality gadget.  

## Tezos

[Tezos](https://tezos.com) is a blockchain that can evolve by upgrading itself. Two interesting feature to compare Polkadot to is its governance mechanism and smart contracts.

Tezos is described as __self-amending__ because it can enact an upgrade to the chain without having to fork. Likewise, Polkadot allows for any parachain to integrate this functionality and the relay chain itself is able to be upgraded through an on-chain process. Since Polkadot state transition functions are just WASM blobs to perform an upgrade (after it has been approved by the governance system) simply means switching out the code blob for which validators are validating against. The [upgrade-key](https://github.com/paritytech/substrate/blob/master/srml/upgrade-key/src/lib.rs) module in the Substrate library makes this easy for any Substrate-built chain to implement.

Another feature of Tezos is its smart contract language [Michelson](https://www.michelson-lang.com/) which facilitates formal verification of the written logic. Formal verification is a tool which can help to prevent bugs that could lead to unwanted state transitions. Although Polkadot is currently written in the Rust language, which lacks the same level of formal verification tools as Tezos' implementation language OCaml, Rust is considered a safer language than C or C++ for systems programming. Furthermore, Polkadot makes no restrictions to parachains written in more friendly languages for formal verification-- the only requirement is that the logic must compile to WASM. It is expected that some chains will emerge written with formal verification as a first class property. Additionally, the tooling ecosystem around both Rust and WASM are both maturing and formal verification tools may at some point become more widely available for these languages.

## Cosmos

[Cosmos](https://cosmos.network/resources/whitepaper), being a "network of distributed ledgers", is often thought to be comparable to Polkadot. Although the goal of Cosmos is similar to Polkadot, to solve problems of blockchain scalability and interoperability, it can be understood that Polkadot is more robust in its ability to connect heterogeneous chains.

In Cosmos, a chain is referred to as a _zone_ and each uses an individual instance of the [Tendermint]() consensus algorithm. Interchain communication is handled via a master _hub_ chain and is limited to transfers of currencies rather than communicate arbitrary information across chains. The roughly synonymous terms to compare Cosmos to Polkadot is that a _zone_ maps to _parachain_ and _hub_ maps to _relay chain_ BUT these are only loose comparisons and do not have the exact same properties or functions.

One major difference is that there is no notion of shared security in Cosmos. Each Cosmos zone is expected to have their own validator sets running an individual consensus. 

Cosmos is a consensus bridge solution and **not** a validation bridge solution. There is no attempt in the Cosmos network to validate the sub-chains, and the hub can track all token transfers. Chains on Cosmos cannot trust each other since each is economically independent. The same Cosmos zone can spend resources on 2 other Cosmos zones and there would be no way for the zones to have information about this double spend unless they get it from the Cosmos hub.

Polkadot has much stronger guarantees than Cosmos in ensuring the economic security over the global state of the relay chain and of the parachains. It also gives greater levels of flexibility to parachain developers to use their own consensus and custom interchain logic.

The governance of both projects is remarkably distinct as well. In Cosmos, the source of truth lies solely with the Cosmos hub and the validators of that chain. While Polkadot's governance system is agreed upon by stake-weighted referendum and includes mechanisms to represent passive stakeholders such as the council.

Here is a quick table denoting key differences:

|   |Cosmos|Polkadot|
|---|---|---|
|Consensus|Tendermint (PBFT)|GRANDPA|
|Governance|Validator/Delegator Vote|Referendum and Council representing stakeholders|
|Models|Hub and Zones|Relay chain and parachains|
|Security|Each zone has its own security|Shared security across parachains|
|Native token|Atom|Dot|
