# Secure Validator Setup Guide


The following article is based on the [polkadot-secure-validator](https://github.com/w3f/polkadot-secure-validator) repository and assumes you have already set up a Polkadot or Kusama validator. If do not have any validator set-up experience, please follow the guide [here](https://guide.kusama.network/en/latest/try/validate/) for an introductory tutorial first.

In this guide, we will enhance the security of the validator by setting a layered architecture with public nodes and a private validator node. The validator is configured on a VPN with the public nodes so that it's only visible to its own public nodes for communication.

We will use Ubuntu 18.04 and Wireguard to configure the VPN. Wireguard is a fast and secure VPN that uses state-of-the-art cryptography. If you want to learn more about Wireguard, please go [here](https://www.wireguard.com/). Before we move on to the next step, configure the firewall to open the required ports.

```bash
# ssh port
ufw allow 22/tcp
# wireguard port  (Note: Only validator)
ufw allow 51820/udp
# libp2p  port
ufw allow 30333/tcp
ufw enable
# double check the firewall rules
ufw verbose
```

## 1. Install Wireguard

```bash
# install linux headers
apt install linux-headers-$(uname -r)
add-apt-repository ppa:wireguard/wireguard
apt-get update # you can skip this on Ubuntu 18.04
apt-get install wireguard
```

## 2. Generating Keys

There are two commands you will use quite a bit when setting up the Wireguard. `wg` is the configuration utility for managing Wireguard tunnel interfaces. `wg-quick` is a utility  for starting and stopping the interface.

To generate the public / private keypair, execute the following commands:

```bash
cd /etc/wireguard
umask 077
wg genkey | sudo tee privatekey | wg pubkey | sudo tee publickey
```

You will see two files, `publickey` and `privatekey`, have been created.  As may be guessed from their names, `publickey` contains the public key and `privatekey` contains the private key of the keypair.

## 3. Configuration

Now create a `wg0.conf` file under the `/etc/wireguard/` directory.  This file will be used to configure the interface.

Here is a `wg0.conf` configuration template for the **validator**. 

```bash
[Interface]
# specify the address you want to assign for this machine.
Address = 10.0.0.1/32
# the private key you just generated
PrivateKey = 8MeWtQjBrmYazzwni7s/9Ow37U8eECAfAs0AIuffFng=
# listening port of your server
ListenPort = 51820
# if you use wg to add a new peer when running, it will automatically 
# save the newly added peers to your configuration file
# without requiring a restart
SaveConfig = true

# Public Node A   
[Peer]
# replace it to the public node A public key
PublicKey = Vdepw3JhRKDytCwjwA0nePLFiNsfB4KxGewl4YwAFRg=
# public ip address for your public node machine
Endpoint = 112.223.334.445:51820
# replace it to the public node A interface address
AllowedIPs = 10.0.0.2/32
# keep the connection alive by sending a handshake every 21 seconds
PersistentKeepalive = 21

# Note: In this guide, we only set up 1 peer but
# if you want to add another, just follow the example below
# 
# Public Node B  
[Peer]
PublicKey = Il/yVJeQ/y23NyBBaqHUQLFBUSC6+c0XfSfS9gLgpmM=
Endpoint = 111.221.354.442:51820
AllowedIPs = 10.0.0.3/32
PersistentKeepalive = 21
```

You need to do the previous steps (1 and 2) again in your **public node** but the `wg0.conf` configuration file will look like this:

```bash
[Interface]
Address = 10.0.0.2/32
PrivateKey = eCii0j3IWi4w0hScc8myUj5QjXjjt5rp1VVuqlEmM24=
ListenPort = 51820
SaveConfig = true

# Validator
[Peer]
# replace this with the validator public key
PublicKey = iZeq+jm4baF3pTWR1K1YEyLPhrfpIckGjY/DfwCoKns=
# public ip address of the validator
Endpoint = 55.321.234.4:51820
# replace it with the validator interface address
AllowedIPs = 10.0.0.1/32
PersistentKeepalive = 21
```
## 4. Test-Connection

If everything goes well, you are ready to test the connection.

To start the tunnel interface, execute the following command in both your `validator` and `public node`.

```bash
wg-quick up wg0

# The console would output something like this
#[#] ip link add wg0 type wireguard
#[#] wg setconf wg0 /dev/fd/63
#[#] ip -4 address add 10.0.0.1/24 dev wg0
#[#] ip link set mtu 1420 up dev wg0
```

You can check the status of the interface by running `wg` :

```bash
# Output
 interface: wg0
  public key: iZeq+jm4baF3pTWR1K1YEyLPhrfpIckGjY/DfwCoKns=
  private key: (hidden)
  listening port: 51820

peer: Vdepw3JhRKDytCwjwA0nePLFiNsfB4KxGewl4YwAFRg=
  endpoint: 112.223.334.445:51820
  allowed ips: 10.0.0.2/32
  latest handshake: 18 seconds ago
  transfer: 580 B received, 460 B sent
  persistent keepalive: every 25 seconds
```

You can then use `ping` to verify the connectivity between each other. 

In case you want to update `wg0.conf`, run `wg-quick down wg0` first to stop the interface.

After you have started the `wg0` interface on your public node and validator, you can start the node.

**Public Node (Full Polkadot/Kusama Node)**

```bash
# Command
polkadot --name "Public Node A"
```

```bash
2019-09-05 18:01:56 Parity Polkadot
2019-09-05 18:01:56   version 0.4.4-aa497540-x86_64-linux-gnu
2019-09-05 18:01:56   by Parity Team <admin@parity.io>, 2017-2019
2019-09-05 18:01:56 Chain specification: Alexander
2019-09-05 18:01:56 Node name: Public Node A
2019-09-05 18:01:56 Roles: FULL
2019-09-05 18:02:23 Best block: #2916792
2019-09-05 18:02:23 Local node identity is: QmNLfzqZ94TcnjgNXZnPRTSLqL4oabrpupba8SYbB95MoK
2019-09-05 18:02:23 Listening for new connections on 127.0.0.1:9944.
```
**Validator**

When you start the validator, add these two flags.

``--reserved-nodes`` - Nodes can communicate with your validator

``--no-telemetry`` - Prevent the IP leak by not sending any data to the telemetry

```bash
# Command
polkadot --name "Validator" --reserved-nodes /ip4/10.0.0.3/tcp/30333/p2p/QmNLfzqZ94TcnjgNXZnPRTSLqL4oabrpupba8SYbB95MoK --no-telemetry
```

```bash
2019-09-05 18:16:36 Node name: Validator
2019-09-05 18:16:36 Roles: FULL
2019-09-05 18:16:58 Best block: #2207242
2019-09-05 18:16:58 Local node identity is: QmaiebwiaaaFRpAd7DTR8bv72BJs9WAMLWbjP61JeKpFf5
2019-09-05 18:16:58 Listening for new connections on 127.0.0.1:9944.
2019-09-05 18:17:00 Discovered new external address for our node: /ip4/167.179.102.32/tcp/30333/p2p/QmaiebwiaaaFRpAd7DTR8bv72BJs9WAMLWbjP61JeKpFf5
2019-09-05 18:17:03 Syncing, target=#2953887 (1 peers), best: #2207242 (0xbf72…c74d), finalized #2206720 (0x3c82…de2c), ⬇ 8.8kiB/s ⬆ 6.7kiB/s
2019-09-05 18:17:04 Discovered new external address for our node: /ip4/10.0.0.1/tcp/30333/p2p/QmaiebwiaaaFRpAd7DTR8bv72BJs9WAMLWbjP61JeKpFf5
2019-09-05 18:17:10 Syncing 38.8 bps, target=#2953887 (1 peers), best: #2207498 (0x7ea2…8a84), finalized #2206720 (0x3c82…de2c), ⬇ 54.0kiB/s ⬆ 59.4kiB/s
2019-09-05 18:17:14 Applying authority set change scheduled at block #2207744
2019-09-05 18:17:14 Applying GRANDPA set change to new set [(3a92077b16fbb87972be7ebaf1b7e70f5b4fac9636c136936a28d0fb494d1ed4 (5DPW1n4q...), 1), (4bd3620064cda1f4cf405bf9ab565c9bad69446034c48884ffc5363a5286b145 (5Dn8F1SU...), 1), (ca8feb6f870330cdaea24e49c2f850b66729340cab164aea86c0a782ddecf57a (5GeJHN5E...), 1), (dcb83e46917c3c0ca35b9a18a32ba6d3912b6d50ab2bd382341d2e4fd2e6946f (5H4787dX...), 1)]
2019-09-05 18:17:15 Imported justification for block #2207744 that triggers command Changing authorities, signaling voter.
2019-09-05 18:17:17 Syncing 53.2 bps, target=#2953887 (1 peers), best: #2207882 (0x217a…f96a), finalized #2207744 (0xcdf8…6cee), ⬇ 50.3kiB/s ⬆ 15.8kiB/s
2019-09-05 18:17:18 Discovered new external address for our node: /ip4/10.0.1.203/tcp/30333/p2p/QmaiebwiaaaFRpAd7DTR8bv72BJs9WAMLWbjP61JeKpFf5
```

Based on the above output, there is only 1 peer connected to the validator.  This is the public node we defined by using the `--reserved-nodes` flag to specify the public node internal address and the node identity.

## Summary

So far you have successfully:

- Configured the firewall
- Set up and configured the Wireguard.
- Ran a validator with public node

If you have experience with devops tools such as `Terraform` and `Ansible`, please check out the [secure validator setup](https://github.com/w3f/polkadot-secure-validator) repository. This tool does everything we talked about above, but you still need to define some credentials (e.g. IP of your server) in the inventory file and then you can manage the relevant servers in an automated way. 

> Note: Sentry Node in the networking layer has not been fully implemented yet, so please stay tuned. We will keep updating the guide with any updates on this [issue](https://github.com/paritytech/substrate/issues/2999).

## Todos
- Linux best practices
- Wireguard as a system service
- High Availability Configuration
