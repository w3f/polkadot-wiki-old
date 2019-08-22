# Polkadot构建者入门指南


!!! 信息
    本文是”[Everything you Need to Know to Prepare for Polkadot](https://medium.com/polkadot-network/everything-you-need-to-know-to-prepare-for-polkadot-32d08b929735)”（准备Polkadot时需了解的一切内容）博文的最新版本。

Polkadot作为区块链协议，拥有两个目标：为所有连接的平行链链提供**共享安全性**，和允许所有互连的链通过**ICMP**交互操作。随着Parity Substrate和 [PDK](./pdk.md)，开发和发布新链所需的时间明显减少。过去往往要花几年时间才能推出一条新链，但现在可能只需几周甚至几天。

本指南将带您了解目前可实施的步骤，从而通过Polkadot建立个人愿景。本文将解释平行链与智能合约之间的区别（以及其中一个比另一个更适合您的应用程序的原因）。同时，本文还包含所有目前和未来可用的资源，以便您开始创建应用程序，为今年晚些时候发布Polkadot 主网作准备。

## **目前进展**

- 主网：**2019年年底**
- 当前PoC发布：**PoC**-4
- 当前测试网**：**Alexander
- Substrate: **1.0.0-rc**
- Cumulus：**完善中**
- ink!: **Pre-Alpha**

**您需了解**：Polkadot目前发布版本为PoC-4，其中包含正在运行的Alexander测试网，该测试网在整个PoC-3发布周期内活跃了3个多月之久。Polkadot使用各种[编程语言](../learn/implementations.md)（例如Rust、JavaScript等）下的实现构建而成。目前，一流的实现通过Rust构建，使用Substrate框架开发区块链。Substrate是一个库，允许开发者基于基本层（包括网络协议、共识和Wasm解释器）进行构建，更便于开发整个区块链。 Cumulus是Substrate的扩展，目前仍在开发之中，它将允许任何基于Substrate构建的链与Polkadot连接，成为平行链。Substrate即将发布1.0.0版本，该版本将稳定其API（应用程序编程接口）。

Substrate链通过使用SRML的合约运行时模块，内建了智能合约。该合约模块将允许在链上部署编译为Wasm的智能合约。为加快此过程，Parity一直积极开发出名为ink!的领域特定语言。

Polkadot计划于2019年底正式上线主网。目前，相关工具已经面市并稳定，现在是开始加入其中为发布作准备的最佳时机。但请等一下！在您全心投入代码之前，应该思考希望开发哪种去中心化的应用程序，也要了解多种不同的供开发者在Polkadot上构建使用的范例。

## **平行链和智能合约的构建有哪些不同？**

Polkadot提供了两种部署应用程序的方法：在现有平行链上将其部署为智能合约，或部署为自己的平行链。使用这两者之间的任何一种方法都存在利弊权衡，您可阅读本章节加以了解。

平行链作为独立链包含各自的运行时逻辑，这些逻辑受益于共享安全性和由Polkadot中继链实现的跨链信息传递。平行链允许高度的灵活性和定制化，不过要实现这一点需付出大量努力。

Polkadot主网中将有一个或多个平行链来充当智能合同平台。智能合约是只存在于单一链上的可执行程序，复杂性并不高。而正是因为它们只存在于单一链，它们才能够与其它智能合约进行良好的交互操作。不过，它们将始终会受到主链固有特性的约束和限制。

如您需要大范围管控应用程序的设计和特性，平行链是更好的选择。请记住，在智能合约转换为成熟的平行链之前，它可以作为试验场加以应用。智能合约平台通常会包含IDE等便捷工具，帮助促进快速迭代。在全力构建平行链之前，您可以先创建智能合约MVP来衡量用户兴趣。

平行链将给予开发者更多空间，允许从头开始构建链的货币体系。与智能合约平台相比，平行链将更简洁、更有效地执行复杂逻辑。同时，平行链还提供了更多的治理形式，可以以比当前硬分叉过程争议更小的方式执行完全升级。

## 部分您可以拥有的平行链特性：

- 自定义费用结构（例如，交易时支付固定费用或按字节支付）

- 自定义原生代币的通胀证策

- 通过状态函数转换筹措宝藏

- 可以管理DAO的治理机制，DAO会负责分配链上宝藏

![build 1](../../../img/build-1.png)

平行链打开了建立更复杂运行时的可能性，它们在智能合约上执行会更昂贵。不过相比之下，平行链缺少了gas（计算交易费用单位）计量系统，可能容易受到无限循环的漏洞影响（智能合约有方法阻止这一现象）。

另外，您也可以选择将这两者结合。当部分逻辑需要循环且无法移除时，可以使用平行链原生运行时处理所有复杂的逻辑，运用智能合约调用迭代。

大概您已经了解了哪一个更适合您的应用程序（或混合两者），为帮助快速回顾，可将以下比较图表视作备忘单：

![build 2](../../../img/build-2.png)

目前，本指南分为两部分，具体取决于您决定将应用程序建立于平行链还是智能合约之上。您可以随意阅读这两个部分，也可以只阅读适用于您的那部分。

- [构建平行链](#so-you-want-to-build-a-parachain)
- [构建智能合约](#so-you-want-to-build-a-parachain)

## **构建**平行链

确定构建平行链是适用于新项目的方法后，接下来需决定使用的框架。目前只有Substrate可作为开发平行链的框架。

未来，会涌现许多使用各种语言（包括C ++，Rust，Go和JS）的Polkadot 运行时[实现](https://wiki.polkadot.network/en/latest/polkadot/learn/implementations/)。

## **开始使用Substrate**

正如上文所述，Polkadot是基于Substrate框架建立的，Substrate是区块链创新者的工具集，为构建链提供了必要的构建区块。它内部的模块化插件库可以用来构建更复杂的逻辑链。

为更好地开始使用Substrate，您可访问Substrate Development Hub，这是由Parity Technologies建立和维护的线上资源。

> 前往Substrate Developer Hub ->[这里]()

建议您多浏览下，熟悉一些常见模式。一旦有了扎实的理解基础，便可以进入Substratekitties工作坊并参阅TCR Dappchain教程开始挑战自己。

## **如何设定平行链**

在利用Substrate建立链逻辑后，您需将其编译为Wasm可执行文件。该Wasm代码blob将包含整个链的状态转换函数。

届时，Polkadot中继链上的验证人将使用此Wasm blob验证平行链所有状态转换。

为了使Polkadot验证人掌握平行链的最新状态转换，需构建部分基础设施，此工作由平行链上的校验人节点负责执行。

Substrate内置自己的联网层，但无法直接成为兼容Polkadot的校验人节点。

为此，Parity Technologies正积极开发Substrate的扩展-Cumulus，它将使任何基于Substrate建立的链易于转移到Polkadot兼容的平行链上。

#### Cumulus

[Cumulus](./cumulus.md)旨在成为Substrate的扩展，它将使所有Substrate运行时兼容于Polkadot。

它将处理网络兼容性，供平行链用于实现以连接到Polkadot网络上，其中包括：

- 跨链信息传递
- 只需稍微修改（可能只需导入crate和添加一行代码
- 跨链信息传递
- 即用校验人节点设定
- 中继链的嵌入式轻客户端
- 与Polkadot上产生的区块兼容
- 只需稍微修改（可能只需导入crate和添加一行代码），把Cumulus整合到Substrate链，便可将它移植到Polkadot上成为平行链。

Polkadot联合始创人Rob Habermeier最近在EthCC分享了Cumulus的最新开发状况，您可观看下文视频。

[![img](http://img.youtube.com/vi/thgtXq5YMOo/0.jpg)](https://www.youtube.com/watch?v=thgtXq5YMOo)

### 何使平行链加入Polkadot

为使平行链加入Polkadot网络，需占有一个平行链插槽。

平行链插槽会通过公开拍卖进行出售，您可以浏览本维基网站的“[平行链拍卖](../learn/auction.md)页面了解该拍卖机制。

## 构建智能合约

Polkadot中继链本身并不支持智能合约，但鉴于Polkadot网络连接着各种各样的区块链，有些平行链可能将提供智能合约功能。

Parity Technologies已经为想把智能合约功能添加到平行链的即用解决方案制定了大量基础。Substrate内核SRML[合约](https://github.com/paritytech/substrate/tree/master/srml/contract)模块将支持智能合约编译为Wasm。

另外，编译智能合约为Wasm时还需要一种合适的语言。为此，Parity一直致力于开发名为[Ink](#ink)的领域特定语言。

目前，名为[Edgeware](#edgeware)的项目公布计划成为Polkadot上的平行链并支持智能合约。随着生态日益成熟，未来很有可能会出现更多支持智能合约的平行链。

与此同时，Polkadot也会通过桥接器与早有的智能合约平台（例如，以太坊和Tezos）共存，这意味着即使是这些平台上的当前开发内容，日后也可能适用于在Polkadot上运行。

### Edgeware

Edgeware计划成为Polkadot上的平行链，将支持智能合约。它将成为第一个连接到Polkadot主网带有智能合约的平行链，且极富创新型的治理和代币分配方式。您可以在Edgeware[网站](https://edgewa.re/)上了解该项目的最新动态。

### Ink

[Ink](https://github.com/paritytech/ink)致力于成为用于编写Rust智能合约的新领域专用语言，智能合约需编译成Wasm代码。如README中所述，Ink仍处于实验阶段，很多计划中的功能尚未实现，但现在可以开始使用它来编写智能合约。

感兴趣的开发者可以通过学习已编写好的[范例](https://github.com/paritytech/ink/tree/master/examples)，开始编写智能合约。这些范例可以用作参考，帮助编写出更复杂的、可以部署在支持智能合约的平行链上的逻辑。

Ink!为基于Wasm虚拟机并与Substrate链兼容的新智能合约堆栈构建了充足基础。

Substrate内含合约模块，其中包括智能合约链所需的核心逻辑。除此之外，ink!将是用Rust编写智能合约的语言，它以已有的Rust工具和支持为优势，将编译为Wasm。

## 部署智能合约

智能合约只是存在于链上某地址的代码，外部参与者可进行调用。关键点是必须在任何人开始执行此代码之前，将它切实部署于链上！

无论使用哪种特定平行链，部署智能合约到链上都会略有不同。不过通常，您需要提交一个特殊交易，该交易将在分类账上创建智能合约。您可能将为初始化逻辑和合约内的所有存储支付相关费用。

## 支付智能合约

每个平台都有各自不同的支付和维护智能合约状态的方式。

您可能会看到的不同的支付智能合约方式包括：

- 支付与部署交易关联的交易费用。
- 订阅方式，即定期支付链实体相应的平台使用费。
- 访问代币模式，即需持有一定原生代币数量才可使用平台（EOS也有类似的模式）。储存租金。
- 免费试用或开发者促销。
- 大多数智能合约平台使用某种形式的gas来限制用户可以执行的操作数量。用户需预先支付所需费用，余下gas将会退还。

- 您需要考虑智能合约的存储和复杂性，以确保gas使用率保持在合理的范围内。无论您使用哪种智能合约平台，存储可能都会十分昂贵，因此有必要尽可能将数据保存到链下。可以考虑使用IPFS或Storj来保存数据，并只在链上提交内容地址。

### 目前仍处于初期阶段

Polkadot的智能合约仍处于初期阶段，开发才刚刚开始稳定。我们正努力提供内容以便开发者加快学习，并努力更新本维基网站内的资源。 另外，您还可以通过以下链接了解最新信息：

- [Edgeware](https://edgewa.re/).

- [ink!](https://github.com/paritytech/ink)（留意维基选项卡中的内容）

- [合约模块](https://github.com/paritytech/substrate)。

## 总结

本指南提供了思维模式和必备资料，可帮助您决定是构建项目为平行链还是智能合约。尽管工具尚未成熟，但提早开始有助于您熟悉构建，使项目赢在起跑线。同时，您还可以进行真正的创新。

如您有任何有关平行链或智能合约的有趣想法想要分享，请随时在[Polkadot Watercooler](#/room/#polkadot-watercooler:matrix.org)上与我们交谈。如您是开发者，可以前往[Polkadot Beginners Lounge](#/room/#polkadotnoobs:matrix.org)或[Substrate Technical](#/room/#substrate-technical:matrix.org)提出问题。请一如既往地继续关注我们的[社交频道](https://wiki.polkadot.network/en/latest/community/)，掌握最新动态。祝您好运！

 