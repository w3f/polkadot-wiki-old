# What is Phragmen and what does it mean for node operators?

## What is the sequential Phragmen method?

The sequential Phragment method is a multi-winner election method introduce by Edvard Phragmen in the 1890s.

> The problem that Phragm ́en’s methods try to solve is that of electing a set of a given numbers of persons from a larger set of candidates. Phragm ́en discussed this in the context of a parliamentary election in a multi-member constituency; the same problem can, of course, also occur in local elections, but also in many other situations such as electing a board or a committee in an organization.

Phragmen's sequential method is used in the NPoS algorithm of Polkadot to elect validators based on the weight (amount staked to them by nominators). It also handles equalization of weights among validators after each round. Equalization happens in order to spread nominated DOTs among the wider set of validators and enforce stronger decentralization properties to the network.

## External Resources

- [W3F Research Page on Sequential Phragmen Method](http://research.web3.foundation/en/latest/polkadot/NPoS/phragmen/) - The formal adaptation of the Phragmen method as applied to Polkadot validators.
- [Python Reference Implementations](https://github.com/w3f/consensus/tree/master/NPoS) - Implementations of Simple and Complicated Phragmen methods.
- [Substrate Implementation](https://github.com/paritytech/substrate/blob/master/srml/staking/src/phragmen.rs) - Rust implementation used in the Substrate Runtime Module Library.
- [Phragmen's and Thiele's Election Methods](https://arxiv.org/pdf/1611.08826.pdf) - 95-page paper explaining Phragmen's election methods in detail.
