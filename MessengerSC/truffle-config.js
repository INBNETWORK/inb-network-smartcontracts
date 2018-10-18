const PrivateKeyProvider = require("truffle-privatekey-provider");
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

const provider = new PrivateKeyProvider(process.env.PRIVATE_KEY, process.env.RPC);

module.exports = {
    networks: {
        local: {
            host: 'localhost',
            port: 9545,
            gas: 5000000,
            network_id: '*'
        },
        live: {
            provider,
            network_id: 77,
            gasPrice: 0
        }
    }
};