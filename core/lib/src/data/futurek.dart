import 'package:dartzz_meta/dartzz_meta.dart';

import '../common/kind.dart';

@higherKindMarker(1)
abstract class ForFutureK<A> {}

class FutureK<A> implements Kind<ForFutureK, A> {
  final Future<A> _wrapped;

  const FutureK(this._wrapped);

  Future<A> toFuture() {
    return _wrapped;
  }
}

extension FutureKFixableExt<A> on Kind<ForFutureK, A> {
  FutureK<A> fix() {
    return this as FutureK<A>;
  }
}
