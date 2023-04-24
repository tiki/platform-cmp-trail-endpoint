import 'dart:io';

import 'package:example/in_mem.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';
import 'package:uuid/uuid.dart';

void main(List<String> arguments) async {
    TikiSdk tikiSdk = await InMemBuilders.tikiSdk();
    String ptr = const Uuid().v4();
    TitleRecord title =
      await tikiSdk.title(ptr, tags: [TitleTag.emailAddress()]);
    print("Created a Title Record with id ${title.id} for PTR: $ptr");
    LicenseRecord first = await tikiSdk.license(
          ptr,
          [
            LicenseUse([LicenseUsecase.attribution()])
          ],
          'terms');
    print("Created a License Record with id ${first.id} for PTR: $ptr");
    tikiSdk.guard(ptr, [LicenseUsecase.attribution()],onPass: () => print(
      "There is a valid License Record for attribution use for Title Record with PTR $ptr"
    ));
    tikiSdk.guard(ptr, [LicenseUsecase.support()], onFail: (cause) => print(
        "There is no valid License Record for support use for Title Record with PTR $ptr. Cause: $cause"
    ));
    exit(0);
}
