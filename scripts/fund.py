from brownie import FundMe, accounts
from scripts.helpful_scripts import get_account

def fund():
    fund_me = FundMe[-1]
    account = get_account()
    entrance_fee = fund_me.getEntranceFee()
    print(entrance_fee)
    print(f"The current entry fee is {entrance_fee}")
    print("Funding")
    # fund_me.fund({"from":account, "value":entrance_fee}) # fund 0.025 TCRO
    fund_me.fund({"from":account, "value":1*10**18}) # fund 1 TCRO

def main():
    fund()
