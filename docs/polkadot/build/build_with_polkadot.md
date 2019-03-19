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

Here is a quick pro-con chart to help you digest the information:

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

Once you've determined that parachain development is the right path for your project, 
you will need to decide on what framework you will use to create your runtime module. 
Right now there is only one option which is Substrate.

### Substrate

The most definitive resource for substrate development is the Parity maintained [Substrate Development Hub](https://docs.substrate.dev).

There are a few full length tutorials which are helpful for getting up to speed
with development of runtime modules:

 - [Token Curated Registry as DappChain](https://docs.substrate.dev/docs/building-a-token-curated-registry-dappchain-using-substrate)
 - [Substratekitties: Collectibles tutorial on substrate](https://shawntabrizi.github.io/substrate-collectables-workshop/)

You will likely want to get st  arted by using the `substrate-node-new`
script.

You can use this script

```bash
curl https://getsubstrate.io -sSf | bash
```

Or alternatively try this [stable package](https://github.com/shawntabrizi/substrate-package) containing the node and ui.

### Set-up your chain

Once you've decided on your development framework and have made your application
you'll have a compiled WASM blob that needs a few more things before it can
graduate to being a parachain on polkadot.

Substrate provides a simple node for development but won't cut it for fuller
applications.

In order to deploy a parachain to production you will need to run your own collator node.
You can try running an early demo by following this [video tutorial](https://www.youtube.com/watch?v=pDqkzvA4C0E).

Right now the collator node part of the polkadot runtime is being actively developed
so we'll be adding more here as it progresses.

#### Cumulus

[Cumulus](https://github.com/paritytech/cumulus) is an in-development library that will make the overhead of writing parachains' distribution, p2p, database, and synchronization layers which is required for connecting to the Polkadot network.

It is an extenstion to the Substrate library that will make any Substrate
runtime compatible with Polkadot by embedding a light client that will
follow the relay chain.

Getting started with Cumulus (once it's ready):

 - Minimal modification to the Substrate chain already written
 - Cumulus will port it over with little effort

#### Ensuring a fair validator choice

### How to include your parachain in polkadot

For your parachain to be included in Polkadot you will need to be
entered into the parachain registry.

The whitepaper states that parachains can only be added to the 
registry through full referendum voting. Additionally, the removal
of the parachain would come only after a referendum which would include
a grace period to allow for orderly transition to other chains.

The current thinking is that there will also be a [Vickrey](https://en.wikipedia.org/wiki/Vickrey_auction) auction,
aka a second-price auction, that will be used to sell registry entries
to parachain projects for pre-defined time durations (eg. 6 months, 12 months,
24 months).

You may want to start thinking now about how you will fund the purchase
of the registry entry. You may want to crowdsource the purchase by pooling
funds from the community, or you may fund the purchase of the entry
singly by yourself through private means.

Some entries into the parachain registry may be granted to useful projects
by the governance mechanism because they provide uniqe and substantial 
value to polkadot.

#### What happens when the time runs out?

After purchasing an entry into the parachain registry, you will have
a determined amount of time before your spot in the entry will end.

Before the end date approaches too close you may want to begin to consider


## So you want to build a smart contract

Polkadot will likely have a variety of parachains which offer smart contracts
to developers. These are still rapidly progressing and more content will be
posted as the technology is ready.

### Edgeware

[Edgeware](https://edgewa.re) is a planned parachain for Polkadot which will
allow for smart contracts.

### pDSL (Parity's Domain Specific Language)

The [pDSL](https://github.com/Robbepop/pdsl) is still in experimental phase and not yet
accepting external contributors. However, it provides some insight into the future of smart
contracts. It intends to provide an efficient, simple, robust, accesible language for
developers that will work with existing Rust tooling.

## Deploying your app as a smart contract

After you've developed your smart contract by using one of the platforms
above you will deploy it to the chain by sending a transaction containing
the deploy code.

As the platforms become available, we will update examples in this wiki.

## Paying for your smart contract

Different platforms will have different ways for paying for your
smart contract deployment and maintainence.

Some ways you will pay for smart contracts include:

 - a transaction fee associated with the deploy transaction
 - a subscription model in which you pay to subscribe to a chain
 - access token model in which you must hold enough tokens to use a chain (cp. EOS)
 - storage rent
 - free trial. Some chains may want to attract new developers with promotions
