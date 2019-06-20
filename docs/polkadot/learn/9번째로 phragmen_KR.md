# Phragmen이 무엇이고 노드 운영자에겐 어떤 의미 인가요?

## sequential Phragmen method가 뭔가요?

The sequential Phragmen method is a multi-winner election method introduce by Edvard Phragmen in the 1890s.

순차적인(Sequential) Phragmen 메소드는 1890 년대 Edvard Phragmen이 소개 한 다중 수상자 선거 방식입니다.

> The problem that Phragm ́en’s methods try to solve is that of electing a set of a given numbers of persons from a larger set of candidates. Phragm ́en discussed this in the context of a parliamentary election in a multi-member constituency; the same problem can, of course, also occur in local elections, but also in many other situations such as electing a board or a committee in an organization.

Phragm en의 방법이 해결하려고하는 문제는 더 많은 후보자 중에서 주어진 수의 사람을 선출하는 것입니다. Phragm은 다원 선거구에서 의회 선거의 맥락에서이를 논의했다. 물론 같은 문제는 지방 선거에서도 발생할 수 있지만 조직의 이사회 나위원회 선출과 같은 다른 많은 상황에서도 발생할 수 있습니다.

Phragmen's sequential method is used in the NPoS algorithm of Polkadot to elect validators based on the weight (amount staked to them by nominators). It also handles equalization of weights among validators after each round. Equalization happens in order to spread nominated DOTs among the wider set of validators and enforce stronger decentralization properties to the network.

Phragmen의 순차적 방법은 Polkadot의 NPoS 알고리즘에서 가중치 (추천자가 보유한 금액)를 기준으로 유효성 검사기를 선택하는 데 사용됩니다. 또한 각 라운드 후에 유효성 검사기 간의 가중치 균등화를 처리합니다. 균등화는 지명 된 DOT를 광범위한 유효성 검사기 집합으로 전파하고 네트워크에 더 강력한 분산 특성을 적용하기 위해 발생합니다

## What does it mean for node operators?

_Updated as of Alexander v0.4.3_

### For nominators

Currently the `equalise` flag is set to false so equalization will not take place. As a nominator your nomination will stay with the validator that you nominate to.

현재 'equalise` 플래그는 false로 설정되어 등화가 발생하지 않습니다. 추천인으로서 귀하의 지명은 귀하가 지명 한 유효성 확인 기와 함께있을 것입니다.

### For validators

Currently the `equalise` flag is set to false so equalization will not take place. As a validator the nominations you have received will stay with you.

현재 'equalise` 플래그는 false로 설정되어 등화가 발생하지 않습니다. 유효성 검사기로서 귀하가받은 후보자는 귀하와 함께있을 것입니다.

## Details

The implementation of the Phragmen method can be found in the Substrate `srml-staking` crate. It is used in the selection of validators from the available set based on their role preferences (validator or nominator). The election will run for a number of rounds which is equal to that amount of current validators.

Phragmen 방법의 구현은 Substrate`srml-staking` crate에서 찾을 수 있습니다. 역할 기본 설정 (유효성 검사 자나 추천자)을 기반으로 사용 가능한 세트에서 유효성 검사기를 선택하는 데 사용됩니다. 선거는 현재 유효성 검사기와 동등한 수의 라운드 동안 진행됩니다.

## External Resources

- [W3F Research Page on Sequential Phragmen Method](https://research.web3.foundation/en/latest/polkadot/NPoS/4.%20Sequential%20Phragm%C3%A9n%E2%80%99s%20method./) - The formal adaptation of the Phragmen method as applied to Polkadot validators.
- [Python Reference Implementations](https://github.com/w3f/consensus/tree/master/NPoS) - Implementations of Simple and Complicated Phragmen methods.
- [Substrate Implementation](https://github.com/paritytech/substrate/blob/master/srml/staking/src/phragmen.rs) - Rust implementation used in the Substrate Runtime Module Library.
- [Phragmen's and Thiele's Election Methods](https://arxiv.org/pdf/1611.08826.pdf) - 95-page paper explaining Phragmen's election methods in detail.
