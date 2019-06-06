# Polkadot 구현체들 (Implementations)

Rust, C++, Go, JavaScript로 개발중인 Polkadot 구현체들이 아래와 같이 있습니다.

[**Polkadot**](https://github.com/paritytech/polkadot) - Parity Technologies 에서 개발중인 [Substrate](https://github.com/paritytech/substrate)와 협력해서 구현중인 Rust client.

[**Kagome**](https://github.com/soramitsu/kagome) -[Soramitsu](https://github.com/soramitsu)가 C++로 개발중인 Polkadot 런타임 환경(Polkadot Runtime Enviroment), [Soramitsu](https://github.com/soramitsu)는 일본 디지털 신원 개발사로서 이전에 [Hyperledger Iroha](https://iroha.tech)를 개발 했습니다. They were awarded a grant from the Web3재단에서 개발 지원금을 받았고 Kagome를 [2019년 8월까지 릴리즈](https://medium.com/web3foundation/w3f-grants-soramitsu-to-implement-polkadot-runtime-environment-in-c-cf3baa08cbe6) 할 계획입니다. libp2p 네트워킹 레이어를 C++로 개발중입니다.
[**Gossamer**](https://github.com/ChainSafeSystems/gossamer) - A Go implementation being built by [ChainSafe Systems](https://github.com/ChainSafeSystems)가 개발중인 Golang 구현체, 토론토에 23명의 개발팀이 있으며 Eth2.0 Serenity client도 개발중입니다. [개발지원금에 대한 발표](https://medium.com/web3foundation/w3f-grants-chainsafe-to-implement-polkadot-runtime-environment-in-go-ca4973c9edaf).

<img src="../../../img/updated_pre.png" alt="polkadot runtime environment" class="polka-re"/>

[**Golkadot**](https://github.com/opennetsys/golkadot) - Open Network Systems가 개발중인  Polkadot Substrate Golang 구현체

[**Polkadot-JS**](https://github.com/polkadot-js) - [Polkadot JS](https://polkadot.js.org/)가 개발한 [자바스크립트 클라이언트 (Javascript client](https://github.com/polkadot-js/client) 와 툴 모음들.

## 왜 중복된 구현체를 만드나요?

Soramitsu의 개발 지원금 발표 중에서 :

> 분산화, 지식 확산 및 프로토콜의 더 나은 정의를 비롯한 여러 가지 이유로 Polkadot 프로토콜을 여러 번 구현하는 것은 매우 중요합니다. Polkadot의 여러 구현은 네트워크의 회복력을 좀 더 낫게 하고 네트워크의 분산화를 촉진시킵니다. 네트워크에서 노드를 실행하는 클라이언트를 여러 팀이 만든다면 네트워크 관리가 더욱 민주화됩니다.