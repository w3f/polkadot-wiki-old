# Frequently Asked Questions (FAQs)

_This FAQ focuses on technical questions for users interested in developing applications for Polkadot.  If you have a more general question, you may wish to search for the answer on the main [Polkadot Network FAQ](https://polkadot.network/faq).  If you have a question which is not answered, please feel free to ask on the Polkadot Watercooler [Riot channel](https://riot.im/app/#/room/#polkadot-watercooler:matrix.org)._

[TOC]

### How many validators will be online at launch?

Approximately 50.

### How do I apply to be a validator?

This has not been announced at this time. Please follow the appropriate
social channels to stay up to date.

<!-- ### How does the Nominated Proof-of-stake (NPoS) scheme work?

TODO -->

### How does consensus on the relay chain work?

Please see the entry on the [GRANPDA](./grandpa.md) finality gadget.

### What is the expected block time on the relay chain?

The expected block time on the relay chain is estimated to be limited
by the theoretical limits of the peer-to-peer networks of the validators.
Since there is no forced time between blocks due to Proof-of-Work and the only
overhead on Validators is to validate state transitions, the block times should
be quite fast. On a scale of 2 - 3 seconds may not be unreasonable after optimizations.

### What is the token inflation rate?

The token inflation and staking mechanics have not been finalized at this
time and will be announced soon.

### How are validators rewarded?

Validators are rewarded from the block reward of the relay chain. The mechanics of this
have not been announced yet and will be updated soon.

### How do parachain economics work?

Parachains have the flexibility to implement their own monetary system or
incentive structure for collators. However, this is not strictly necessary.
Since the collator's job is to continue to give recent state transitions to 
the validators on the relay chain whom validate each transition, the security
of the parachain and the Polkadot network is completely separate from parachain
economics. Parachains need collators to continue to progress, so it wouldn't be
unreasonable to see them incent collator nodes in some way but it is completely
up to parachain implementors.
