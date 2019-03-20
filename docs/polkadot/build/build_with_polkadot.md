# How Can I Build with Polkadot?

!!! attention
    _Polkadot and Substrate are both under active development and things are changing rapidly. This should calm down in a couple weeks with the release of 1.0 of Substrate but be aware that the APIs are still evolving._

## Where are we now?

Polkadot is currently on the PoC 3 release code named Alexander, which went live on
December 21, 2018. Substrate, the runtime module library on which Polkadot is being
built on and enables developers to re-use many of the pieces to create their own 
blockchain is nearing completion of the first 1.0 stable release.

If you are a developer, builder, entreprenuer, or otherwise a visionary thinking
about whether Polkadot is where you should start your next project, this guide is
for you. Although the ecosystem is still evolving and Polkadot may be almost a year
out from a mainnet launch, there is enough information and tools to begin planning and
executing on your idea today.

## What is the difference between a parachain and smart contract?

The first question you may to want to ask yourself is whether you should build
your project as a smart contract or as a parachain. Polkadot enables your to
plug-in many of the same components used to build it into a custom chain built
by you. But this unique feature may not always be the best choice for you since
it comes with some overhead. There are already chains which are planning to
support smart contracts on their platform which will be connected to the Polkadot
network. It may be desirable to some to build on one of these chains instead of
starting a new chain. We will now lay out the key differences between parachains
and smart contract platforms and describe why you may want to choose one over another.

Broadly speaking, if you want to have control over the foundational mechanics of
your network then a parachain is a good option for you. Building a parachain means
that you can design the economics of the monetary system from the ground up to be
how you like it. Maybe you want to implement a custom fee structure into your transactions
or perhaps you like to implement a treasury which could act as a native DAO which
would receive funds from the block reward and give stakeholders voice to
allocate funds. If you have a very specific use case that can be optimized
as a chain specific state transition function, or you are implementing something
novel such as a new virtual machine, then likely you will be more attracted
to building a parachain.

Instead if you want a lower barrier to entry and more rapid iteration cycles
of quick prototyping and deployment, then you will probably be more attracted
to the experience of smart contracts. Since smart contracts take less time
to develop, it means that you can get your idea out into the world that much
quicker. An additional benefit is that smart contracts have environments
in which other applications are deployed. This means that if your application
requires an application to already be deployed on the chain in order to
interact with it in some capacity then you will want to build a smart contract
on that chain. An example of this are the DeFi (decentralized finance) applications
on Ethereum which build off of each other to create things like decentralized
hedge funds.

You should be aware of some of the overhead of creating a parachain that simply
does not exists for deploying a smart contract. One of these is that you will
be required to figure out your own method of incentivizing collator nodes on
your network or simply be required to keep one always running yourself. Another
is that the inclusion into the Polkadot shared security will not be _free_, but
will require the staking of DOTs in order to write your parachain to the registry.
Unless you're absolutely positive that your application will need its own chain,
or you're ready to complete all the surrounding requirements for launching a parachain,
it is advisable you begin by trying out your idea with smart contracts.

Here is a quick comparison chart to help you digest the information:

| Parachain | Smart Contract |
|-----------|----------------|
| more complex to develop (-) | easy to develop (+) |
| requires collator node to deploy (-) | easy to deploy (+)  |
| interaction between parachains (+) | interaction between applications (+) |
| requires network maintainance (-) | easier to maintain (+) |
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

> Aside: Actually this is not strictly true since you could write all your chain logic
from scratch. The only requirement is that it must compile to WASM and expose
the basic API that Polkadot validators expect. But if you're considering that
then you can stop reading this guide because you won't need it and you will not
benefit from the re-usability that frameworks like Substrate enable.

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

You will likely want to use the convienence script provided by the Substrate developers
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
compile it into a WASM blob which contains your state transition function. This is
the core of your blockchain and is what the validators on the Polkadot relay chain
will validate all state transitions against. But before you're able to submit your
chain into the parachain registry of Polkadot there is still a couple things you
need to take care of.

The two big things you will need to resolve when you are finished developing your chain
logic are 1) you need to set up at least one collator node and 2) you will need to ensure
your entry on the relay chain by acquiring a spot on the parachain registry.

You will need to do the first one because the validators on the relay chain need some way
to become aware of new state transitions coming from your chain. This functionality is
handled by the specialized type of node known as the [collator](../learn/terms_and_definitions.md#collator).
Basically collators are the nodes which will producing blocks for your chain and there
could be just one or there could be many. They can be ran as public services or there
could be an incentive structure baked into your parachain to encourage users to pop
up more of them.

Right now it's still pretty early on in the development of collator nodes.
There is an early demo that is available in the Polkadot repository, if you are
keen you can try running an early demo by following this [video tutorial](https://www.youtube.com/watch?v=pDqkzvA4C0E).
However, as development continues there will be libraries that will make setting up a
Polkadot-compatible parachain _super easy_. And that library will be called Cumulus.

#### Cumulus

[Cumulus](https://github.com/paritytech/cumulus) is a library that is still in
development and is _not_ ready to use yet. 

It is an extenstion to the Substrate library that will make any Substrate
runtime compatible with Polkadot by embedding a light client that will
follow the relay chain.

It will handle some annoying things that your chain will need to do if it 
wants to be part of Polkadot such as:

 - handling interchain messaging between parachains
 - out-of-the-box collator node
 - follows the relay chain with an embedded light client
 - compatible with Polkadot specific intricacies of block authorship

Getting started with Cumulus once it's ready will be as easy as:

 - Minimal modification to the Substrate chain already written
 - Cumulus will port it over with little effort

For the latest on Cumulus see a recent talk from Rob Habermeier below.

[![img](http://img.youtube.com/vi/thgtXq5YMOo/0.jpg)](https://www.youtube.com/watch?v=thgtXq5YMOo)

<!-- #### Ensuring a fair validator choice -->

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

The current thinking is that there will be some type of auction mechanism
that will distribute the spots in the parachain registry. This auction may
probably be something similar to what is currently employed in the Ethereum
Name System to distribute domain names. Namely, it will be a [Vickrey](https://en.wikipedia.org/wiki/Vickrey_auction),
also know as a second-price auction, that will be used to allocate registry entries
to parachain projects for various time durations (eg. 6 months, 12 months,
24 months). In order to participate in the auction you will need to stake
enough DOTs to be the highest bidder and then allow your DOTs to be locked
for the duration of your entry.

You can start thinking now about how to fund enough DOTs to ensure you
secure an entry on the parachain registry. Some ideas include a crowdfunding
campaign in which participates will stake their own DOTs individually for a 
single chain, a crowdsale for which participants will purchase some tokens
of a chain so that chain can have enough DOTs to secure its entry, or through
private fundraising means.

#### What happens when the time runs out?

Once you secure your entry into the parachain registry you are ensured that
spot until either 1) the duration of the time attached to that entry has elapsed
or 2) the governance mechanism votes to remove it.

Option 2 will probably only happen in dire circumstances and will not be something
that commonly takes place. Option 1 will be the way that most chains will expire
off the Polkadot network. 

The fact that you and all the users of the chains know the public deadline of that
chains life is a good thing because it means that either a referendum could be
held by the stakeholders of the chain to extend it (if your chain implements
on-chain governance) or users can safely migrate off the platform to an
alternative.

In most cases it should be fairly straightforward to simple "renew" your
entry on the parachain registy by continuing to stake DOTs.

### Benefits of being a parachain

The benefit of being a parachin on Polkadot is that your chain will be secured
with the same security as the entire Polkadot network without you needing to 
maintain your own consensus. Additionally, your chain will be able to interact
withh all other Polkadot parachains through the interchain communication system.

Many tools and monitoring being built currently for Polkadot or parachains
will be easily portable or re-usable by other parachains too. In the past 
sovereign chains would need to have compatible wallets that supported them.
With Polkadot, much of the basic tooling like wallets and block explorers
will already be available and configurable to your parachain.

Finally, being a Polkadot parachain will allow you and your community
to experiment with the latest innovations in blockchain tech. Whether
you are interested in governance, scalability, privacy, or custom VMs,
Polkadot is general enough that it will support your innovations at launch
and into the future.

That's the end of the parachain section, you can either read about smart contracts
or go straight to the [conclusion](#conclusion).

## So you want to build a smart contract

The Polkadot relay chain itself will not support smart contracts but
since Polkadot is a network of many heterogeneous blockchains, there
will be parachains that do.

Already Parity Technologies has laid much of the groundwork for an
out-of-the-box solution for parachains that want to include smart contract
functionality. The Substrate [contract](https://github.com/paritytech/substrate/tree/master/srml/contract)
module in the core SRML will support smart contracts that are compiled
to WASM. 

In order to actually develop a smart contract that compiles to WASM, an
appropriate language is also needed. For this, Parity has also been working
on a domain specific language called [pDSL](#pdsl-paritys-domain-specific-language).

There is already one project that has announce intent to become a Polkadot
parachain and to support smart contracts called [Edgeware](#edgeware). More
will likely begin to emerge as the tooling matures and the ecosystem around
Polkadot expands.

Polkadot will also be compatible with pre-exisiting smart contract platforms
such as Ethereum and Tezos through bridges. This means that even work spent
developing on these platforms today may be applicable to running on Polkadot
in the future.

### Edgeware

Edgewareis a planned parachain for Polkadot which will
allow for smart contracts. Along with other interesting innovations in governance
and token distribution, it will likely be the first parachain that will connect
to the Polkadot mainnet with smart contracts enabled. You can stay up to date with
the project on their [website](https://edgewa.re).

### pDSL (Parity's Domain Specific Language)

The [pDSL](https://github.com/Robbepop/pdsl) is intended to be a new domain specific
language for writing smart contracts in Rust that will compile down to WASM code.
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
onto the chain and be available to users. To deploy your smart contract on chain
may vary slightly for whichever platform you have chosen as your stack, but in
general it will involve sending a special transaction which will `create` your
smart contract on the ledger. Usually this transaction will require a fee to cover
the computation costs of any constructor logic and for storage that it consumes.

## Paying for your smart contract

Different platforms will have different ways for paying for your
smart contract deployment and maintainence.

Some ways you different platforms might implement paying for smart contracts:

 - a transaction fee associated with the deploy transaction
 - a subscription model in which you pay to subscribe to a chain
 - access token model in which you must hold enough tokens to use a chain (cp. EOS)
 - storage rent
 - free trial. Some chains may want to attract new developers with promotions

In general most smart contract platforms implement the notion of `gas` which
represents the computation required to run your smart contract logic across
the network. Gas is usually paid for by paying the corresponding `gas price`
that is sepcified in the transaction. 

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
Keep up with the projects above and watch out for the first testnets to be released.
If you're feeling brave you can try to work with the tools outlined above but be 
aware that much of this technology is still prior to stable release so will probably
change as we continue progress toward the future mainnet Polkadot release.

## Conclusion

Hopefully this guide has helped you to make the right decision for whether
your new project will be a parachain or a smart contract, and shown you the
essiential resources for which you can use to start developing on Polkadot today.
Even though the tooling is still maturing, there is a benefit for arriving to
the scene early: you have the ability to innovate by creating something
truly new. If you would like to share your ideas for a parachain or a smart contract
feel free to talk to us in the [Polkadot Watercooler](https://riot.im/app/#/room/#polkadot-watercooler:matrix.org) and if you have questions
regarding development you can try asking in the [Polkadot Beginners Lounge](https://riot.im/app/#/room/#polkadotnoobs:matrix.org).
Keep up to date by following the appropiate [social channels](https://wiki.polkadot.network/en/latest/community/) and good luck
building your vision into reality on Polkadot!