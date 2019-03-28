# Interchain Communication

## Summary

Collator nodes are responsible for routing messages between chains. Each parachain produces a list of "egress" posts of messages for each other parachain on each block, for a total of N^2 lists all together.

On every block, each parachain will be expected to route messages from some subset of all other parachains.

When a collator produces a new candidate block to be included in the parachain it collects the latest ingress queue information and processes it.
