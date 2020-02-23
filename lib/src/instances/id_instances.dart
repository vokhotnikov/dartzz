import 'package:dartzz/dartzz.dart';
import 'package:dartzz/src/common/kind.dart';

import '../data/id.dart';
import '../typeclasses/applicative.dart';

class _ApplicativeForIdInstance extends Applicative<ForId> {
  const _ApplicativeForIdInstance();

  @override
  Kind<ForId, B> ap<A, B>(Kind<ForId, MapAction<A, B>> ff, Kind<ForId, A> fa) {
    return Id(ff.fix().value(fa.fix().value));
  }

  @override
  Kind<ForId, A> pure<A>(A a) {
    return Id(a);
  }

}

class IdInstances {
  const IdInstances();

  final Applicative<ForId> applicative = const _ApplicativeForIdInstance();
  final Functor<ForId> functor = const _ApplicativeForIdInstance();
}