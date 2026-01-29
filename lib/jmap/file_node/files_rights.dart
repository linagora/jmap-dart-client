import 'package:equatable/equatable.dart';

class FilesRights with EquatableMixin {
  final bool mayRead;
  final bool mayWrite;
  final bool mayShare;

  FilesRights({
    required this.mayRead,
    required this.mayWrite,
    required this.mayShare,
  });

  factory FilesRights.fromJson(Map<String, dynamic> json) => FilesRights(
        mayRead: json['mayRead'] as bool? ?? false,
        mayWrite: json['mayWrite'] as bool? ?? false,
        mayShare: json['mayShare'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'mayRead': mayRead,
        'mayWrite': mayWrite,
        'mayShare': mayShare,
      };

  @override
  List<Object?> get props => [
        mayRead,
        mayWrite,
        mayShare,
      ];
}
