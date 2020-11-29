import 'package:meta/meta.dart';
import 'package:dartzz_meta/dartzz_meta.dart';
import 'package:dartzz_core/dartzz_core.dart';

import 'typeclasses.dart';
import 'option_instances.dart';

part 'string_instances.zzsyntax.dart';

@immutable
@typeclassInstance
class StringInstanceForTesting extends TypeclassForTesting<String> {
  const StringInstanceForTesting();

  @override
  bool equalTo(String me, String other) {
    return me == other;
  }

  @override
  String toStr(String me) {
    return me;
  }
}

// expected to generate:
/*
extension String__TypeclassForTesting__Ext on String {
  static const syntax = TypeclassForTestingSyntax(StringInstanceForTesting());

  bool isEqTo(String other) =>
      String__TypeclassForTesting__Ext.syntax.isEqTo(this, other);

  String asString() => String__TypeclassForTesting__Ext.syntax.asString(this);
}
*/

extension Option_String__TypeclassForTesting__Ext on Option<String> {
  static const syntax = TypeclassForTestingSyntax(
      OptionInstanceForTesting<String>(StringInstanceForTesting()));

  bool isEqTo(Option<String> other) =>
      Option_String__TypeclassForTesting__Ext.syntax.isEqTo(this, other);

  String asString() =>
      Option_String__TypeclassForTesting__Ext.syntax.asString(this);
}
