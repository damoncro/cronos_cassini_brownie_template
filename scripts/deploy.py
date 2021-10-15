from brownie import FundMe, MockV3Aggregator, network, config, accounts
from scripts.helpful_scripts import get_account, deploy_mocks, LOCAL_BLOCKCHAIN_ENVIRONMENTS

def deploy_fund_me():
    account = get_account()

    # Always deploy mocks, we supposed it would not have the contract
    deploy_mocks()
    price_feed_address = MockV3Aggregator[-1].address

    # pass the price feed address to our fundme contract
    fund_me = FundMe.deploy(
        price_feed_address, # pass to Constructor
        {"from": account},
        publish_source=config["networks"][network.show_active()].get("verify"),
    )
    print(f"Contract deployed to {fund_me.address}") # print contract address
    return fund_me # return the contract

def main():
    deploy_fund_me()
