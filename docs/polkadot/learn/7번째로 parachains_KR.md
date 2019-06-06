# Parachains

## What is a parachain?

Parachains take their name from the concept of "parallelized" chains which share in the security of the Polkadot relay chain. Parachains are _validatable, globally-coherent dynamic data-structures_ which can connect into the Polkadot network and although most commonly will resemble independent blockchains, there is no specific need for them to be blockchain in nature.

Parachains는 Polkadot 릴레이 체인의 보안을 공유하는 "병렬화 된"체인 개념에서 이름을 따 왔습니다. Parachains는 Polkadot 네트워크에 연결할 수있는 유효성이 낮은 전역 적으로 일관된 동적 데이터 구조이며 가장 일반적으로 독립적 인 블록 체인과 유사하지만 자연에서 블록 체인이 필요하지는 않습니다.

Rob Habermeier, a co-founder of Polkadot, [described parachains in the following way](https://medium.com/polkadot-network/polkadot-the-parachain-3808040a769a):

> A parachain (parallelizable chain) is a simpler form of blockchain, which attaches to the security provided by a ‘relay chain’ rather than providing its own. The relay chain provides security to attached parachains, but also provides a guarantee of secure message-passing between them.


parachain (병렬화 가능 체인)은 블록 체인의 더 간단한 형태로, 자체 체인을 제공하는 것이 아니라 '릴레이 체인'이 제공하는 보안에 연결됩니다. 릴레이 체인은 부착 된 낙하산에 보안을 제공 할뿐만 아니라 안전한 낙하산을 보장합니다.


The Polkadot architecture allows for the state transitions performed on the parachain to be specified as a Wasm executable. Proofs of new state transitions that occur on a parachain must be validated against the registered state transition function (STF) by validators before the state transition can take place.

Polkadot 구조는 parachain에서 수행 된 상태 전이가 Wasm 실행 파일로 지정되도록합니다. 파라과이에서 발생하는 새로운 상태 전이의 증거는 상태 전환이 발생할 수 있기 전에 유효성 검사기에 의해 등록 된 상태 전이 함수 (STF)에 대해 유효성을 검사해야합니다.

## Benefits of parachains

By connecting to Polkadot a parachain gains two major advantages over an independent _sovereign chain:_

- [Shared security](./security.md)
- [Trust-free interchain transactability](./interchain.md)

## Examples

- Encrypted Consortium Chains
- High Frequency Chains
- Privacy Chains
- Smart Contract Chains

## Collators

Parachains are operated and new blocks are authored by [collator nodes](../node/collator.md) that maintain "full-nodes" of a particular parachain. They retain all necessary information to be able to propose new blocks and execute transactions in a similar way as miners do in traditional PoW blockchains. A block proposed by a collator node will be checked by the validator node before it is accepted as a canonical state transition by the relay chain.

Parachains가 작동되고 특정 parachain의 "전체 노드"를 유지하는 collator 노드 (../node/collator.md)가 새로운 블록을 작성합니다. 그들은 광부가 전통적인 PoW 블록 체인에서하는 것과 유사한 방식으로 새로운 블록을 제안하고 거래를 수행 할 수 있도록 필요한 모든 정보를 보유합니다. 콜레 이터 노드에 의해 제안 된 블록은 릴레이 체인에 의한 표준 상태 전이로 수락되기 전에 유효성 검사기 노드에 의해 검사됩니다.

## What is "parachain consensus"?

"Parachain consensus" is special in that it will follow the Polkadot relay chain. Parachains cannot use other consensus algorithms that provide their own finality, and if they do will be sovereign chains that must bridge to the relay chain. Parachains have control over how blocks are authored and by who.

"Parachain consensus"는 Polkadot 릴레이 체인을 따를 것이라는 점에서 특별합니다. Parachains는 자신의 최종성을 제공하는 다른 합의 알고리즘을 사용할 수 없으며 릴레이 체인에 연결되어야하는 주권 체인이됩니다. 낙하산은 블록 작성 방법 및 누가 작성자를 제어합니다.
"Parachain consensus

## How will parachain slots be distributed?

Parachain slots will be acquirable through auction, please see the [parachain slots](./auction.md) article.

## Parachain Development Kits (PDKs)

Parachain Development Kits are a set of tools that enable developers to create their own applications as parachains. For more info see [here](../build/pdk.md).

## Deploying parachains

Please see the builder's article on [deploying parachains](../build/deploy-parachains.md).
