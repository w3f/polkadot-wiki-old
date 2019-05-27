# 如何成为验证人

!!! info
    _这个教程将更新到最新测试网_

想成为一个好验证人，你需要留意以下几点:

- 拥有DOTs作抵押(基本要求）
- 确保节点运行最新版本
- 拥有网络保安知识
- 使用HSM保护私钥(推荐）

如果你有DOT但是没有足够技术知识，你最好也不要当验证人，反而提议把你的DOTs提名到其它你信任的验证人身上去帮你做这个工作。

你仍然能成为提名人提名多个验证人从而获得奖励。你可以在[这裹](../../../../../polkadot/node/nominator/)了解更多关于提名人的操作。

这个教程我们使用Ubuntu 18.04并将在PoC-4测试网运行，不论你使用那个系统，大部份设定也不会有太大区别。另外这里有些[VPS服务器](#vps)给大家选择。

!!! attention
    _请大家确保不要在主网上使用以下设定。
    这个教程将会一步一步教大家如何设定验证人节点，如果你想在主网上线后当验证人，你必须对私钥管理、抵抗DDOS和高可用性(High Availability)有一定了解。_

## 安裝Rust

```bash
curl https://sh.rustup.rs -sSf | sh
sudo apt install make clang pkg-config libssl-dev
```
以上指令将会下载最新Rust版本并安装，第二个指令是安装其它所需要的程序。

```bash
rustup update
```
假如你经已安装好Rust，执行以上指令检查一下是否有新版本。

## 安装`Polkadot` PoC-4

在没有一键安装PoC-4之前，你需要从源代码编译Polkadot。
```bash
git clone https://github.com/paritytech/polkadot.git
# 如果你是更新节点，可以从这一步开始。
cd polkadot
cargo clean
git checkout v0.4
git pull origin v0.4
./scripts/init.sh
./scripts/build.sh
cargo install --path ./ --force
```
编译需要一段时间，具体取决于你的硬件。

## 同步链数据

```bash
polkadot --chain alex
```

同步将会需要数小时。
你可以通过[Telemetry](https://telemetry.polkadot.io/#/Alexander)或[PolkadotJS区块浏览器](https://polkadot.js.org/apps/#/explorer)查看最新区块。

## 创建帐号

第一件事你需要做的是新增三个不同帐号来管理资金和操作这个验证人:

- Stash
- Controller
- Session (必须是 ed25519)

请看[这裹](../../../../polkadot/learn/keys.md)如果你想了解更多关于以上三个分别和为什么需要它们。

![create account](../../../../img/validator/polkadot-dashboard-create-account.jpg)

在PolkadotJS区块浏览器选择`Accounts`，再按下`Create account`。

为了简单容易识别帐号起见，见议大家把`Stash`、`Controller`和`Session`名为(`1337_Stash`, `1337_Controller`, `1337_Session`)。

Stash和Controller帐号可以使用预设的`sr25519`加密算法，但是當创建**Session**密钥時，你必须在`Advanced creation options`选择`ed25519`加密算法作为`Key pair crypto type`。另外确保你选择`Raw Seed`并储存在本地某个地方，因为当你运行验证人时，那个指令需要使用到它。

每个帐号，输入密码加密种子(Seed)并按下`Save`。

![backup seed](../../../../img/validator/polkadot-dashboard-backup-seed.jpg)

接下来选择*Create and backup account*储存你的密匙为JSON格式。连同密码一起，这是能够恢复帐户的方法。

重复以上步骤创建其它帐号之后，你应该看到三个全新帐号。

## 获取测试币

接下来`Stash`和`Controller`帐号也需要有测试币才能提交交易和参与抵押。而`Session`帐号不需要有DOTs及不建议发送任何币到`Session`，而`Stash`和`Controller`需要有最少100 mDOTs（即0.1 DOTs）的最低金额，多些DOTs允许作交易费用。

现在有二个方法你可以获取测试币。

- [Polkadot Faucet](https://faucet.polkadot.chat) - 在推特发布Tweet附带你的地址，注意每24小时最多能获取300 mDOTs。
- [Blockxlabs Faucet](https://faucets.blockxlabs.com/polkadot) - 需要电邮登录。

如果以上二个方法不行，你需要在[Polkadot Watercooler聊天室](https://riot.im/app/#/room/#polkadot-watercooler:matrix.org)贴下你的地址并请求其它人发给你。你只需要贴下一个地址并将接收回来的DOTs发送到其它帐号。

## Bond DOTS 

_TODO_

## VPS服务器

* [OVH](https://www.ovh.com.au/)
* [Digital Ocean](https://www.digitalocean.com/)
* [Vultr](https://www.vultr.com/)
* [Linode](https://www.linode.com/)
* [Contabo](https://contabo.com/)
* [Scaleway](https://www.scaleway.com/)