import 'package:equatable/equatable.dart';

class UrlJmap with EquatableMixin {
  final String value;

  UrlJmap(this.value);

  @override
  List<Object?> get props => [value];
}