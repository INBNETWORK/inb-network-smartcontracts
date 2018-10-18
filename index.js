const cWallets = require("../contracts/WalletsSC/build/contracts/Wallets.json");
const cProfiles = require("../contracts/ProfilesSC/build/contracts/Profiles.json");

if (!process.browser) {

  const path = require("path");
  const fs = require("fs");

  let pathEnv = null;

  if (fs.existsSync(path.resolve(__dirname, "../.env")))
    pathEnv = path.resolve(__dirname, "../.env");

  if (fs.existsSync(path.resolve(__dirname, ".env")))
    pathEnv = path.resolve(__dirname, ".env");

  if (!pathEnv)
    throw new Error("file config .env not found");
  require("dotenv").config({ path: pathEnv });

}
console.log(process.env);
const rpcHost = process.env.RPC;
const networkId = "77";
if (!cProfiles || !cProfiles.networks || !cProfiles.networks[networkId] || !cProfiles.networks[networkId].address)
  throw new Error("/contracts/ProfilesSC/build/contracts/Profiles.json check network[networkId].address and abi");
if (!cWallets || !cWallets.networks || !cWallets.networks[networkId] || !cWallets.networks[networkId].address)
  throw new Error("/contracts/ProfilesSC/build/contracts/Profiles.json check network[networkId].address and abi");


const contracts = {
  "Profile": {
    ...({ address: cProfiles.networks[networkId].address, abi: cProfiles.abi })
  },
  "Wallets": {
    ...({ address: cWallets.networks[networkId].address, abi: cWallets.abi }),
    defaultWallets: []
  }
};


module.exports = {
  rpcHost,
  networkId,
  contracts
};