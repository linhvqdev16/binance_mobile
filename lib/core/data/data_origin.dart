class DataOrigin{
  static final Map<int, String> spotTypes = {
    1: "Limit",
    2: "Market",
    3: "Stop Limit",
    4: "Stop Market",
    5: "Trailing Stop",
    6: "OCO",
    7: "TWAP"
  };

  static final Map<int, String> coinTradingTypes = {
    1: "USDT",
    2: "USDC"
  };

  static final Map<int, double> askHeightBySpotTypes = {
    1: 0.345,
    2: 0.23,
    3: 0.378,
    4: 0.29,
    5: 0.33,
    6: 0.445,
    7: 0
  };

  static final Map<int, double> bidsHeightBySpotTypes = {
    1: 0.355,
    2: 0.23,
    3: 0.378,
    4: 0.29,
    5: 0.33,
    6: 0.445,
    7: 0
  };


  static final Map<int, int> takeUpRecordByCoinType = {
    1: 7,
    2: 7,
    3: 10,
    4: 6,
    5: 7,
    6: 10,
    7: 0
  };

  static final Map<int, String> ocoLimitOrMarketTypes = {
    1: "Giới hạn",
    2: "Thị trường"
  };

  static final Map<int, String> ocoLimitOrMarketLabelTypes = {
    1: "Giới hạn SL",
    2: "Thị trường SL"
  };

  static final Map<int, String> bidFormPopupTypes = {
    1: "0.01",
    2: "0.1",
    3: "1",
    4: "10",
    5: "50",
    6: "100"
  };
}