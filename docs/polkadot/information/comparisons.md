# Polkadot compared to {Cosmos,Ethereum,Tezos}

Polkadot is a blockchain technology but makes some innovations
that sets it apart from other popular chains.

## Ethereum

### Ethereum 1.x

### Ethereum 2.0

## Tezos

## Cosmos

Cosmos may be considered the most similar to Polkadot in regard to
the goal of being a multi-chain system. In Cosmos, multiple chains
operate in what are called _zones_  and each use an individual
instance of the Tendermint consensus algorithm. Interchain communication
is handled via a master _hub_ chain and is limited to the transfer
of digital assets rather than arbitrary information.

There is no notion of shared security in Cosmos and each of
the zoned chains are expected to have their own Validator sets
and means of incentivising them.

Polkadot has stronger guarentees than Cosmos in ensuring the 
economic security over the global state of the relay chain and
parachains. However, the stricter coherence of Polkadot may
not allow as much flexibility to parachains as Cosmos does
to the zoned chains.

The governance of both projects is remarkably distinct as well.
In Cosmos, the governance power lies solely with the validators
and delegators whom vote on proposals and upgrades. While Polkadot's
governance system is agreed upon by stake-weighted referndum and
includes mechanisms to represent passive stakeholders such as the council.

Here is a quick table denoting key differences:

|   |Cosmos|Polkadot|
|---|---|---|
|Consensus|Tendermint (PBFT)|GRANDPA|
|Governance|Validator/Delegator Vote|Referendum and Council representing stakeholders|
|Models|Hub and Zones|Relay chain and parachains|
|Security|Each zone has its own security|Shared security across parachains|
|Native token|Atom|Dot|
