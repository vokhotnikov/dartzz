import 'dart:math';

import 'package:test/test.dart';
import 'package:dartzz_core/dartzz_core.dart';

import '../lib/src/typeclasses.dart';
import '../lib/src/string_instances.dart';
import '../lib/src/option_instances.dart';

void main() {
  test("basic syntax enrichments", () {
    expect("abc".some().asString(), equals("some abc"));
    expect(1.some().xmap((i) => i + 1), equals(2.some()));

    expect(2.some().xfmap((i) => i > 0, (i) => -i), equals((-2).some()));
  });
}
