# Bridges

One of the central ideas in blockchain intercommunication is the role of bridges. Some of the exact details of how bridging will work in Polkadot has yet to be decided, so this page is a work in progress and will be updated as more details come out.

There are likely three different types of bridging in Polkadot:

* Bridge contracts - Smart contracts deployed as bridges between Polkadot and external chains.
* Cross parachain communication - no contracts needed.
* In-built birdging modules - Bridging to Polkadot from an external chain via a purpose built module.


## Bridge Contracts
Those who are already familiar with Ethereum will probably already know of the [Parity Bridge](https://github.com/paritytech/parity-bridge) and the efforts being made to connect PoA sidechains to the Ethereum mainnet. The bridge is a combination of 2 smart contracts: one deployed on each chain that allows for cross-chain transfers of value. Ether deposited into the contract on the main net will provide a balance denominated in (say) ERC-20 tokens on the sidechain. While ERC-20 tokens deposited back into the contract on the sidechain can free up Ether on main net.

In the case of Polkadot, it should be possible to have a bridge contract deployed on to (say) an EVM-based standalone chain and a contract deployed on a smart contract capable parachain. This wouldn't necessarily be the most efficient method of bridging, but given the generality of a Turing complete parachain it would be possible to bridge Polkadot and any other smart contract capable blockchain.

### Resources

* [Edgeth Bridge](https://github.com/hicommonwealth/edgeth_bridge/) - a bridge from Ethereum to Edgeware chain (a Substrate-based chain).
* [Parity Bridge](https://github.com/paritytech/parity-bridge)
* [POA Network](https://poa.network/)
* [Case study](https://medium.com/giveth/ethereum-dapp-scaling-poa-network-acee8a51e772) of POA Network's implementation of Parity's bridge chain solution.

## Cross parachain communication
As mentioned on the [[Parachains|parachains]] page, parachains will be able to send messages (including transactions) to each other without the need for smart contracts to perform the bridging functionality. Cross parachain messaging will be native to Polkadot.


## In-built bridging modules
Receiving messages on a parachain from another blockchain will likely be done natively within a module of the client software. This would negate the need for for bridging contracts. The collator node functionality is intended for the exact purpose of transaction collation, including transactions which have originated outside of Polkadot.

The bridging modules will likely be written with particular parachains in mind (e.g. Bitcoin, Ethereum), which means that any blockchain that's based on either of those should be able to be bridged directly to Polkadot without the need of going through a bridge contract on a parachain. This should allow for faster execution for those chains that are compatible.

For the standalone chains that don't have an in-built module on Polkadot, it should be possible to deploy a bridge contract to a Turing complete parachain.

### Resources
* [ChainX BTC Bridge](https://github.com/chainx-org/ChainX/tree/develop/cxrml/bridge/btc) - ChainX have implemented a BTC to Substrate bridge for their parachain