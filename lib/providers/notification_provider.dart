import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationItem> _notifications = [];
  bool _isLoading = false;
  String? _error;

  List<NotificationItem> get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Fetch notifications for a specific user
  Future<void> fetchNotifications(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await ApiService.getNotifications(userId);

      if (response.success) {
        _notifications = response.data ?? [];
        _error = null;
      } else {
        _error = response.error;
        _notifications = [];
      }
    } catch (e) {
      _error = 'Failed to load notifications: $e';
      _notifications = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh notifications
  Future<void> refreshNotifications(int userId) async {
    await fetchNotifications(userId);
  }

  /// Clear all notifications
  void clearNotifications() {
    _notifications = [];
    _error = null;
    notifyListeners();
  }

  /// Get notification count
  int get notificationCount => _notifications.length;

  /// Get pending penalty notifications
  List<NotificationItem> get pendingPenalties {
    return _notifications.where((notification) {
      return notification.isPenalty() &&
          notification.detailDenda?.statusDenda != 'lunas';
    }).toList();
  }

  /// Get recent notifications (last 24 hours)
  List<NotificationItem> get recentNotifications {
    final now = DateTime.now();
    return _notifications.where((notification) {
      return now.difference(notification.waktuPembuatan).inHours <= 24;
    }).toList();
  }
}
