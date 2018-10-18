# ineurobrain-contracts

These smart contracts are running in own blockchain and are needed for the operation of our mobile app. They ensure its decentralization, since all user data are stored and processed by the blockchain itself, which guarantees the uninterrupted operation of this system.

Description:

Messenger Smartcontract - created for secure blockchain messaging, for storing files use IPFS.
Profile Smartcontract is necessary for the operation of the INB NETWORK CITIZEN ID technology and the secure storage of identification data of a citizen of our blockchain-community.
Wallet Smartcontract - a smart-wallet wallet for securely storing ERC-20 tokens.
NBC / NBO Token Smartcontract - ERC-20 tokens (build on bankoor token).

---------------------------------------------

Данные смарт-контракты запущены в блокчейне INB и нужны для работы мобильного приложения. Они обеспечивают его децентрализованность, так как все пользовательские  данные хранятся и обрабатываться самим блокчейном, что гарантиет бесперебойную работу этой системы.

Подробная информация о смарт-контрактах:
Messenger  Smartcontract - создан для защищенного обмена сообщениями через блокчейн, для хранения файлов используется IPFS.
Profile Smartcontract - необходим для работоспособности технологии INB NETWORK CITIZEN ID и защищенного хранения идентификационных данных гражданина нашего блокчейн-государства.
Wallet Smartcontract – кошелек на смарт-контракте для безопасного хранения ERC-20 токенов.
NBC / NBO Token Smartcontract - смарт-контракты ERC-20 токенов (bankoor token).


---------------------------------------------

This project uses [ZeppelinOS](https://zeppelinos.org/).

## Setup

1. Clone the repo.
2. `npm install --global zos`.
2. `npm install truffle-flattener -g`.
3. copy file `.env.example` to `.env`.
4. setup your config file  `.env`.

If you get an EACCESS permissions error when installing, please review the npm documentation on preventing permissions errors.
https://docs.npmjs.com/getting-started/fixing-npm-permissions


verify
`truffle-flattener tokenNBC/contracts/SmartToken.sol > source.sol`

### Configure truffle provider

See more: [truffle-privatekey-provider](https://github.com/nosuchip/truffle-privatekey-provider)

### Truffle config

See more: [truffle - configuration](https://truffleframework.com/docs/truffle/reference/configuration)


## Contracts

- [Profiles](ProfilesSC/README.md)
- [Wallets](WalletsSC/README.md)


