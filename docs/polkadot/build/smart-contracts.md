# Smart Contracts

The Polkadot relay chain will not support smart contracts natively.  However, parachains on Polkadot will support smart contracts. There are already announced projects such as [Edgeware](https://edgewa.re), and thanks to the Substrate built-in [contract module](https://crates.parity.io/srml_contract/index.html), it is likely that more parachains will support this feature.

Polkadot 릴레이 체인은 스마트 계약을 기본적으로 지원하지 않습니다. 그러나 Polkadot의 낙하산은 현명한 계약을 지원합니다. 이미 [Edgeware]와 같은 기탁 된 프로젝트와 기판 내장 [계약 모듈] 덕분에 더 많은 낙하산이이 기능을 지원할 가능성이 있습니다.

## Resources

Here are the list of current resources available to developer who want to get started writing smart contracts to deploy on parachains based on Substrate.

Substrate 기반의 낙하산에 전개 할 스마트 계약서 작성을 시작하려는 개발자가 현재 사용할 수있는 자원 목록입니다.

- [ink!](https://github.com/paritytech/ink) - Parity's ink to write smart contracts. 
- [Deploying your first contract](https://github.com/paritytech/ink/wiki/Deploying-Your-First-Contract) - Guide to deploy the provided `flipper` contract.
- [Writing your first contract](https://github.com/paritytech/ink/wiki/Writing-Your-First-Contract) - Guide to how one would write the `flipper` contract.
- [Substrate contracts workshop](https://shawntabrizi.github.io/substrate-contracts-workshop/#/) - Walks you through the basics of using `ink!` and writing an ERC20 token.

## Examples

Collected below are some community examples of smart contracts in `ink!`. Are you working on a smart contract example? Ask us to add it to this page!

아래에 수집 된 것은 스마트 계약의 커뮤니티 예제입니다. 똑똑한 계약의 예를 다루고 있습니까? 이 페이지에 추가하도록 요청하십시오!

- [Ownable](https://github.com/JesseAbram/foRust/) - Port of the OpenZeppelin `Ownable` contract.

## What is the difference between developing a smart contract versus a parachain?

### Layer of Abstraction

When you write a smart contract you are creating the instructions which will be deployed and associated to a specific chain address.

현명한 계약서를 작성할 때 특정 체인 주소에 배포되고 연관 될 지침을 작성합니다.


In comparison, a runtime module is the entire logic of a chain's state transitions (what's called a state transition function).

비교해 보면, 런타임 모듈은 체인의 상태 전이 논리 (상태 전이 함수라고하는)의 전체 논리입니다.

Smart contracts must consciously implement upgradeability while parachains will have the ability to swap out their code entirely through a root command or via the governance module.

현명한 계약은 업그레이드 가능성을 의식적으로 구현해야하며 parachains는 루트 명령이나 관리 모듈을 통해 코드를 완전히 교체 할 수 있어야합니다

When you build a smart contract, it will be eventually be deployed to a target chain with its own environment. Parachains allow the developer to declare the environment of their own chain, even allowing others to write smart contracts for it.

현명한 계약을 맺으면 결국 자체 환경이있는 대상 체인에 배포됩니다. Parachains를 사용하면 개발자가 자신의 체인 환경을 선언 할 수 있으며 다른 사람들이 스마트 계약을 작성할 수 있습니다.

### Gas Fees

Smart contracts must find a way to limit their own execution, or else full nodes are vulnerable to DOS attacks. An infinite loop in a smart contract, for example, could consume the computational resources of an entire chain, preventing others from using it. The [halting problem](https://en.wikipedia.org/wiki/Halting_problem) shows that with a powerful enough language, it is impossible to know ahead of time whether or not a program will ever cease execution.  Some platforms, such as Bitcoin, get around this constraint by providing a very restricted scripting language.  Others, such as Ethereum, "charge" the smart contract "gas" for the rights to execute their code.  If a smart contract does get into a state where execution will never halt, it eventually runs out of gas, ceases execution, and any state transition that would have been made by the smart contract is rolled back.

스마트 계약은 자체 실행을 제한하는 방법을 찾아야합니다. 그렇지 않으면 전체 노드가 DOS 공격에 취약합니다. 예를 들어 똑똑한 계약의 무한 루프는 체인 전체의 계산 자원을 소비하여 다른 사람이 사용하지 못하도록 할 수 있습니다. [중단 문제]는 강력한 강력한 언어를 사용하면 프로그램 실행을 중단할지 여부를 미리 알 수 없습니다. Bitcoin과 같은 일부 플랫폼은 매우 제한된 스크립팅 언어를 제공함으로써 이러한 제약을 극복합니다. 에테 리엄 (Ethereum)과 같은 다른 사람들은 자신의 코드를 실행할 수있는 권리를 "똑똑히"청구한다. 똑똑한 계약이 실행이 중단되지 않는 상태가되면 결국에는 가스가 없어져 실행이 중단되고 스마트 계약에 의한 상태 전환이 롤백됩니다.

Parachains can implement arbitrarily powerful programming languages and also contain no notion of gas for their own native logic. This means that some functionality is easier to implement for the developer, but it also means there are some constructs, such as a loop without a terminating condition, which should _never_ be implemented.  Leaving certain logic, such as complex loops which could possibly run indefinitely, to a non-smart contract layer, or even trying to eliminate it entirely, will often be a wiser choice.
Parachains는 임의로 강력한 프로그래밍 언어를 구현할 수 있으며 자체 고유 논리에 대한 가스 개념을 포함하지 않습니다. 이것은 일부 기능을 개발자가 쉽게 구현할 수 있음을 의미하지만, 구현하지 않아야하는 종료 조건이없는 루프와 같은 일부 구성이 있음을 의미합니다. 무한히 실행될 수있는 복잡한 루프와 같은 특정 논리를 비 스마트 계약 계층에 남겨 두거나 심지어 완전히 제거하려는 경우 현명한 선택이 될 수 있습니다.

## Resources

- [When should I build a Substrate runtime versus a Substrate smart contract](https://stackoverflow.com/a/56041305) - From a technical standpoint answers the question of when a developer might choose to develop a runtime versus a smart contract.
