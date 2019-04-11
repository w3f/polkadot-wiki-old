# Randomness

## VRFs

BABE assigns block production slots to validators according to stake and using the Polkadot randomness cycle.

## Other approaches to randomness on blockchains

- [RANDAO]() - RANDAO involves each validator to prepare by performing a series of hashes on some seed. Validators then publish the final hash during a round and the random number is derived from every participants entry into the game. As long as one honest validator participates the randomness is considered secure (non-economically viable to attack). It was not chosen as the randomness method for the VRF used in Polkadot because revealing a hash from every block producer for each slot costs quadratic bandwidth, or at least quadratic computation.
