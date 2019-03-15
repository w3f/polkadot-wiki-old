# How Can I Build with Polkadot?

## Where are we now?

Polkadot is under active development. The current testnet release is version 0.3 Alexander.
If you are thinking about building your project on polkadot, you may be wondering
how to start. A big question is whether you will build a parachain or a smart contract.
This guide will walk you through the basics of the polkadot ecosystem.

The ecosystem is still evolving and so will this guide. So check back
frequently for updates.

## What is the difference between a parachain and smart contract?

It's important to know the difference between a parachain and a smart contract
before you begin work on your project. Since both options have their trade-offs
and benefits, some projects work well as a parachain while others work better
as smart contracts on an already mature blockchain.

In general, if you want control over the foundational mechanics of your
blockchain such as a custom fee structure for transactions, a
monetary system with a treasury, an optimized state transition function,
or are implementing something novel such as a new virtual machine, you will
likely be creating a parachain.

Instead if you would like to quickly prototype and deploy your application
you might be more interested in creating a smart contract.

Be aware that the benefits of developing a parachain also has its 
downsides, it involves running your own network of collators and 
eventually bidding for inclusion in the Polkadot shared security
by staking DOTs. Unless you're sure you are not able to do 
what you want to do on a smart contract platform because you've
already tried, it is generally advisable you start by trying out
your idea there.

| Parachain | Smart Contract |
|-----------|----------------|
| more complex to develop (-) | easy to develop (+) |
| requires collator node to deploy (-) | easy to deploy (+)  |
| interaction between parachains (+) | interaction between applications (+) |
| requires network maintainance (-) | easier to maintain (+) |
| possible to implement complex network logic and advanced crypto (+) | harder to implement complex logic or crypto (-) |
| is its own network (+) | exists inside network (-) |

## Parachain

Once you've determined that parachain development is the right path for your project, 
you will need to decide on what framework you will use to create your runtime module. 
Right now there is only one option which is Substrate.

### Substrate

The most definitive resource for substrate development is the Parity maintained [Substrate Development Hub](https://docs.substrate.dev).

There are a few full length tutorials which are helpful for getting up to speed
with development of runtime modules:

 - [Token Curated Registry as DappChain](https://docs.substrate.dev/docs/building-a-token-curated-registry-dappchain-using-substrate)
 - [Substratekitties: Collectibles tutorial on substrate](https://shawntabrizi.github.io/substrate-collectables-workshop/)

You will likely want to get started by using the `substrate-node-new`
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


## Smart Contracts

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
