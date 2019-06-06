# 폴카닷 합의 알고리즘 (Polkadot Consensus)

## 왜 합의가 필요한가요?

합의는 공유된 상태(shared state)에 대한 일치(agreement)에 이르는 방법입니다. 블록체인의 상태(state)가 계속해서 쌓고 앞으로 나아가려면 네트워크의 모든 노드가 동의하고 합의에 이르러야 합니다. 합의는 분산 네트워크의 노드가 서로 동기화 상태를 유지할 수 있는 방법입니다. 블록체인에서 분산된 네트워크에 대한 합의가 없으면 한 노드가 참이라고 믿는 상태가 다른 노드와 공유 될 수 있도록 보장 할 방법이 없습니다. 합의는 각자 자신의 네트워크에 대한 _주관적_ 관점을 가지고있는 참가자들 사이에서 상태의 _객관적인_ 시각을 제공하는 것이 목표입니다. 이 노드들이 의사 소통을하고 합의에 도달하고 새로운 블록을 만들 수 있게 하는 프로세스입니다.

## PoW와 PoS는 무엇인가요?

Proof of Work (PoW)와 Proof of Stake (PoS)는 소위 블록체인의 합의 메커니즘이라고 언급되지만 전체 그림을 담아내지는 않습니다. PoW는 블록 작성자와 Bitcoin에서는 체인 선택 알고리즘인 Longest chain 규칙을 포함하는 더 완전한 [나카모토 컨센서스](#nakamoto-consensus)의 일부에 동의하는 방법입니다. 마찬가지로 PoS는 밸리데이터 집합을 선택하기위한 규칙들의 집합이고 체인 선택 규칙이나 어떻게 체인이 블록의 Finality에 도달하는 방법에 대해서는 특정하지 않습니다. PoS 알고리즘은 전통적으로 노드간에 Byzantine agreement를 맺는 알고리즘과 함께 사용되었습니다. 예를 들어, [Tendermint](./comparisons/cosmos.md)는 밸리데이터 세트의 선택 방법으로 PoS를 사용하는 PBFT(Practical Byzantine Fault Tolerant) 알고리즘입니다.

## 확정 가능성이 있는 블록의 확정성 대 입증된 블록의 확정성 (Probable vs. provable finality)

PoW를 수행하는 순수한 나카모토 컨센서스 블록 체인은 _확률적 Finality_ 의 개념을 세우고 _결과적으로 합의(consensus)_ 에 도달 할 수 있습니다. 확률적 Finality는 네트워크 와 참가자에 대한 몇몇 가정 하에서 만약 주어진 블록에 몇 개의 블록을 구축하는 것을 볼 수 있으면 블록의 Finaity에 대한 확률을 예측할 수 있다는 의미입니다. 최종 합의는 모든 노드가 한 세트의 데이터의 진실성에 대해서 미래의 어느 시점에 동의한다는 것을 의미합니다. 이 최종 합의는 오랜 시간이 걸릴 수 있으며 시간이 얼마나 걸릴지 미리 결정될 수 없습니다. 그러나 GRANDPA 또는 Ethereum의 Casper FFG와 같은 Finality 도구들은 블록의 Finality에 대해 강력하고 신속한 보장을 제공하도록 설계되었습니다. 특히 Byzantine agreement의 일부 프로세스가 완료된 후 되돌릴 수는 없습니다. 비가역적인(irreversible) 합의의 개념은 _확정 가능한 finality_ 로 알려져 있습니다 .

GRANPA문서에서는 다음과 같이 설명되어 있습니다.

> 프로토콜의 오라클 A가 어느 지정되지 않은 시간 후에 모든 참여자들에게 같은 값을 반환한다면 _결과적으로 일관됨(eventually consistent)_ 이라고 합니다.

## GRANDPA/BABE가 무엇인가요?

### 하이브리드 컨센서스 (Hybrid Consensus)

Polkadot의 합의 프로토콜에 관해 이야기 할 때 사용하는 GRANDPA 와 BABE 라는 두 가지 약어가 있습니다. Polkadot은 **하이브리드 컨센서스**를 사용하기 때문에 두 가지 약어에 대해 이야기합니다. 하이브리드 컨센서스는 블록 생성 메커니즘에서 finality 도구를 분리합니다. 이를 통해 블록 생성 속도를 높이고 느린 finality 메커니즘을 별도의 프로세스에서 실행하여 느린 트랜잭션 처리에 대한 우려앖이 블록을 확정(finalize) 할 수 있습니다.

이전에 하이브리드 컨센서스가 제안 되었습니다. 주목할만한 것은, 지금은 없지만 Ethereum의 전환 단계로 [EIP 1011](http://eips.ethereum.org/EIPS/eip-1011)에서의 지분 증명(Proof of stake)를 구체화한 [Casper FFG](#casper-ffg)으로 제시 되었습니다.

### GRANDPA: Finality 도구

GRANDPA (GHOST-based Recursive ANcestor Deriving Prefix Agreement)는 Polkadot relay chain을 위해 구현된 Finality 도구입니다.

노드의 2/3이 네트워크에 대해 정직하고 20%(1/5)의 비잔틴 노드를 비동기 세팅에서 대처 할 수있는 부분 동기식 네트워크 모델(partially synchronous network model)에서 작동합니다.
눈에 띄는 차이점은 GRANDPA가 블록이 아닌 체인에 대한 합의에 도달한다는 것입니다.

GRANDPA에 대한 자세한 내용은 W3F Research 페이지의 [GRANDPA 링크](http://research.web3.foundation/en/latest/polkadot/GRANDPA/)를 참조하세요.

### "Polite" GRANDPA

Polite GRANDPA는 노드 간의 네트워크 성능을 향상시키는 구현 방법입니다. 이것은 스펙의 일부로 고려되어야만 하고 클라이언트를 구축하는 독립적인 팀에 의해 복제되어야하기 때문에 여기에 언급됩니다.

### BABE: 블록 생성 도구

BABE (Blind Assignment for Blockchain Extension)는 밸리데이터 노드 사이에서 간에 실행되고 새 블록의 생성자를 결정하는 블록 생성 메커니즘입니다.

BABE는 스테이킹과 폴카닷을 사용해서 [무작위 사이클](./randomness.md)를 사용하여 밸리데이터들에게 블록 생성 슬롯을 할당합니다.

BABE는 Ouroboros Praos의 알고리즘과 비슷하지만 체인 선택규칙(chain selection rule)과 슬롯 시간조정(slot time adjustments)에서 주요 차이점이 있습니다.

BABE에 대한 자세한 내용은 [초안](http://research.web3.foundation/en/latest/polkadot/BABE/Babe/)을 참조하세요.

## 다른 컨센서스 알고리즘과 비교 (Comparisons)

### 나카모토 컨센서스 (Nakamoto consensus)

나카모토 컨센서스는 작업 증명 (Proof of Work)을 사용하는 Longest chain rule로 이루어져 있습니다. 작업 증명은 시빌 저항 매커니즘과 (sybil resistance mechanism)와 리더 뽑기 (leader election)에 쓰입니다.

나카모토 컨센서스는 확률적인 finality만 줍니다. 과거의 블록을 되돌릴 수 없다는 것에 대해서 보장 하는것은 확률적인 finality의 속성에 의존합니다. 과거의 블록이 가지고있는 확인(confirmation)수 나 그 위에 있는 블록 수만큼 확률적인 finality 상태가 안전하다고 합니다. Proof of Work 체인에서 더 많은 블록이 특정 블록 위에 쌓일수록 특정 체인 뒤에 계산 작업이 더 많이 소비됩니다. 그러나 잠재적으로 경쟁 체인을 구축하고 특정 블록을 포함하지 않는 체인을 생성 할 수있는 무제한 리소스를 가진 액터가 충분한 계산 리소스를 소비 할 수 있기 때문에 블록을 포함하는 체인이 항상 합의 된 체인이 된다는 것을 보장하지는 않습니다. 이러한 Longest chain규칙을 Bitcoin 및 기타 작업 증명 체인에서 사용하고 가장 긴 새로운 체인이 표준 체인이 됩니다..

### PBFT / Tendermint

이와 관련해서는 [코스모스와의 비교 문서](./comparisons/cosmos.md#consensus)를 참고하세요

<!-- ### HoneyBadgerBFT -->

### Casper FFG

GRANDPA and Casper FFG (Friendly Finality Gadget)는 다음과 같이 두가지 차이점이 있습니다.:

 - GRANPA에서는 다른 투표자들이 다른 높이에 있는 블록에 동시에 투표를 할 수 있습니다.
 - GRANDPA 는 기본적인 블록 생성 매커니즘의 포크 선택룰에 영향을 주는 확정된 블록에서만 영향을 받습니다.

### Casper CBC

_Coming soon!_

<!-- ### Avalanche -->

## 왜 PoW를 쓰지 않나요?

분산된 합의를 만드는 것에는 효과적이지만 PoW는 엄청난 에너지를 쓰고 경제적인 Finality가 없고 카르텔에 저항하는 효과적인 전략이 없습니다.

## 참고자료 (Resources)

- [GRANDPA paper](https://github.com/w3f/consensus/blob/master/pdf/grandpa.pdf) - GRANDPA finality 도구의 학술적인 설명문서. 알고리즘의 형식 증명이 표함되어 있습니다.
- [Rust implementation](https://github.com/paritytech/finality-grandpa) - 참고 구현체와 [Substrate runtime module](https://github.com/paritytech/substrate/blob/master/srml/grandpa/src/lib.rs).

<!-- ## Consensus in Polkadot

### Block Production

### Finality Gadget

### NPoS -->
