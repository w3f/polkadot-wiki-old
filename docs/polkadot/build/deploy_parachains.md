# How to view and deploy parachains

The guide has been updated to work with the Alexander testnet.

## How to view parachains

On the [Polkadot UI](https://polkadot.js.org/apps/#/explorer) navigate to the `Chain State` tab. Select the `parachains` module and the `parachains()` then hit the `+` button. It will return an array of the currently active parachains.

## How to deploy

**You will need to have the minimum deposit needed to create a referendum. Currently this minimum is 5 DOTs.**

The first step is to download locally the Polkadot code.

```bash
git clone https://github.com/paritytech/polkadot.git
```

Now make sure you have Rust installed.

```bash
curl https://sh.rustup.rs -sSf | sh
sudo apt install make clang pkg-config libssl-dev
rustup update
```

Now navigate to the `test-parachains` folder in the Polkadot code repository and run the build script.

```bash
cd polkadot/test-parachains
./build.sh
```

This will create the WASM executable of the simple `adder` parachain contained in this folder. This parachain will simply add messages that are sent to it. The WASM executable will output into the `parachains/test/res/adder.wasm` path so make sure you are able to find it there.

You will need to build and run the collator node in order to get the genesis state of this parachain.

Navigate to the `test-parachains/adder/collator` directory and run the `build` and `run` commands.

```bash
cargo build
cargo run
[ctrl-c]
```

Feel free to stop the collator node right away. You will get some output that looks like this:

```
Starting adder collator with genesis:
Dec: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 27, 77, 3, 221, 140, 1, 241, 4, 145, 67,
207, 156, 76, 129, 126, 75, 22, 127, 29, 27, 131, 229, 198, 240, 241, 13, 137, 186, 30, 123, 206]
Hex: 0x00000000000000000000000000000000000000000000000000000000000000000000000000000000011b4d03dd8c01f1049143cf9c4c817e4b167f1d1b83e5c6f0f10d89ba1e7bce
```

The important information is the hex string. This is your genesis state and you will need to save it for the next steps.

