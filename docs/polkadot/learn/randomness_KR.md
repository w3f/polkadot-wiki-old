# 무작위성 (Randomness)

## 입증가능한 무작위 함수 (Verified Random Functions,VRFs)

BABE는 Polkadot의 무작위 사이클을 사용하여 지분(stake)에 따라 밸리데이터에 블록 생성 슬롯을 할당합니다.

Polkadot에 사용 된 VRF는 Ouroboros Praos에서 사용 된 것과 거의 같습니다. Ouroboros의 무작위성은 블록 생성을 안전하게 만들고 BABE에서 잘 작동합니다. 그러나 Polkadot은 공격자가 무작위성과 밸리데이터 - 패러체인을 선택히는 것을 조작할 수 있기 때문에 강한 무작위 소스를 필요로합니다.

더 강한 임의성을 위해 고려된 해결책이 있지만 각 각의 취약점이 있습니다 (전체 설명을 위해서 Research 위키에 있는 [링크](http://research.web3.foundation/en/latest/polkadot/BABE/3-VDF/#unbiased-randomness)를 참조하세요. ) 이러한 이유로 Polkadot은 VDF를 기반으로 임의성을 사용합니다.

## 입증가능한 지연 함수 (Verified Delay Function, VDFs)

[VDF(Verifiable Delay Functions)](https://vdfresearch.org/)는 병렬 컴퓨터일지라도 계산을 완료하기 위해 걸리는 시간을 규정한 함수입니다. 일반적인 세팅에서 독립적이고 효율적으로 확인할 수있는 고유한 출력값을 만듭니다.

## 블록체인의 무작위성에 대한 다른 접근 방법들 (Other approaches to randomness on blockchains)

- [RANDAO] (https://github.com/randao/randao) - RANDAO는 각 밸리데이터가 어떤 시드에서 몇몇 연속된 해시를 계산하여 준비하는 것과 관련이 있습니다. 그러면 밸리데이터는 라운드 동안 게임에 참여한 모든 참가자에게서 유도한 최종 해시를 보여줍니다. 비 경제적으로 공격 가능하나 정직한 밸리데이터가가 참여하는 한 임의성은 안전하다고 간주됩니다. 이 방법은 Polkadot에서 사용하는 VRF에 대한 임의성 방법으로 선택되지 않았습니다. 왜냐하면 각 슬롯의 모든 블록 생성자의 해시를 나타내려면 2차 지수 방정식 만큼의 대역폭 또는 적어도 2차 지수 방정식의 계산이 필요하기 때문입니다.

## 자료들 (Resources)

- [Polkadot에서 사용하는 무작위성에 대한 토론](https://github.com/paritytech/ink/issues/57) - Polkadot의 무작위성이 어떤 가정들에서 언제 사용가능한지에 대한 W3F 리서처 들의 토론.
