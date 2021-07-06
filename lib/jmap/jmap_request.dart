import 'dart:collection';

import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/core/response/response_object.dart';
import 'package:jmap_dart_client/util/util.dart';

import 'core/capability/capability.dart';
import 'core/method/method.dart';
import 'core/request/request_invocation.dart';
import 'core/request/request_object.dart';

class JmapRequest {
  final HttpClient _httpClient;
  final Set<CapabilityIdentifier> _capabilities;
  final Map<MethodCallId, RequestInvocation> _invocations;
  
  JmapRequest(this._httpClient, this._capabilities, this._invocations);
  
  RequestObject? _requestObject;
  RequestObject? get requestObject => _requestObject;

  Future<ResponseObject> execute() async {
    _requestObject = (RequestObject.builder()
        ..usings(_capabilities)
        ..methodCalls(_invocations.values.toList()))
        .build();

    return _httpClient.post('/jmap', data: _requestObject?.toJson())
      .then((value) => extractData(value))
      .catchError((error) => throw error);
  }

  ResponseObject extractData(Map<String, dynamic> body) {
    return ResponseObject.fromJson(body);
  }
}

class JmapRequestBuilder {
  final HttpClient _httpClient;
  final ProcessingInvocation _processingInvocation;
  final Set<CapabilityIdentifier> _capabilities = HashSet.identity();

  JmapRequestBuilder(this._httpClient, this._processingInvocation);

  void call(Method method, {MethodCallId? methodCallId}) {
    final callId = methodCallId ?? _processingInvocation.generateMethodCallId();
    final RequestInvocation invocation = RequestInvocation(
        method.methodName,
        Arguments(method),
        callId
    );
    _processingInvocation.addMethod(callId, invocation);
  }

  void usings(Set<CapabilityIdentifier> capabilityIdentifiers) {
    _capabilities.addAll(capabilityIdentifiers);
  }

  JmapRequest build() {
    return JmapRequest(_httpClient, _capabilities, _processingInvocation._invocations);
  }
}

class ProcessingInvocation {
  static const String methodCallIdPrefix = 'c';
  late final Map<MethodCallId, RequestInvocation> _invocations;

  ProcessingInvocation() {
    _invocations = LinkedHashMap.identity();
  }

  MethodCallId generateMethodCallId() {
    return positiveIntegers
      .map((item) => MethodCallId(methodCallIdPrefix + item.toString()))
      .firstWhere((callId) => !_invocations.keys.contains(callId));
  }

  void addMethod(MethodCallId callId, RequestInvocation requestInvocation) {
    _invocations.addAll({callId: requestInvocation});
  }
}
