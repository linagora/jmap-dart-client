import 'package:jmap_dart_client/http/converter/contact/title_id_converter.dart';
import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';
import 'package:jmap_dart_client/jmap/contact/title_values.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';

class TitleValueConverter {
  MapEntry<TitleId, TitleValue> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(TitleId(key), TitleValue.fromJson(value));
    } else {
      return MapEntry(TitleId(key), value as TitleValue);
    }
  }

  MapEntry<String, dynamic> toJson(TitleId titleId, TitleValue value,
      {ContactApiVersion apiVersion = ContactApiVersion.ietf}) {
    final json = apiVersion == ContactApiVersion.ietf
        ? value.toIetfJson()
        : value.toLegacyJson();

    return MapEntry(const TitleIdConverter().toJson(titleId), json);
  }
}
