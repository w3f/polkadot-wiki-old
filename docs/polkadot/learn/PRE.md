# Polkadot Runtime Environment (PRE)

The Polkadot Runtime Environment is an important component of the Polkadot protocol. It consists of the networking, consensus and WASM interpreter and acts as the lower layers that house the different runtimes of Polkadot and the parachains.

The three components of the PRE:

- Networking (Libp2p).
- Consensus (GRANDPA).
- WASM interpreter (wasmi).

The code of the PRE can be compiled to run natively. The top layer of the Polkadot stack, what are called the runtimes, must be written in a language that compiles to WASM and will be unique to each chain.

The image below is taken from the slide deck Gavin Wood presented on Substrate and demonstrates visually the 4 layers of the Polkadot stack.

![PRE](../../images/PRE.png)
