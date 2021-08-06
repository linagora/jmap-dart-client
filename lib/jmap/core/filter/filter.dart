import 'package:equatable/equatable.dart';

abstract class Filter with EquatableMixin {
  Map<String, dynamic> toJson();
}