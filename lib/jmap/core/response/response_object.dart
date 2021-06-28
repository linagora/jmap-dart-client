import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/response_invocation_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/response/response_invocation.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_object.g.dart';

@StateConverter()
@ResponseInvocationConverter()
@JsonSerializable()
class ResponseObject with EquatableMixin {
  final List<ResponseInvocation> methodResponses;
  final State sessionState;

  ResponseObject(this.methodResponses, this.sessionState);

  factory ResponseObject.fromJson(Map<String, dynamic> json) => _$ResponseObjectFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseObjectToJson(this);

  T? parse<T extends MethodResponse>(MethodCallId methodCallId, T fromJson(Map<String, dynamic> o)) {
    try {
      final matchedResponse = methodResponses.firstWhere((method) => method.methodCallId == methodCallId);
      return fromJson(matchedResponse.arguments.value);
    } catch(error) {
      developer.log('$error');
      return null;
    }
  }

  @override
  List<Object?> get props => [methodResponses, sessionState];
}