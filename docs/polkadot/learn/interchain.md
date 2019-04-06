# Interchain Communication

Interchain transactions are resolved using a simple queueing mechanism based around a merkle tree to ensure fidelity. It is the task of the relay-chain validators to move transactions on the output queue of one parachain into the input queue of the destination parachain. 

> The input and output queue are somtimes referred to in the codebase as "ingress" and "egress" messages.

## Summary

Collator nodes are responsible for routing messages between chains. Parachains produce a list of "egress" posts of messages and receive "ingress" messages from other parachains. On each block, parachains will be expected to route messages from some subset of all other parachains. When a collator produces a new candidate block to be included in the parachain it will collect the latest ingress queue information and process it. Validators will check that the new candidate for the next block includes the processing of the expected ingress messages to that parachain.
