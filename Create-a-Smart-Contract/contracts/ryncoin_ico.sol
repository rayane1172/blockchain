pragma solidity ^0.8.21;

contract ryncoin_ico {
  

  // introducing the maximum number of available for sale
  uint public max_ryncoins = 1000000;

  // introducing the USD to ryncoin convertion rate
  uint public usd_to_ryncoins = 1000;

  // introducing the total number of coin that have been bought by the investor
  uint public total_ryncoins_bought = 0;

  // mapping from the investor adress to its equity in ryncoins and USD
  mapping(address => uint) equity_ryncoins;
  mapping(address => uint) equity_usd;

  // checking if an investor can buy ryncoins
  modifier can_buy_ryncoins(uint usd_invested){
    require(usd_invested * usd_to_ryncoins + total_ryncoins_bought <= max_ryncoins );
    _;
  }

  //getting the equity in ryncoins of an investor
  function equity_in_ryncoins(address investor) external view returns (uint){
    return equity_ryncoins[investor];
  }

  // getting the equity in usd
  function equity_in_usd(address investor) external view returns (uint){
    return equity_usd [investor];
  }

  // buying ryncoins
  function buy_ryncoins(address investor, uint usd_invested) external can_buy_ryncoins(usd_invested){
    uint ryncoins_bought = usd_invested * usd_to_ryncoins;
    equity_ryncoins[investor] += ryncoins_bought;
    equity_usd[investor] = equity_ryncoins[investor] / 1000;
    total_ryncoins_bought += ryncoins_bought;
  }

  //selling ryncions
  function sell_ryncoins(address investor, uint ryncoins_to_sell) external {

    equity_ryncoins[investor] -= ryncoins_to_sell;
    equity_usd[investor] = equity_ryncoins[investor] / 1000;
    total_ryncoins_bought -= ryncoins_to_sell;
  }



}