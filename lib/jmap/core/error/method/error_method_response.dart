import 'package:jmap_dart_client/jmap/core/error/error_type.dart';
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';

abstract class ErrorMethodResponse extends MethodResponse {
  static final errorMethodName = MethodName("error");
  static final serverPartialFail = ErrorType("serverPartialFail");
  static final serverUnavailable = ErrorType("serverUnavailable");
  static final serverFail = ErrorType("serverFail");
  static final unknownMethod = ErrorType("unknownMethod");
  static final invalidArguments = ErrorType("invalidArguments");
  static final invalidResultReference = ErrorType("invalidResultReference");
  static final forbidden = ErrorType("forbidden");
  static final accountNotFound = ErrorType("accountNotFound");
  static final accountNotSupportedByMethod = ErrorType("accountNotSupportedByMethod");
  static final accountReadOnly = ErrorType("accountReadOnly");

  final ErrorType type;
  final String? description;

  ErrorMethodResponse(this.type, {this.description});

  @override
  List<Object?> get props => [type, description];
}

class ServerPartialFailMethodResponse extends ErrorMethodResponse {
  ServerPartialFailMethodResponse({String? description}) : super(ErrorMethodResponse.serverPartialFail, description: description);
}

class ServerUnavailableMethodResponse extends ErrorMethodResponse {
  ServerUnavailableMethodResponse({String? description}) : super(ErrorMethodResponse.serverUnavailable, description: description);
}

class ServerFailMethodResponse extends ErrorMethodResponse {
  ServerFailMethodResponse({String? description}) : super(ErrorMethodResponse.serverFail, description: description);
}

class UnknownMethodResponse extends ErrorMethodResponse {
  UnknownMethodResponse({String? description}) : super(ErrorMethodResponse.unknownMethod, description: description);
}

class InvalidArgumentsMethodResponse extends ErrorMethodResponse {
  InvalidArgumentsMethodResponse({String? description}) : super(ErrorMethodResponse.invalidArguments, description: description);
}

class InvalidResultReferenceMethodResponse extends ErrorMethodResponse {
  InvalidResultReferenceMethodResponse({String? description}) : super(ErrorMethodResponse.invalidResultReference, description: description);
}

class ForbiddenMethodResponse extends ErrorMethodResponse {
  ForbiddenMethodResponse({String? description}) : super(ErrorMethodResponse.forbidden, description: description);
}

class AccountNotFoundMethodResponse extends ErrorMethodResponse {
  AccountNotFoundMethodResponse({String? description}) : super(ErrorMethodResponse.accountNotFound, description: description);
}

class AccountNotSupportedByMethod extends ErrorMethodResponse {
  AccountNotSupportedByMethod({String? description}) : super(ErrorMethodResponse.accountNotSupportedByMethod, description: description);
}

class AccountReadOnly extends ErrorMethodResponse {
  AccountReadOnly({String? description}) : super(ErrorMethodResponse.accountReadOnly, description: description);
}