import 'package:meta/meta.dart';

import 'listk.dart';

@immutable
class IntRange {
  final int start;
  final int length;

  const IntRange(this.start, this.length);

  ListK<int> toList() {
    var res = <int>[];
    final end = start + length;
    for (var i = start; i < end; ++i) {
      res.add(i);
    }

    return ListK<int>(res);
  }
}
