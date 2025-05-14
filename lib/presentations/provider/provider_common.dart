import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderCommon{
  static final selectedLimitOrMarketOCOProvider = StateProvider<int>((ref) => 1);
  static final selectedBidFormPopupProvider = StateProvider<int>((ref) => 1);
  static final selectedCoinTypeFutureProvider = StateProvider<int>((ref) => 3);
  static final selectedCoinTypeAllOptionsFutureProvider = StateProvider<int>((ref) => 3);
}