import 'package:dartzz_meta/dartzz_meta.dart';

import '../common/kind.dart';

@higherKindMarker(1)
abstract class ForId {}

class Id<A> extends Kind<ForId, A> {
  final A value;

  const Id(this.value);
}

extension ExIdFixable<A> on Kind<ForId, A> {
  Id<A> fix() {
    return this as Id<A>;
  }
}
