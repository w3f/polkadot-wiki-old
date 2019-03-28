# Interchain Communication

## Summary

Collator nodes are responsible for routing messages between chains. Parachains produce a list of "egress" posts of messages and receive "ingress" messages from other parachains. On each block, parachains will be expected to route messages from some subset of all other parachains. When a collator produces a new candidate block to be included in the parachain it will collect the latest ingress queue information and process it. Validators will check that the new candidate for the next block includes the processing of the expected ingress messages to that parachain.

