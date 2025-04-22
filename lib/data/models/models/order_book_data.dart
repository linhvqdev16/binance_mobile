class OrderBookEntry {
  final double price;
  final double quantity;

  OrderBookEntry({
    required this.price,
    required this.quantity,
  });
}

class OrderBookData {
  final List<OrderBookEntry> bids;
  final List<OrderBookEntry> asks;
  final int lastUpdateId;

  OrderBookData({
    required this.bids,
    required this.asks,
    required this.lastUpdateId,
  });

  OrderBookData copyWith({
    List<OrderBookEntry>? bids,
    List<OrderBookEntry>? asks,
    int? lastUpdateId,
  }) {
    return OrderBookData(
      bids: bids ?? this.bids,
      asks: asks ?? this.asks,
      lastUpdateId: lastUpdateId ?? this.lastUpdateId,
    );
  }
}