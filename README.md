# cronos_cassini_brownie_template

## Description
A template to deploy/call smart contracts to Cronos Cassini using Brownie.

## How to use?
1. Get TCRO from https://cronos.crypto.org/faucet
2. Create `.env` file in the root directory of this template project
3. Get the private key from metamask and add it into `.env`
``` sh
export PRIVATE_KEY='0xxxxxxxxxxxxxxxxxxxxxxxxxx'
```

4. Add cassini network
``` sh
brownie networks add Ethereum cassini host=https://cronos-testnet-3.crypto.org:8545 chainid=338
```

5. Run `deploy.py` to deploy contacts under contracts folder
``` sh
brownie run scripts/deploy.py --network cassini # it would deploy to cassini testnet!
```

6. Call `fund.py` to transfer TCRO to the contract we deployed in step 2. Modify the TCRO value in `fund.py` if you would like to.
``` sh
brownie run scripts/fund.py --network cassini
```

7. Call `withdraw.py` to get all TCRO back
``` sh
brownie run scripts/withdraw.py --network cassini
```

## How to deploy your smart contrats?
1. Just add your solidy contracts in contract folder and modify the deploy.py in scripts folder.
2. Run `brownie run scripts/fund.py --network cassini`
