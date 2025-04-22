import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  final String baseUrl;
  final Function(dynamic) onMessage;
  final Function() onConnected;
  final Function(dynamic) onError;
  final Function() onDisconnected;

  Timer? _pingTimer;
  Timer? _reconnectTimer;
  bool _isConnected = false;
  List<String> _subscriptions = [];

  WebSocketService({
    required this.baseUrl,
    required this.onMessage,
    required this.onConnected,
    required this.onError,
    required this.onDisconnected,
  });

  bool get isConnected => _isConnected;

  void connect() {
    if (_isConnected) return;

    try {
      _channel = WebSocketChannel.connect(Uri.parse(baseUrl));

      _channel!.stream.listen(
            (dynamic message) {
          // Handle incoming messages
          onMessage(jsonDecode(message));
        },
        onDone: () {
          _isConnected = false;
          _stopPingTimer();
          onDisconnected();
          _scheduleReconnect();
        },
        onError: (error) {
          _isConnected = false;
          _stopPingTimer();
          onError(error);
          _scheduleReconnect();
        },
      );

      _isConnected = true;
      onConnected();
      _startPingTimer();

      // Resubscribe to all streams if reconnecting
      if (_subscriptions.isNotEmpty) {
        _resubscribeToStreams();
      }
    } catch (e) {
      _isConnected = false;
      onError(e);
      _scheduleReconnect();
    }
  }

  void disconnect() {
    _stopPingTimer();
    _stopReconnectTimer();
    _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    _subscriptions = [];
  }

  void send(dynamic data) {
    if (!_isConnected) {
      connect();
      // Delay sending until connected
      Future.delayed(const Duration(seconds: 1), () => send(data));
      return;
    }

    final String message = data is String ? data : jsonEncode(data);
    _channel?.sink.add(message);
  }

  void subscribe(List<String> streams) {
    _subscriptions.addAll(streams);

    if (!_isConnected) {
      connect();
      return;
    }

    final payload = {
      "method": "SUBSCRIBE",
      "params": streams,
      "id": DateTime.now().millisecondsSinceEpoch
    };

    send(payload);
  }

  void unsubscribe(List<String> streams) {
    _subscriptions.removeWhere((s) => streams.contains(s));

    if (!_isConnected) return;

    final payload = {
      "method": "UNSUBSCRIBE",
      "params": streams,
      "id": DateTime.now().millisecondsSinceEpoch
    };

    send(payload);
  }

  void _resubscribeToStreams() {
    if (_subscriptions.isEmpty) return;

    final payload = {
      "method": "SUBSCRIBE",
      "params": _subscriptions,
      "id": DateTime.now().millisecondsSinceEpoch
    };

    send(payload);
  }

  void _startPingTimer() {
    _stopPingTimer();
    _pingTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      send({"method": "PING"});
    });
  }

  void _stopPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = null;
  }

  void _scheduleReconnect() {
    _stopReconnectTimer();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      if (!_isConnected) {
        connect();
      }
    });
  }

  void _stopReconnectTimer() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }
}