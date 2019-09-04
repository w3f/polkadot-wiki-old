# 如何查看和部署平行链

指南已经更新，配合Alexander测试网使用。

## 如何查看平行链

在[Polkadot UI](https://polkadot.js.org/apps/#/explorer)找到`Chain State`选项卡，选择`parachains`模块以及`parachains()`，然后按`+`键，即可查看到一组当前活跃的平行链数组。

## 如何部署Adder平行链

**您需要拥有创建公投所需的最低存款。目前为5个DOT。**

`adder`平行链是一种简单平行链，它将保存价值，并在有信息传入时将信息添加至以上价值。您可以在`“test-parachains”`文件夹下的polkadot存储库中找到它。

> [这里](https://www.youtube.com/watch?v=pDqkzvA4C0E)有一个由Adrian Brink提供的视频指南，不过现在稍微有点过时。如果文字指南和视频指南内容有分歧，请以文字指南为准。

### 创建代码

第一步是在本地下载 Polkadot代码4.0版本。

```bash
git clone https://github.com/paritytech/polkadot.git
```

确保您已经安装了Rust。

```bash
curl https://sh.rustup.rs -sSf | sh
sudo apt install make clang pkg-config libssl-dev
rustup update
```

然后找到Polkadot代码存储库中的`test-parachains`文件夹，运行创建脚本。

```bash
cd test-parachains
./build.sh
```

这会为该文件夹中包含的简单`adder`平行链创建Wasm可执行文件。该平行链将添加发送到它的信息。Wasm可执行文件将输出到`parachains/test/res/adder.wasm`路径，请确保您能在该路径下找到它。

您需要创建和运行校对人节点，以此获取该平行链的起始状态。

找到`test-parachains/adder/collator`路径并且运行`build`和`run`指令。

```bash
cargo build
cargo run
[ctrl-c]
```

您可以马上停止校对器节点。您将获得如下输出结果：

```
Starting adder collator with genesis:
Dec: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 27, 77, 3, 221, 140, 1, 241, 4, 145, 67,
207, 156, 76, 129, 126, 75, 22, 127, 29, 27, 131, 229, 198, 240, 241, 13, 137, 186, 30, 123, 206]
Hex: 0x00000000000000000000000000000000000000000000000000000000000000000000000000000000011b4d03dd8c01f1049143cf9c4c817e4b167f1d1b83e5c6f0f10d89ba1e7bce
```

hex字符串（十六进制字符串）是重要信息。这是您平行链的初始状态，您需要将它保存下来，下一步中要用到。

### 部署平行链

找到`Extrinsic`标签页的[Polkadot UI](https://polkadot.js.org/apps/#/extrinsics)。选择您想要用来部署平行链的账户。要部署平行链，您需要创建一场全民公投。

点击`democracy` -> `propose(proposal,value)` -> `parachains` -> `registerParachain(id,code,initial_head_data)`。

在`“id”`的位置输入平行链ID。如果是简单adder平行链的话，就输入`100`。在`code`的位置点击页面按钮，然后上传之前编译的`adder.wasm`二进制文件。在`initial head data`位置，将通过校对人节点时获取的十六进制数据复制粘贴进去。在`value`位置，您需要输入创建一场全民公投所需的最低保证金数值。撰文之时，在Alexander测试网上，这个数值是5个DOT。

![注册平行链](../../img/parachain/register.png)

如果您导航到`“Democracy”`选项卡的话，您可以在提议部分看到自己的提议。

在等待提议通过的过程中，您可以对提议投`反对`或者`赞成`票。当然，因为此次投票是要为您自己部署平行链，所以您会投赞成票。

![平行链公投](../../img/parachain/referendum.png)

在全民公投投票期结束后，您可以请求查看您的平行链的状态。

您可以到`Chain State`选项卡，通过请求查看`parachains`状态，您能够看到平行链上的一些信息。

![平行链信息](../../img/parachain/info.png)

### 与平行链交互

*敬请期待！*