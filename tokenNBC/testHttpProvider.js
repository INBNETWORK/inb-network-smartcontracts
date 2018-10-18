const path = require("path");
const fs = require("fs");
const moment = require("moment");
const Web3 = require("web3");

const web3 = new Web3();


let pathEnv = null;

if (fs.existsSync(path.resolve(__dirname, "../.env")))
  pathEnv = path.resolve(__dirname, "../.env");

if (fs.existsSync(path.resolve(__dirname, ".env")))
  pathEnv = path.resolve(__dirname, ".env");

if (!pathEnv)
  throw new Error("file config .env not found");

require("dotenv").config({ path: pathEnv });

const host = process.env.RPC;
web3.setProvider(new web3.providers.HttpProvider(host));
if (web3.isConnected()) {
  console.log("Connected:   ", host);

  web3.version.getNode((err, result) => {
    console.log("NodeVersion: ", result);
  });
  web3.version.getNetwork((err, netId) => {
    console.log('networkId:',netId);
  });
  web3.eth.getBlockNumber((err, BlockNumber) => {
    console.log("Block Number:", BlockNumber);
    console.log("");

    web3.eth.getBlock(BlockNumber, (err, block) => {
      console.log("Bloc dedicated:", moment(new Date(block.timestamp * 1000)).format("DD.MM.YY in HH:mm:ss"));
      console.log("           Now:", moment().format("DD.MM.YY in HH:mm:ss"));
      console.log("");

      console.log("Left time:", moment(new Date(block.timestamp * 1000)).fromNow());
      console.log("Count transactions:", block.transactions.length);
    });
  });
} else {
  throw Error("error connect to:" + host);
}