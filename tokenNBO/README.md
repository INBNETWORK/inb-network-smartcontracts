# Profiles

## Setup

1. `npm i` or `yarn install`.
2. `zos add SmartToken --push live`.
3. *`zos push --network live`. - if you  have problem with step 2.
4. `zos create SmartToken --init initialize --args "NeuroBrainOxygen","NBO",8 --network live`.

## Update contract

1. `zos push --network live`
2. `zos update SmartToken --network live`