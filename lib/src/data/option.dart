import '../common/kind.dart';

abstract class ForOption {}

abstract class Option<A> extends Kind<ForOption, A> {
  const Option();

  B foldOption<B>(B onNone(), B onSome(A a));
}

extension ExOptionFixable<A> on Kind<ForOption, A> {
  Option<A> fix() { return this as Option<A>; }
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
  int get hashCode { return 1; }
}

class Some<A> extends Option<A> {
  final A value;

  const Some(this.value);

  @override
  B foldOption<B>(B onNone(), B onSome(A a)) {
    return onSome(value);
  }

  @override
  bool operator ==(other) {
    return (other is Some<A>) ? value == other.value : false;
  }

  @override
  int get hashCode {
    return value.hashCode;
  }
}