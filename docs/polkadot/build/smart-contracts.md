# Smart Contracts

The Polkadot relay chain will not support smart contracts natively, however parachains on Polkadot will support smart contracts. There are already announced projects such as [Edgeware](https://edgewa.re), thanks to the Substrate built-in [contract module](https://crates.parity.io/srml_contract/index.html) it is likely more parachains will support this feature.

## Resources

Here are the list of current resources available to developer who want to get started writing smart contracts to deploy on parachains based on Substrate.

- [ink!](https://github.com/paritytech/ink) - Parity's ink to write smart contracts. 
- [Deploying your first contract](https://github.com/paritytech/ink/wiki/Deploying-Your-First-Contract) - Guide to deploy the provided `flipper` contract.
- [Writing your first contract](https://github.com/paritytech/ink/wiki/Writing-Your-First-Contract) - Guide to how one would write the `flipper` contract.
- [Substrate contracts workshop](https://shawntabrizi.github.io/substrate-contracts-workshop/#/) - Walks you through the basics of using `ink!` and writing an ERC20 token.

## Examples

Collected below are some community examples of smart contracts in `ink!`. Are you working on a smart contract example? Ask us to add it to this page!

- [Ownable](https://github.com/JesseAbram/foRust/) - Port of the OpenZeppelin `Ownable` contract.

## What is the difference between developing a smart contract versus a parachain?

### Layer of Abstraction

When you write a smart contract you are creating the instructions which will be deployed and associated to a specific chain address.

In comparison, a runtime module is the entire logic of a chain's state transitions (what's called a state transition function).

Smart contracts must consciously implement upgradeability while parachains will have the ability to swap out their code entirely through a root command or via the governance module.

When you build a smart contract it will be eventually be deployed to a target chain with its own environment. While parachains allow the developer to declare the environment of their chain, even allowing others to put smart contracts on it.

### Gas Fees

Smart contracts must implement a form of gas metering or else make full nodes vulnerable to DOS attacks. Things like infinite loops could possibly consume the computation of a chain entirely and block it from further use. The [halting problem](https://en.wikipedia.org/wiki/Halting_problem) is what leads to the notion of gas for accounting for computation spend on blockchains.

Parachains get around this constraint and contain no notion of gas for their own native logic. This means that some things become more viable and easier to implement for the developer, but it also means there are some things which should _never_ be implemented. Sometimes leaving certain logic such as heavy iterations which could possibly run indefinitely to the smart contract layer will be the wiser choice.
