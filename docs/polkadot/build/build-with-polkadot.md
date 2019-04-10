# How to start building on Polkadot

!!! attention
    _Polkadot and Substrate are both under active development and things are changing rapidly. It should calm down in a couple weeks with the [1.0 release](https://github.com/paritytech/substrate/milestone/9) of Substrate but be aware that the APIs are still evolving._

Polkadot is described in the [whitepaper](https://github.com/w3f/polkadot-white-paper/raw/master/PolkaDotPaper.pdf) as a fully extensible
and scalable blockchain development, deployment, and interaction test bed.
Builders will have the ability to use this exciting new technology
as the infrastructure for their own applications.

This guide will walk you through the [current state of Polkadot](#where-are-we-now) development, explain the [difference between a
parachain and a smart contract](#what-is-the-difference-between-a-parachain-and-smart-contract), walk through
the necessary steps to take to [build a parachain](#so-you-want-to-build-a-parachain) from [starting a new project](#starting-a-new-project) to [including your chain in Polkadot](#how-to-include-your-parachain-in-polkadot); or to [build a smart contract](#so-you-want-to-build-a-smart-contract) from picking a platform to [paying for the deployment](#paying-for-your-smart-contract). 

## Where are we now?

Polkadot has achieved the PoC 3 milestone and has been successfully running the
Alexander testnet for three months. Progress is steadily being made toward the next
PoC-4 release which will include interchain messaging. Development is on track for a 
mainnet launch by the end of the year.

Meanwhile, Substrate which is the runtime module library on which Polkadot is being
built, is closely approaching its first stable release. Substrate allows builders
to re-use many of the pieces that are being used to create Polkadot and compose
them into their own chain. It is also easily extensible by writing custom _runtime
modules_ which dictate the runtime logic of the chain.

If you are a developer, builder, entrepreneur, or otherwise a visionary
considering Polkadot as the ecosystem for your next project, this guide
will help you understand your options for development and decide what
stack is right for you and your project. It will show you the resources
available which you can use to begin planning and executing on your idea today. 

## What is the difference between a parachain and smart contract?

Before you can begin any work on your idea at all, it is important
that you understand the trade-offs between the two development options
you have for building on Polkadot: parachains or smart contracts.

Parachains are the individual chains which will connect into the Polkadot
network to benefit from the shared security of the Polkadot relay chain
validator set. Polkadot itself is being built with the same tools available
to start creating parachains. Parachains allow for flexibility and less
constraints on what is possible in the chain logic but come with some 
additional overhead which makes it so that they aren't always the preferable
option when compared to smart contracts.

Smart contracts are executable programs that exist on a specific chain. They
often have nice interoperability compatible with other applications on the
same chain, but can not really interact with something on another chain. They
come with less development overhead than building a full parachain but imply
more constraints on what is allowed by the application logic. They are good
mediums to try initial prototyping with, but eventually may outgrow themselves
due to scalability constraints or complexity overload.

Broadly speaking, if you want to have control over the protocol mechanics of
your network then a parachain will be the good option for you. 

Building a parachain means that you can design the economics of the monetary system 
from the ground up. You can implement a custom fee structure into your transactions
or a full-on treasury system which could act as a native DAO and uses portions
of the block reward to allow stakeholders to allocate funds. 

It opens up the flexibility to construct complex logic that may be too expensive
to run as a smart contract. If there is a specific feature your chain will use
as a cornerstone, you can even implement an optimized runtime for it to make it
cheaper and faster.

If there is a specific use case you are thinking of such as implementing a 
completely new type of virtual machine, you will be able to do this by building
a parachain.

Instead if you want a lower barrier to entry and more rapid iteration cycles
for quick prototyping and deployment, you will be more attracted to the smart
contract medium. 

Smart contracts are usually simpler than parachain logic and therefore
take less time to develop. They will have strong tooling like IDEs that
allow you to get your idea out into the world that much quicker.

As mentioned before, they will have access to the environment of the chain
for which they are deployed. If your application requires interaction with
a system that is already deployed on a chain as a smart contract, it will
in most cases make the most sense to also write your application as a smart
contract on the same chain.

An example of the composable of smart contracts is evident in the recent phenomenon
of DeFi (decentralized finance) applications. Projects like [Maker](https://makerdao.com)
opened the way for further application to be constructed on top of them
such as decentralized hedge funds and loan management systems.

There will be more overhead to creating a parachain that simply
will not exist for deploying your application as smart contracts.
These include running collator nodes for your parachain, or incentivizing them
in some way, and staking DOTs or otherwise convincing the Polkadot governance
mechanism to include your chain on the parachain registry.

Unless you're absolutely sure that your project needs to be a parachain
or if you're just looking forward to experimenting with new tech, it
is advisable you start by first creating an MVP of your decentralized
application as a smart contract.

Here is a quick comparison chart to help you digest the information:

| Parachain | Smart Contract |
|-----------|----------------|
| more complex to develop (-) | easy to develop (+) |
| requires collator node to deploy (-) | easy to deploy (+)  |
| interaction between parachains (+) | interaction between applications (+) |
| requires network maintenance (-) | easier to maintain (+) |
| possible to implement complex network logic and advanced crypto (+) | harder to implement complex logic or crypto (-) |
| is its own network (+) | exists on a network (-) |

This guide now splits into two depending on the decision that you have made to 
develop your project as a parachain or as a smart contract.

- [I want to build a parachain](#so-you-want-to-build-a-parachain)
- [I want to build a smart contract](#so-you-want-to-build-a-smart-contract)

## So you want to build a parachain

Once you've determined that creating a parachain is the right approach for your
project, the next step is to decide what tools and framework you will use. Right
now the choice is easy since you only have one option: Parity's Substrate.

> Actually, its not strictly true that Substrate is your only choice since you could write all your chain logic
from scratch as long as it compiled to Wasm and has the correct interaction interface for Polkadot.
But this approach will not
benefit from the modular re-usability and developer friendliness that frameworks like Substrate enable.

### Substrate

Substrate is a framework for blockchain innovators. It provides the basic building
blocks that are needed to construct a chain and provides a pluggable and modular
library of runtime modules from which to compose your chain logic. The motivation
of building it was to bring the development time of a new blockchain down from years
to weeks and days or even hours for simplistic chains.

The most definitive resource regarding Substrate development is the Parity maintained
[Substrate Development Hub](https://docs.substrate.dev) which covers material from
beginning your first parachain from a template to building Dappchains like Cryptokitties.

It is recommended that you poke around in there for a while until you become familiar
with the patterns for how a Substrate chain will be built. Once you have a solid 
understanding you can run through the [Token Curated Registry](https://docs.substrate.dev/docs/building-a-token-curated-registry-dappchain-using-substrate)
or the [Substratekitties](https://shawntabrizi.github.io/substrate-collectables-workshop/) tutorials.

#### Starting a new project

You will likely want to use the convenience script provided by the Substrate developers
to start a new project template.

First download the script by running this command:

```bash
curl https://getsubstrate.io -sSf | bash
```

Then create your project by running:

```bash
substrate-node-new <myProject> <myName>
```

!!! attention
    _While Substrate is still pre-1.0 release it is recommended to use instead this [stable package](https://github.com/shawntabrizi/substrate-package) containing the node and ui instead of the script above._

### Setting up your chain

After you have created your chain logic using a framework like Substrate, you will
compile it into a Wasm blob which contains your state transition function. This is
the core of your blockchain and is what the validators on the Polkadot relay chain
will validate all state transitions against. But before you're able to submit your
chain into the Polkadot network there is still a couple things you
need to take care of.

The two big things you will need to resolve when you are finished developing your chain
logic are 1) you need to set up at least one collator node and 2) you will need to ensure
your availability on the relay chain by acquiring a spot on the parachain registry.

The first one needs to be done because validators on the relay chain need some way
to become aware of new state transitions coming from your chain. This functionality is
handled by the specialized type of node known as the [collator](../learn/terms-and-definitions.md#collator).
Basically collators are the nodes which will handle state transitions for your chain
and handing those state transitions with proofs to validators to validate.

Your chain could have one validator or it could have many. They can be ran as public
services by the developers or there could be an incentive structure baked into the parachain
to encourage the community to operate them.

Right now it's still pretty early on in the development of definitive collator
nodes which can be used for interaction with Polkadot.
There is an early demo that is available in the Polkadot repository, this can be ran by
following an early demo as shown in this [video tutorial](https://www.youtube.com/watch?v=pDqkzvA4C0E).
As development continues there will be libraries that will make setting up a
Polkadot-compatible parachain a no-brainer. One of these libraries is called Cumulus.

#### Cumulus

[Cumulus](https://github.com/paritytech/cumulus) is still in
development and is _not_ ready to use yet. It's intended goal is to be
an extension to the Substrate library that will make any Substrate
runtime compatible with Polkadot.

It will handle some of the overhead of any parachain that needs
to be compatible with Polkadot. These include:

 - handling interchain messaging between parachains
 - out-of-the-box collator node
 - follows the relay chain with an embedded light client
 - compatible with Polkadot specific intricacies of block authorship

Getting started with Cumulus once it's ready will be as easy as:

 - Minimal modification to the Substrate chain already written
 - Cumulus will port it over with little effort

For the latest on Cumulus see a recent talk from Rob Habermeier below.

[![img](http://img.youtube.com/vi/thgtXq5YMOo/0.jpg)](https://www.youtube.com/watch?v=thgtXq5YMOo)

#### Ensuring a fair validator choice

In Polkadot validators are automatically selected to validate for each parachain
using randomness from the relay chain. Each era on the relay chain these validators will be rotated
to ensure that there is a fair validator choice and that no single validator continues
to validate for a specific chain. As a parachain developer or operator you will get
this security feature included once you've made your chain compatible with Polkadot
and acquired a spot on the parachain registry.

### How to include your parachain in polkadot

The second very important step you will need to do once you're ready to integrate
your chain into Polkadot is to secure a spot in the parachain registry.

In the whitepaper it states that parachains will only be added to the
network through a process of full referendum voting by the governance
mechanism. Furthermore, the chain would exist until it is again voted
out by a similar mechanism in which a referendum would grant a grace
period for users to migrate off chains.

It is still believed that the governance mechanism will integrate some
especially useful and value-adding chains this way for the benefit of
the Polkadot network as a whole. But this will not be the only way for 
you to acquire a spot for your parachain. If you do not want to persuade
the governance mechanism that your chain is useful then there is another
way.

The current thinking is that there will be an auction mechanism
that will distribute the spots in the parachain registry. This auction 
will likely be a [Vickrey](https://en.wikipedia.org/wiki/Vickrey_auction) auction,
also know as a second-price auction. The auction would be used to allocate registry entries
to parachain projects for differing but constant time durations (eg. 6 months, 12 months,
24 months). In order to participate in the auction participants need to stake DOTs. The
participant which stakes enough DOTs to be the highest bidder
will be required to lock up the number of DOTs of the second-highest bid
for the duration of the registry inclusion.

Builders can start thinking now about how to fund enough DOTs to ensure they can
secure an entry on the parachain registry. Some ideas include a crowdfunding
campaign in which participates will stake their own DOTs individually for a 
single chain, a crowdsale for which participants will purchase some tokens
of a chain so that chain can have enough DOTs to stake its own entry, or through
private fundraising means.

#### What happens when the time runs out?

Once you secure your entry into the parachain registry you are guaranteed that
spot until either 1) the duration of the time attached to that entry has elapsed
or 2) the governance mechanism votes to remove it.

Option 2 will probably only happen in dire circumstances and will not be something
that commonly takes place. Option 1 will be the way that most chains will expire
off the Polkadot network. 

When your chain is approaching the end of its time duration some things that could
happen include: a referendum could be
held by the stakeholders of the chain to extend the lifetime by continuing to stake DOTs (if your chain implements
on-chain governance), users can safely migrate off the platform to an
alternative, a campaign could be held to fund the DOTs to acquire a different spot
on the registry.

In most cases it will likely be fairly straightforward to "renew" your
entry on the parachain registry by continuing to stake DOTs.

### Benefits of being a parachain

The benefit of being a parachain on Polkadot is that your chain will be secured
with the same security as the entire Polkadot network without you needing to 
maintain your own consensus. On top of this, your chain will be able to interact
with all other Polkadot parachains through the interchain communication system.

The tools and monitoring systems being built for Polkadot or different parachains
will be easily portable or re-usable in the future by new parachains. Without Polkadot,
sovereign chains would need to have compatible wallets that supported them.
With Polkadot, much of the basic tooling like wallets and block explorers
will already be available and configurable to your parachain.

Being a Polkadot parachain will allow you and your community
to experiment with the latest innovations in blockchain tech. Whether
you are interested in governance, scalability, privacy, or custom VMs,
Polkadot is general enough that it will support your innovations at launch
and into the future.

_You've reached the end of the parachain section, you can either read about smart contracts
or go straight to the [conclusion](#conclusion)._

## So you want to build a smart contract

The Polkadot relay chain itself will not support smart contracts but
since Polkadot is a network of many heterogeneous blockchains, there
will be parachains that do.

Already Parity Technologies has laid much of the groundwork for an
out-of-the-box solution for parachains that want to include smart contract
functionality. The Substrate [contract](https://github.com/paritytech/substrate/tree/master/srml/contract)
module in the core SRML will support smart contracts that are compiled
to Wasm. 

In order to develop a smart contract that compiles to Wasm, an
appropriate language is also needed. For this, Parity has been working
on a domain specific language called [pDSL](#pdsl-paritys-domain-specific-language).

One project that has announced intent to become a Polkadot
parachain with support for smart contracts is [Edgeware](#edgeware). As
the ecosystem matures, there is a high probability that more chains will
come forward as smart contract enabled parachains.

Polkadot will also be compatible with preexisting smart contract platforms
such as Ethereum and Tezos through bridges. This means that even work spent
developing on these platforms today may be applicable to running on Polkadot
in the future.

### Edgeware

Edgeware is a planned parachain for Polkadot which will
allow for smart contracts. Along with other interesting innovations in governance
and token distribution, it will likely be the first parachain that will connect
to the Polkadot mainnet with smart contracts enabled. You can stay up to date with
the project on their [website](https://edgewa.re).

### pDSL (Parity's Domain Specific Language)

The [pDSL](https://github.com/Robbepop/pdsl) is intended to be a new domain specific
language for writing smart contracts in Rust that will compile down to Wasm code.
As stated in the README, it is still in an experimental phase and missing a lot of the
planned features but it is possible to start writing smart contracts with it today.

For the interested developers, they can get started writing smart contracts using pDSL
by studying the [examples](https://github.com/Robbepop/pdsl/tree/master/examples) which have 
already been written. These can be used as guideposts to writing more complex logic which
will be deployable on smart contract parachains. However, since the ecosystem is still
so early it's probably not a good idea to try to write production code with it yet.

## Deploying your app as a smart contract

A smart contract is in essence some code that exists at an address on chain and
can be executed. Once the code is developed it needs some way to actually get
onto the chain and be available to users. Deploying your smart contract on chain
will vary depending on which specific platform you are targeting, but in
general it will involve sending a special transaction which will `create` your
smart contract on the ledger. Usually this transaction will require a fee to cover
the computation costs of any constructor logic and for storage that it consumes.

## Paying for your smart contract

Different platforms will have different ways for paying for your
smart contract deployment and maintenance.

Some ways you different platforms might implement paying for smart contracts:

 - a transaction fee associated with the deploy transaction
 - a subscription model in which you pay to subscribe to a chain
 - access token model in which you must hold enough tokens to use a chain (cp. EOS)
 - storage rent
 - free trial. Some chains may want to attract new developers with promotions

In general most smart contract platforms implement the notion of `gas` which
represents the computation required to run your smart contract logic across
the network. Gas is usually paid for by paying the corresponding `gas price`
that is specified in the transaction. 

There are a couple things you will want to keep in mind while developing your
application to ensure that the gas cost of it stays within reasonable bounds
and won't become too expensive. These are storage of your contract and the 
complexity of the logic. 

Storage is expensive on chain since it increases the data required for nodes
to perform a full sync. When developing smart contracts try to keep the amount
of data sent to the chain as low as possible. To do this you may want to consider
decentralized storage solutions such as [IPFS](https://ipfs.io) or [Storj](https://storj.io/)
which can often work parallel to your smart contract, and allow you to keep only
a pointer to the storage as a hash on chain. 

Likewise it is advisable to keep the complexity of the on-chain logic as low
as possible in order to minimize the amount of gas fees. Often this means that
any non-critical calculations should be done before sending data to the chain.

### It's still early

Smart contracts on Polkadot is still very early, which explains why this section
is composed of pointers to in progress projects and non-specific information.
Keep up to date with the projects above and watch out for the first testnets to be released.
If you're feeling brave you can try to work with the tools such as pDSL but be 
aware that much of the technology is still prior to stable release so will probably
change as we continue progress toward the future mainnet Polkadot release.

## Conclusion

Hopefully this guide has helped you to make the right decision for whether
your new project will be a parachain or a smart contract, and shown you the
essential resources for which you can use to start developing on Polkadot today.
Even though the tooling is still maturing, there is a benefit for arriving to
the scene early: you have the ability to innovate by creating something
truly new. 

If you would like to share your ideas for a parachain or a smart contract
feel free to talk to us in the [Polkadot Watercooler](https://riot.im/app/#/room/#polkadot-watercooler:matrix.org) and if you have questions
regarding development you can try asking in the [Polkadot Beginners Lounge](https://riot.im/app/#/room/#polkadotnoobs:matrix.org).
Keep up to date by following the appropriate [social channels](https://wiki.polkadot.network/en/latest/community/) and good luck
building your vision into reality on Polkadot!
