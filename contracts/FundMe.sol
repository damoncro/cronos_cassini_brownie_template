// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol"; // 0.8 no longer need

contract FundMe {
    using SafeMathChainlink for uint256;
    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    address public owner;
    AggregatorV3Interface public priceFeed;

    constructor(address _priceFeed) public {
        priceFeed = AggregatorV3Interface(_priceFeed);
        owner = msg.sender; // whoever deploy the smart contract
    }

    function fund() public payable {
        uint256 minimumUSD = 5 * 10 ** 18;
        require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more TCRO!");
        // revert: get the money back and the unspent gas

        addressToAmountFunded[msg.sender] += msg.value; // accumulate the funds to the cooresponding address
        funders.push(msg.sender);

    }

    function getVersion() public view returns (uint256) {
        return priceFeed.version();
    }

    function getPrice() public view returns (uint256) {
        (, int256 answer, , , ) = priceFeed.latestRoundData(); // return answer, ignore others
        return uint256(answer * 10000000000); // type cast, (times 10^10, need gas)
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000; // 10^18
        return ethAmountInUsd;
    }

    function getEntranceFee() public view returns (uint256) {
        // mimimum USD
        uint256 mimimumUSD = 50 * 10**18;
        uint256 price = getPrice();
        uint256 precision = 1 * 10**18;
        return (mimimumUSD * precision) / price;
    }

    modifier onlyOwner {
        require(msg.sender == owner); // run require first, you can put reason here as well
        _; // then run other codes in the funciton
    }

    function withdraw() payable onlyOwner public { // add modifier onlyOwner
        // this: the contact is currently in
        msg.sender.transfer(address(this).balance); // get all ether back
        for (uint256 funderIndex=0; funderIndex<funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0; // clear the mapping
        }
        funders = new address[](0);
    }
}
