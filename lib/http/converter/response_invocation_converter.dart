
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/response/response_invocation.dart';
import 'package:json_annotation/json_annotation.dart';

class ResponseInvocationConverter implements JsonConverter<ResponseInvocation, List<dynamic>> {
  const ResponseInvocationConverter();

  @override
  ResponseInvocation fromJson(List<dynamic> json) {
    if (json.length == 3) {
      return ResponseInvocation(
        MethodName(json[0]),
        ResponseArguments(json[1]),
        MethodCallId(json[2]));
    } else {
      throw Exception("Wrong response invocation");
    }
  }

  @override
  List toJson(ResponseInvocation object) {
    return List.of({object.methodName, object.arguments, object.methodCallId});
  }
}