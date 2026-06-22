import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/utc_date_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_address.dart';

abstract class EmailHeaderValue with EquatableMixin {
  const EmailHeaderValue();

  static EmailHeaderValue? fromJson(String key, dynamic json) {
    if (key.endsWith(':all')) {
      final formKey = key.substring(0, key.lastIndexOf(':all'));
      final list = json as List?;
      return AllHeaderValue(
          list?.map((e) => _parseSingle(formKey, e)).toList() ?? []);
    }
    return _parseSingle(key, json);
  }

  static EmailHeaderValue? _parseSingle(String key, dynamic json) {
    if (key.endsWith(':asText')) return TextHeaderValue(json as String?);
    if (key.endsWith(':asRaw')) return RawHeaderValue(json as String?);
    if (key.endsWith(':asDate')) {
      return DateHeaderValue(
          const UTCDateNullableConverter().fromJson(json as String?));
    }
    if (key.endsWith(':asAddresses')) {
      return AddressesHeaderValue(
          (json as List?)?.map((e) => EmailAddress.fromJson(e)).toList() ?? []);
    }
    if (key.endsWith(':asMessageIds')) {
      return MessageIdsEmailHeaderValue((json as List?)?.cast<String>() ?? []);
    }
    if (key.endsWith(':asURLs')) {
      return URLsHeaderValue((json as List?)?.cast<String>() ?? []);
    }
    return RawHeaderValue(json?.toString());
  }

  dynamic toJson();
}

class AllHeaderValue extends EmailHeaderValue {
  final List<EmailHeaderValue?> values;
  const AllHeaderValue(this.values);

  factory AllHeaderValue.fromTexts(List<String?> texts) =>
      AllHeaderValue(texts.map((t) => TextHeaderValue(t)).toList());

  factory AllHeaderValue.fromRaws(List<String?> raws) =>
      AllHeaderValue(raws.map((r) => RawHeaderValue(r)).toList());

  factory AllHeaderValue.fromDates(List<UTCDate?> dates) =>
      AllHeaderValue(dates.map((d) => DateHeaderValue(d)).toList());

  factory AllHeaderValue.fromAddresses(List<EmailAddress> addresses) =>
      AllHeaderValue([AddressesHeaderValue(addresses)]);

  factory AllHeaderValue.fromMessageIds(List<String> ids) =>
      AllHeaderValue([MessageIdsEmailHeaderValue(ids)]);

  factory AllHeaderValue.fromURLs(List<String> urls) =>
      AllHeaderValue([URLsHeaderValue(urls)]);

  @override
  dynamic toJson() => values.map((v) => v?.toJson()).toList();

  @override
  List<Object?> get props => [values];
}

class TextHeaderValue extends EmailHeaderValue {
  final String? value;
  const TextHeaderValue(this.value);

  @override
  dynamic toJson() => value;

  @override
  List<Object?> get props => [value];
}

class RawHeaderValue extends EmailHeaderValue {
  final String? value;
  const RawHeaderValue(this.value);

  @override
  dynamic toJson() => value;

  @override
  List<Object?> get props => [value];
}

class DateHeaderValue extends EmailHeaderValue {
  final UTCDate? value;
  const DateHeaderValue(this.value);

  @override
  dynamic toJson() => const UTCDateNullableConverter().toJson(value);

  @override
  List<Object?> get props => [value];
}

class AddressesHeaderValue extends EmailHeaderValue {
  final List<EmailAddress> addresses;
  const AddressesHeaderValue(this.addresses);

  @override
  dynamic toJson() => addresses.map((a) => a.toJson()).toList();

  @override
  List<Object?> get props => [addresses];
}

class MessageIdsEmailHeaderValue extends EmailHeaderValue {
  final List<String> ids;
  const MessageIdsEmailHeaderValue(this.ids);

  @override
  dynamic toJson() => ids;

  @override
  List<Object?> get props => [ids];
}

class URLsHeaderValue extends EmailHeaderValue {
  final List<String> urls;
  const URLsHeaderValue(this.urls);

  @override
  dynamic toJson() => urls;

  @override
  List<Object?> get props => [urls];
}
