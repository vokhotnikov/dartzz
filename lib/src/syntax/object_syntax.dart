import '../common/kind.dart';
import '../typeclasses/applicative.dart';

extension ObjectSyntaxExt<A> on A {
  Kind<F, A> pure<F>(Applicative<F> ev) {
    return ev.pure(this);
  }
}