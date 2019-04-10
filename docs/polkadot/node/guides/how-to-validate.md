# How to validate

!!! info
    _This tutorial works with current Alexander testnet and has been updated for PoC-4._

To be a good validator, you should

- Have DOTs to stake (**Basic Requirement**)
- Keep your node up to the latest version
- Have enough knowledge of network security to create a robust network
- Use HSM (Hardware Security Module) to protect your key (**Highly Recommended**)

You should **NOT** run a validator if you have DOTs, but you do not have enough technical knowledge to set up a validator. It is recommended to delegate/nominate your DOTs to someone you trust for helping you to do this kind of work. 

As a nominator, you can still get the rewards by nominating multiple validators. If you want to know more about nominator, please see [here](../nominator.md).

For this tutorial, we use Ubuntu 18.04 and will be running on PoC-4 Alexander testnet. No matter what operating system you are using, setup should not be too much difference. There is a lot of [VPS](#vps-list) choice out there, feel free to pick one you like.
 
!!! attention
    _Please make sure that you do **NOT** use this setup & configuration on mainnet. This guide simply walks you through step-by-step how to set up & run a validator node. If you would like to run a validator seriously when mainnet is live, you have to be REALLY careful on some areas like key management, DDOS protection and high availability._

## Install rust

```bash
curl https://sh.rustup.rs -sSf | sh
sudo apt install make clang pkg-config libssl-dev
```
This command will fetch the latest version of Rust and install it, then execute the second command to install the required software before installing Polkadot.

```bash
rustup update
```
If you have installed rust already, run this command to check whether there is a new version available.

## Install `polkadot` PoC-4

Until support for the one-line installer is back up for PoC-4, you will need to build `polkadot` from source.

```bash
git clone https://github.com/paritytech/polkadot.git
# To update your node. Run from this step.
cd polkadot
cargo clean
git checkout v0.4
git pull origin v0.4
./scripts/init.sh
./scripts/build.sh
cargo install --path ./ --force
```

This may take a while depending on your hardware!

## Synchronize chain data

After installing all related dependencies, you can start your Polkadot node. Start to synchronize the chain by executing the following command:

```bash
polkadot --chain alex
```

It should take at least a few hours.

You can check the current highest block via [Telemetry](https://telemetry.polkadot.io/#/Alexander) or [PolkadotJS Block Explorer](https://polkadot.js.org/apps/#/explorer)
 
## Create accounts

To be a validator, you will need three separate accounts for managing your funds, namely `Stash`, `Controller` and `Session`. If you want to know more about it, please see [here](../../learn/staking.md#accounts).

![create account](../../../img/validator/polkadot-dashboard-create-account.jpg)
First, go to [PolkadotJS => Account](https://polkadot.js.org/apps/#/accounts) and click `Create account` tab.

To make things simple and identify your accounts easily, make sure to use `Stash`, `Controller` and `Session` in the name your accounts. You can use `Raw seed` and save it. The seed of the `Session` account needs to be used later in this guide. Also, make sure to use `Edwards (ed25519)` as a `Key pair crypto type` in the `Advanced creation options`.

Input your password to encrypt the seed for this account and click on `Save`.

![backup seed](../../../img/validator/polkadot-dashboard-backup-seed.jpg)

On the following screen, choose *Create and backup account* to store your JSON key file on your computer. Together with your password, this is a way to recover each account.
Reproduce those steps for all 3 accounts.

## Get testnet DOTs token

To continue the following steps, you are required to get some testnet DOTs token for the `Stash` and `Controller` accounts in order to submit transactions and use these DOTs as stake. The `Session` account doesn't need any DOT. Note that your accounts (`Stash` and `Controller`) need to have (much) more than 100mili DOTs as this is the minimum amount required for an account to exist. Having more allows you to pay for transactions fees.

Please go to [Polkadot Watercooler - Riot](https://riot.im/app/#/room/#polkadot-watercooler:matrix.org) channel, paste your account address to ask for testnet DOTs. You can paste one account and transfer some of the DOTs received to the other account.
 
You can also get some small testnet DOTs on [Blockxlabs](https://faucets.blockxlabs.com/polkadot) as well ;)

## Bond DOTs

It is now time to setup our validator. We will do the following:
- Bound the DOTs of the `Stash` account. These DOTs will be put at stake for the security of the network and can be slashed.
- Select the `Controller` as.. the controller. This is the account that will decide when to start or stop validating.
- Select the `Session` account as.. the session. This is the account whose seed will be used to run the node.

First, go to [Staking](https://polkadot.js.org/apps/#/staking/actions) section, you should see all of your existing accounts.

Select your `Stash` account, in our case it has, 200mili DOTs, and click on `Bond`. We will bound 100mili.

![dashboard bonding](../../../img/validator/polkadot-dashboard-bonding.png)

- **Controller account** - select the `Controller` account created earlier.
- **Value bonded** - how many DOTs from the `Stash` account you want to bond/stake. You can't use all of it as you will need to pay for the transaction fees. You can top up this amount and bound more DOTs later, however withdrawing any bounded amount requires the bounding duration period to be over (600 blocks at the time of writing).
- **Payment destination** - where the rewards get sent. More info [here](../../learn/staking.md#reward-distribution).

Once everything is filled properly, click `Bond` and sign the transaction (with your `Stash` account)

## Setting session key

You should now see the `Controller` account has `Set Session Key` and `Nominate` options available.

![dashboard validate](../../../img/validator/polkadot-dashboard-set-session-key.jpg)

Select `Set Session Key`. 

![dashboard staking](../../../img/validator/polkadot-dashboard-set-session-key-modal.jpg)

Select the `Session` account created previously and click on `Set Session Key`.

## Staking

You should see the `Controller` account has now `Validate` and `Nominate` options available.
Click on `Validate`.

![dashboard validate](../../../img/validator/polkadot-dashboard-validate.png)
![dashboard validate](../../../img/validator/polkadot-dashboard-staking.jpg)

- **Unstake threshold** - how often you want to be reported offline (and slashed) before being removed from the validator set.
- **Payment preferences** - rewards you will keep, the rest will be shared among you and your nominators.

Click `Stake`

Open your terminal, if your node is fully synchronized, run your validator with the seed from the `Session` account.

```bash
polkadot --validator --key SESSION_ACCOUNT_SEED --name NAME_ON_TELEMETRY
```

Then go to [Telemetry](https://telemetry.polkadot.io/#/Alexander), after a few seconds, your node information will be shown.

![telemetry monitor](../../../img/validator/telemetry_monitor.jpg)

Go to Staking tab, you should see a list of active validators out there. At the top of the page, it shows how many validators slots are available and how many nodes are intended to be a validator.

![staking queue](../../../img/validator/polkadot-dashboard-staking-queue.png)

Your node will be shown on the *next up* queue. In the next era (up to 1 hour), if there is a slot available, your node will become an active validator. 

**Congratulations!**

> If you want to run your validator as a systemd process see the short guide [here](./how-to-systemd.md).

**Notice:** As mainnet get closer, you can expect more slots will be available for testing.

## VPS List

* [OVH](https://www.ovh.com.au/)
* [Digital Ocean](https://www.digitalocean.com/)
* [Vultr](https://www.vultr.com/)
* [Linode](https://www.linode.com/)
* [Contabo](https://contabo.com/)
* [Scaleway](https://www.scaleway.com/)
