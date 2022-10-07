import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'disposition.g.dart';

@JsonSerializable(explicitToJson: true)
class Disposition with EquatableMixin {
  final ActionMode actionMode;
  final SendingMode sendingMode;
  final DispositionType type;

  Disposition(this.actionMode, this.sendingMode, this.type);

  @override
  List<Object?> get props => [actionMode, sendingMode, type];

  factory Disposition.fromJson(Map<String, dynamic> json) =>
      _$DispositionFromJson(json);

  Map<String, dynamic> toJson() => _$DispositionToJson(this);
}

enum ActionMode {
  @JsonValue('manual-action')
  manual,
  @JsonValue('automatic-action')
  automatic;
}

enum SendingMode {
  @JsonValue('mdn-sent-manually')
  manually,
  @JsonValue('mdn-sent-automatically')
  automatically;
}

enum DispositionType {
  deleted,
  dispatched,
  displayed,
  processed;
}