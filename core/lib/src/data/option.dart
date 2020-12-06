import 'package:dartzz_meta/dartzz_meta.dart';

import '../common/kind.dart';

@higherKindMarker(1)
abstract class ForOption {}

abstract class Option<A> extends Kind<ForOption, A> {
  const Option();

  B foldOption<B>(B onNone(), B onSome(A a));

  factory Option.fromNullable(A value) {
    return (value == null) ? None<A>() : Some(value);
  }
}

extension ExOptionFixable<A> on Kind<ForOption, A> {
  Option<A> fix() {
    return this as Option<A>;
  }
}

class None<A> extends Option<A> {
  const None();

  @override
  B foldOption<B>(B onNone(), B onSome(A a)) {
    return onNone();
  }

  @override
  bool operator ==(other) {
    return other is None<A>;
  }

  @override
  int get hashCode {
    return 1;
  }
}

class Some<A> extends Option<A> {
  final A value;

  const Some(this.value);

  @override
  B foldOption<B>(B onNone(), B onSome(A a)) {
    return onSome(value);
  }

  @override
  bool operator ==(other) => (other is Some<A>) && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
