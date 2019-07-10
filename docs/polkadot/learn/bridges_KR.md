# Bridges

블록체인 간 통신의 핵심 아이디어 중 하나는 브릿지 역할입니다. Polkadot에서 브릿징(Bridging)이 어떻게 작동하는지에 대한 정확한 세부 사항 중 일부는 아직 결정되지 않았습니다. 이 페이지는 현재 작업진행중(work in progress)입니다.  . 더 많은 세부 사항이 결정되면 업데이트 될 것입니다.

현재 Polkadot 에서는 아래오 같은 세가지 다른 종류의 브릿징(bridging)이 있습니다.

* _브릿지 컨트랙트_(_Bridge contracts_) -Polkadot과 외부 블록체인 간 브릿지로 배포된 스마트 컨트랙트.

* _크로스-패러체인 통신_(_Cross-parachain communication_) - 컨트랙트가 필요 없음.

* _내장된 브릿징 모듈_(_In-built bridging modules_) - 전용 모듈을 통해 외부 체인에서 Polkadot에 브릿징.

## 브릿지 컨트랙트(Bridge Contracts)

Ethereum 에 이미 익숙한 사람들은 [Parity Bridge](https://github.com/paritytech/parity-bridge) 및 PoA 사이드체인을 Ethereum 메인넷에 연결하기 위한 노력에 대해 알고있을 수 있습니다. 브릿지는 두 가지 스마트 계약의 조합으로, 각 체인에 배포되어 크로스-체인 가치 전송을 허용합니다. 예를 들어, 초기 패리티 브리지 (Parity Bridge) PoC(proof of concept)는 `main`과 `side` 두 개의 이더리움 체인 을 연결합니다.  `main`의 컨트랙트에 이더를 입금하면 `side`에 ERC-20 토큰으로 표시되어 잔고가 생성됩니다. 반대로 `side`에사 ERC-20 토큰이 컨트랙트로 다시 입금되면 `main`에서 (입금되어서 잠긴) 이더를 해제 할 수 있습니다.

Polkadot의 경우, 말하자면 EVM 기반 독립(standalone) 체인과 스마트 컨트랙트가 가능한 패러체인(Parachain)에 배포된 컨트랙트에 브리지 컨트랙트를 배포 할 수 있어야 합니다. 이것은 반드시 가장 효율적인 브리징 방법은 아닐수도 있지만, Turing-완전한 패러체인의 대부분을 고려할 때 Polkadot 과 어떤 다른 스마트 컨트랙트 블록체인을 브릿지 할 수 있습니다.

### 참고 자료들 (Resources)

* [Edgeth Bridge](https://github.com/hicommonwealth/edgeth_bridge/) - Ethereum에서  Edgeware로 브릿지한 서브스트레이트 기반 체인.
* [Parity Bridge](https://github.com/paritytech/parity-bridge)
* [POA Network](https://poa.network/)
* [Case study](https://medium.com/giveth/ethereum-dapp-scaling-poa-network-acee8a51e772) 패리티 사의 브릿지 체인 솔루션인 POA 네트워크 구현체

## 크로스 패러체인 커뮤니케이션 (Cross-Parachain Communication)

[parachains](./parachains.md) 페이지에서 언급했듯이, 패러체인은 트랜잭션을 포함해서 서로 메시지를 보낼 수 있습니다 그러므로 브리징 기능을 작동시키기 위한 스마트 컨트랙트가 필요 없습니다. 크로스-체인(Cross-parachain) 메시징(messaging)은 Polkadot에서 기본(native)으로 제공됩니다.

## 내장 브릿지 모듈 (In-built Bridging Modules)

패러체인이 패러체인이 아닌 블록체인에서 메시지를 받는것은 클라이언트 소프트웨어의 모듈 내에서 기본적으로 작동될것입니다. 이것은 브리징 계약을 불필요하게 마들고 패러체인이 아닌 블록체인을 "가상 패러체인(virtual parachains)"인 것처럼 작동 할 수있게 합니다. 특정 블록체인 콜레이터(collator,병합기)는 트랜잭션이나 다른 상태전이를 대조하여 블록체인이 마치 패러체인인 것처럼 릴레이 체인(relay chain)에 보낼 수 있습니다.

비트코인이나 이더리움 처럼 특정 패러체인을 염두에 두고 브릿지 모듈이 구현 될 것입니다. 즉, 어떤 블록체인이든 저 특정 블록체인을 기반으로 한다면 패러체인에 브릿징 컨트랙트를 통할 필요없이 Polkadot에 직접 브리지 할 수 있어야합니다.이런 점은 호환가능한 체인들의 실행 속도를 빠르게 합니다.

Polkadot에 내장 브리징 모듈이 없는 독립형 체인의 경우 브리지 계약을 배포해야합니다 (위 참조).

### 참고자료 (Resources)

* [ChainX BTC Bridge](https://github.com/chainx-org/ChainX/tree/develop/cxrml/bridge/btc) - ChainX have implemented a BTC to Substrate bridge for their parachain