from brownie import FundMe, accounts
from scripts.helpful_scripts import get_account

def withdraw():
    fund_me = FundMe[-1]
    account = get_account()
    fund_me.withdraw({"from":account})

def main():
    withdraw()
