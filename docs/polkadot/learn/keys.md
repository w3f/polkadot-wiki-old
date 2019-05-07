# Polkadot Keys

Public and private keys are an important aspect of most cryptosystems and an essential component that enables blockchains like Polkadot to exist.

## Account keys

Account keys can be either:

- The vanilla implementation `ed25519` using Schnorr signatures.
- The Schnorrkel/Ristretto variant `sr25519` using Schnorr signatures.

For reasons outlined above, the `sr25519` is superior for implementing complex protocols. As account keys only need to provide signature capabilities, it will likely be the case that the more common `ed25519` will continue to be supported in Polkadot. The ecosystem around `ed25519` is much larger as well, with things like HSMs available for it and other projects actively using it, while `sr25519` is a variant created especially to handle Polkadot use cases and is later on adoption. 

### "Controller" and "Stash" keys

When we talk about "controller" and "stash" keys we usually talk about them in context of running a validator or nominating DOTs, but they are useful concepts for all users to know. Both keys are types of account keys, and are distinguished by how they are intended to be used and not by an underlying cryptographic difference. All the info mentioned in the parent section applies to these keys and when creating new controller or stash keys, all cryptography supported by account keys are an available option.

The controller key is semi-online key which will be in the direct control of a user, and used to submit manual extrinsics. For validators or nominators this means that the controller key will be used to start or stop validating or nominating. Controller keys should hold some DOTs to pay for fees but they should not be used to hold huge amounts or life savings. Since they will be exposed to the internet with relative frequency, they should be treated carefully and occasionally replaced by creation of new ones.

The stash key is a key which will in most cases be a cold wallet, existing on a piece of paper in a safe or protected by layers of hardware security. It should rarely, if ever, be exposed to the internet or used to submit extrinsics. The reason for this is that the stash key is intended to hold a great amount of funds. It should be thought of as a saving's account at a bank, which ideally is only ever touched in urgent conditions. Or, perhaps a more apt metaphor is to think of it as buried treasure, hidden on some random island and only known by the pirate who originally hid it. 

Since the stash key is kept offline, it must be set to have bonded its funds to a particular controller. The controller will be able to initiate the staking process using funds kept in the stash key, but it will never be able to actually move or claim the funds in the stash key. In this manner, if the controller key is ever compromised, the stash remains secure. It is designed to be resilient.

## Session key

The session keys are the hot keys which be must kept online by a validator in order to perform network operations such as signing consensus votes for GRANDPA, producing blocks with BABE, and identifying itself to other nodes over libp2p. For this reason, it is recommended to keep the session keys completely separate from your normal account keys, and to not use session keys to store any funds since they can be cycled through (maybe even automatically).

**Currently as implemented in Polkadot / Substrate, the session key is just a normal `ed25519` key and the following information has not been implemented. It is written here for educational purposes as a notice for what's to come.**

The "session key" is actually 3 keys and for this reason is sometimes better referred to as a @(session certificate). It introduces a new cryptographic method for deriving keys and creating signatures using @(BLS), which otherwise has not appeared in the protocol specification.

The 3 keys of the session certificate:

- A BLS key used for GRANDPA.
- An SR25519 key used for BABE.
- And; An Ed25519 key used for libp2p.

A BLS key is desirable for GRANDPA because it allows for signature aggregations in a much more efficient way than is possible using Schnorr signatures. BABE requires keys suitable for use in a [Verifiable Random Function](../randomness#vrfs) as well as for digital signatures. SR25519 keys have both capabilities and so are used for BABE. Finally, libp2p is implemented to work with the more common Ed25519 keys and so is required for that.

## FAQ

### Why was `ed25519` selected over `secp256k1`?

The original key derivation cryptography that was implemented for Polkadot and Substrate chains was `ed25519`, which is a Schnorr signature algorithm implemented over the Edward's Curve25519 (so named due to the parameters of the curve equation). 

Most cryptocurrencies including Bitcoin and Ethereum currently use ECDSA signatures on the secp256k1 curve. This curve is considered much more secure than NIST curves, which [have possible backdoors from the NSA](#appendix-a-on-the-security-of-curves). The Curve25519 is considered possibly _even more_ secure than this one and allows for easier implementation of Schnorr signatures. A recent patent expiration on it has made it the preferred choice for use in Polkadot. 

The choice of using Schnorr signatures over using ECDSA is not so cut as dry. As stated in Jeff Burdges' (a Web3 researcher) [original forum post](https://forum.web3.foundation/t/account-signatures-and-keys-in-polkadot/70/2) on the topic:

> There is one sacrifice we make by choosing Schnorr signatures over ECDSA signatures for account keys: Both require 64 bytes, but only ECDSA signatures communicate their public key. There are obsolete Schnorr variants that support recovering the public key from a signature, but they break important functionality like hierarchical deterministic key derivation. In consequence, Schnorr signatures often take an extra 32 bytes for the public key.

But ultimately the benefits of using Schnorr signatures outweigh the tradeoffs, and future optimizations may resolve the inefficiencies pointed out in the quote above.

### What is `sr25519` and where did it come from?

Some context: The Schnorr signatures over the Twisted Edward's Curve25519 are considered secure, however Ed25519 has not been completely devoid of its bugs. Most notably, [Monero and all other CryptoNote currencies](https://www.getmonero.org/2017/05/17/disclosure-of-a-major-bug-in-cryptonote-based-currencies.html) were vulnerable to a double spend exploit which could potentially lead to undetected infinite inflation. 

These exploits were due to one peculiarity in Ed25519 which is known as its cofactor of 8. The cofactor of a curve is an esoteric detail that could have dire consequences for the security of implementation of more complex protocols. 

Conveniently, [Mike Hamburg's Decaf paper](https://www.shiftleft.org/papers/decaf/index.xhtml) provides a possible path forward to solving this potential bug. Decaf is basically a way to take Twisted Edward's Curves cofactor and mathematical change it with little cost to performance and gains to security.

The Decaf paper approach by the [Ristretto Group](https://ristretto.group/) was extending and implemented in Rust to include cofactor-8 curves like the Curve25519 and makes Schnorr signatures over the Edward's curve more secure. 

The Web3 Foundation has implemented a Schnorr signature library using the more secure Ristretto compression over the Curve25519 in the [Schnorrkel](https://github.com/w3f/schnorrkel) repository. Schnorrkel implements related protocols on top of this curve compression such as HDKD, MuSig, and verifiable random function (VRF). It also includes various minor improvements such as the hashing scheme STROBE that can theoretically process huge amounts of data with only one call across the Wasm boundary.

The implementation of Schnorr signatures which is used in Polkadot and implements the Schnorrkel protocols over the Ristretto compression of the Curve25519 is known as **SR25519** or otherwise, Schnorrkel-Ristretto25519. 

### Are BLS keys used in Polkadot?

Yes. This is another type of signature algorithm which is currently still in development but will be in Polkadot and in use by validators. These are Boneh-Lynn-Shacham signatures which are commonly known as BLS.

As stated in the BLS library's README,

> Boneh-Lynn-Shacham (BLS) signatures have slow signing, very slow verification, require slow and much less secure pairing friendly curves, and tend towards dangerous malleability. Yet, BLS permits a diverse array of signature aggregation options far beyond any other known signature scheme, which makes BLS a preferred scheme for voting in consensus algorithms and for threshold signatures.

Even though Schnorr signatures allow for signature aggregation, BLS signatures are much more efficient in some fashions. For this reason it will be one of the session keys (aka the "session certificate") which are used by validators on the Polkadot network and critical to the GRANDPA finality gadget.

## Resources

- [Key discovery attack on BIP32-Ed25519](https://forum.web3.foundation/t/key-recovery-attack-on-bip32-ed25519/44) - Forum post detailing a potential attack on BIP32-Ed25519. A motivation for transition to the SR25519 variant. 
- [Account signatures and keys in Polkadot](https://forum.web3.foundation/t/account-signatures-and-keys-in-polkadot/70) - Original forum post by Web3 researcher Jeff Brudges.
- [Are Schnorr signatures quantum computer resistant?](https://bitcoin.stackexchange.com/a/57977l) - Some information on Schnorr signatures.

## Appendix A: On the security of curves

From the [introduction of Curve25519](https://git.libssh.org/projects/libssh.git/tree/doc/curve25519-sha256@libssh.org.txt#n10) into `libssl`:

```
The reason is the following : During summer of 2013, revelations from ex-
consultant at NSA Edward Snowden gave proof that NSA willingly inserts backdoors
into softwares, hardware components and published standards. While it is still
believed that the mathematics behind ECC cryptography are still sound and solid,
some people (including Bruce Schneier [SCHNEIER]), showed their lack of confidence
in NIST-published curves such as nistp256, nistp384, nistp521, for which constant
parameters (including the generator point) are defined without explanation. It
is also believed that NSA had a word to say in their definition. These curves
are not the most secure or fastest possible for their key sizes [DJB], and
researchers think it is possible that NSA have ways of cracking NIST curves.
It is also interesting to note that SSH belongs to the list of protocols the NSA
claims to be able to eavesdrop. Having a secure replacement would make passive
attacks much harder if such a backdoor exists.

However an alternative exists in the form of Curve25519. This algorithm has been
proposed in 2006 by DJB [Curve25519]. Its main strengths are its speed, its
constant-time run time (and resistance against side-channel attacks), and its
lack of nebulous hard-coded constants.
```
