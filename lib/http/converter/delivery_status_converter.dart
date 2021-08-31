import 'package:jmap_dart_client/jmap/mail/email/submission/delivery_status.dart';

class DeliveryStatusConverter {
  MapEntry<String, DeliveryStatus> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(key, DeliveryStatus.fromJson(value));
    } else {
      return MapEntry(key, value);
    }
  }

  MapEntry<String, dynamic> toJson(String key, DeliveryStatus value) {
    return MapEntry(key, value.toJson());
  }
}