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
  static final Map<int, String> filterFutureOptions = {
    1: 'Danh sách yêu thích',
    2: 'Tất cả',
    3: 'Dánh sách niêm yết mới',
    4: 'Vĩnh cửu',
    5: 'USDC Vĩnh cửu',
    6: 'Kỳ hạn'
  };

  static final Map<int, String> filterFutureAllOptions = {
    1: 'Tất cả',
    2: 'USDC',
    3: 'AI',
    4: 'RWA',
    5: 'Layer-1',
    6: 'Layer-2',
    7: 'Gaming',
    8: 'Meme',
    9: 'Cơ sở hạ tầng',
    10: 'DeFi',
    11: 'Metaverse',
    12: 'Thanh toán',
    13: 'PoW',
    14: 'Lưu trữ',
    15: 'NFT',
    16: 'Index'
  };
}