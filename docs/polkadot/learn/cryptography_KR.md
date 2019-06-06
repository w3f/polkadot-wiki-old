# Polkadot 에서 사용하는 암호학 설명 (Cryptography Explainer)

이 문서는 Polkadot에서 사용되는 암호화에 대한 고수준의 개요에 대해서 설명합니다. 일반적으로 블록체인에서 사용하는 해시(hash), ECC(Elliptic Curve Cryptography) 및 공개키 - 비밀키 쌍과 같은 기초 암호화 지식이 있다고 가정합니다.

[research wiki](https://research.web3.foundation)에서 암호화에 대한 자세한 설명을 볼 수 있습니다.

## 해싱 알고리즘 (Hashing Algorithm)

Polkadot에서 사용되는 해싱 알고리즘은 [Blake2b](https://en.wikipedia.org/wiki/BLAKE_(hash_function)#BLAKE2)입니다.

Blake2는 [Zcash](https://z.cash)에서도 사용하는 매우 빠른 암호 해시함수 입니다.

## 키페어와 서명 (Keypairs and Signing)

Polkadot은 Schnorrkel/Ristretto x25519("sr25519")를 키 유도 및 서명 알고리즘으로 사용합니다.

Sr25519는 EdDSA에 대응되는 [Ed25519](https://en.wikipedia.org/wiki/EdDSA#Ed25519) 와 같은 기반인 [Curve25519](https://en.wikipedia.org/wiki/Curve25519)을 사용합니다. 그러나 EdDSA 스킴(Scheme) 대신 Schnorr 서명을 사용합니다. Schnorr 서명은 ECDSA/EdDSA 체계에 보다 더 좋은 이점을 제공합니다. 그 중 하나는 더 효율적이며 동일한 기능 셋과 보안 가정을 ​​가지고 있다는 것입니다. 또한 [서명 통합(Signature aggregation)](https://bitcoincore.org/en/2017/03/23/schnorr-signature-aggregation/)를 통해 schnorr 서명이 기본적으로 가지고 있는 다자간 서명(multisignature)을 허용합니다.

The names Schnorrkel and Ristretto come from the two Rust libraries that implement this
scheme, the [Schnorrkel](https://github.com/w3f/schnorrkel) library for Schnorr signatures and the [Ristretto](https://ristretto.group/ristretto.html)
library that makes it possible to use cofactor-8 curves like the Curve25519.

Schnorrkel과 Ristretto라는 이름은 Schnorr서명을 위한 [Schnorrkel](https://github.com/w3f/schnorrkel) Rust 라이브러리와 Curve25519와 같이 cofactor-8 커브를 사용할 수 있게 하는 [Ristretto](https://ristretto.group/ristretto.html) Rust 라이브러리에서 그 이름이 유래했습니다.