import 'package:flutter_test/flutter_test.dart';

void main() {
  group("blob not found", () {
    final requesttoparse = {
      "using": [
        "urn:ietf:params:jmap:core",
        "com:linagora:params:calendar:event"
      ],
      "methodCalls": [
        [
          "CalendarEvent/parse",
          {
            "accountId":
                "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
            "blobIds": ["037aaad3-17c9-47c8-bd6b-f2cbfe925ef7"]
          },
          "c1"
        ]
      ]
    };

    final response1 = {
      "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
      "methodResponses": [
        [
          "CalendarEvent/parse",
          {
            "accountId":
                "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
            "notFound": ["037aaad3-17c9-47c8-bd6b-f2cbfe925ef7"]
          },
          "c1"
        ]
      ]
    };
  });
}
