import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'files_rights.g.dart';

@JsonSerializable()
class FilesRights with EquatableMixin {
  final bool mayRead;
  final bool mayWrite;
  final bool mayShare;

  const FilesRights({
    required this.mayRead,
    required this.mayWrite,
    required this.mayShare,
  });

  factory FilesRights.fromJson(Map<String, dynamic> json) =>
      _$FilesRightsFromJson(json);

  Map<String, dynamic> toJson() => _$FilesRightsToJson(this);

  @override
  List<Object?> get props => [
        mayRead,
        mayWrite,
        mayShare,
      ];
}
