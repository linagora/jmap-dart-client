import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';

class ErrorMethodResponseException with EquatableMixin implements Exception {
  final MethodResponse errorResponse;

  ErrorMethodResponseException(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];

  @override
  bool? get stringify => true;
}