# 如何成为验证人

!!! info
    _这个教程将更新到最新测试网_

想成为一个好验证人，你需要留意以下几点:

- 拥有DOTs作抵押(基本要求）
- 确保运行最新版本
- 拥有网络保安知识
- 使用HSM保护私钥(推荐）

如果你拥有DOT但是没有足够技术知识，你最好也不要当验证人，反而提议把你的DOTs提名到其它你信任的验证人身上去帮你做这个工作。

作为提名人，你仍然能通过提名多个验证人从而获得奖励。你可以在[这裹](https://wiki.polkadot.network/en/latest/polkadot/node/nominator/)了解更多关于提名人的操作。

这个教程我们使用Ubuntu 18.04并将运行PoC-5测试网，不论你使用那个系统，大部份设定也不会有太大区别。另外这里有些VPS服务器给大家选择。

!!! attention
    _请大家确保不要在主网上使用以下设定。
    这个教程将会一步一步教大家如何设定验证人节点，如果你想在主网上线后做验证人，你必须对私钥管理，抵抗DDOS和高可用性有一定了解。_

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

## 安装`Polkadot` PoC-5

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
安装和Build需要一段时间，具体取决于你的硬件！

_TODO_

## VPS服务器

* [OVH](https://www.ovh.com.au/)
* [Digital Ocean](https://www.digitalocean.com/)
* [Vultr](https://www.vultr.com/)
* [Linode](https://www.linode.com/)
* [Contabo](https://contabo.com/)
* [Scaleway](https://www.scaleway.com/)