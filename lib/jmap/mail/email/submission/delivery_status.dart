
import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/delivered_converter.dart';
import 'package:jmap_dart_client/http/converter/displayed_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_status.g.dart';

@DeliveredConverter()
@DisplayedConverter()
@JsonSerializable()
class DeliveryStatus with EquatableMixin {
  final String smtpReply;
  final Delivered delivered;
  final Displayed displayed;

  DeliveryStatus(this.smtpReply, this.delivered, this.displayed);

  factory DeliveryStatus.fromJson(Map<String, dynamic> json) => _$DeliveryStatusFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryStatusToJson(this);

  @override
  List<Object?> get props => [smtpReply, delivered, displayed];
}

class Delivered with EquatableMixin {
  static final Delivered queued = Delivered('queued');
  static final Delivered yes = Delivered('yes');
  static final Delivered no = Delivered('no');
  static final Delivered unknown = Delivered('unknown');

  final String value;

  Delivered(this.value);

  @override
  List<Object?> get props => [value];
}

class Displayed with EquatableMixin {
  static final Displayed yes = Displayed('yes');
  static final Displayed unknown = Displayed('unknown');

  final String value;

  Displayed(this.value);

  @override
  List<Object?> get props => [value];
}