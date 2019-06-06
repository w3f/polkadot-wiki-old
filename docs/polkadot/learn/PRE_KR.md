# Polkadot 런티임 환경 (Polkadot Runtime Environment,PRE)

Polkadot 런타임 환경 (Polkadot Runtime Environment, 이하 PRE- 역자 주)는 Polkadot 프로토콜의 중요한구성 요소입니다. 네트워킹, 합의 및 Wasm VM으로 구성되며 Polkadot 런타임 및 패러체인들의 런타임을 기본으로하는 스택의 하위 계층으로 작동합니다. 아래에서 언급했듯이 체인 로직과 PRE 사이에는 명확한 구분이 있지만 대략 PRE는 Polkadot 릴레이 체인과 같은 의미로 생각할 수 있습니다 .

PRE의 구성요소는 다음과 같습니다.

- 네트워크 인터렉션 (Network Interactions)
- 상태(State) 저장소와 저장소 트라이 (Trie)
- 합의 엔진 (Consensus Engine)
- Wasm 가상 머신 (Virtual Machine ,VM)

체인로직을 구현하는 코드로 정의된 런타임은 PRE와 같이 동작하지 않습니다. 런타임과 PRE, 이 두 구성 요소를 분리하면 PRE를 업그레이드 할 필요없이 런타임을 쉽게 업그레이드 할 수 있습니다.

Polkadot 런타임과 parachains의 런타임은 컴파일 된 WebAssembly(Wasm)blob 이어야 합니다. Polkadot 런타임은 Polkadot RE에 "플러그인"되며 거버넌스 메커니즘을 통해 바꿀 수 있습니다.

아래 이미지는 Gavin Wood가 Substrate의 [slide deck](https://slides.com/paritytech/paritysubstrate#/8)에서 가져온 것으로 Polkadot 스택의 4개 레이어를 시각적으로 보여줍니다.

![PRE](../../img/PRE.png)

## 자료들 (Resources)

- [PRE 런타임 프로토콜 스펙(Polkadot Runtime Environment Protocol Specification)](https://github.com/w3f/polkadot-re-spec) - PRE spec의 인큐베이터.
- [polkadot-re-tests](https://github.com/w3f/polkadot-re-tests) - PRE를 위한 교차 규현 테스트 (Cross-implementation tests for the Polkadot Runtime Environment).
