import '../common/kind.dart';
import 'package:dartzz_meta/dartzz_meta.dart';

@higherKindMarker(2)
abstract class ForEither {}

abstract class Either<A, B> extends Kind<Kind<ForEither, A>, B> {
  const Either();

  C foldEither<C>(C onLeft(A a), C onRight(B b));
}

extension EitherFixableExt<A, B> on Kind<Kind<ForEither, A>, B> {
  Either<A, B> fix() {
    return this as Either<A, B>;
  }
}

class Left<A, B> extends Either<A, B> {
  final A value;

  const Left(this.value);

  @override
  C foldEither<C>(C onLeft(A a), C onRight(B b)) {
    return onLeft(value);
  }

  @override
  bool operator ==(Object other) => other is Left<A, B> && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class Right<A, B> extends Either<A, B> {
  final B value;

  const Right(this.value);

  @override
  C foldEither<C>(C onLeft(A a), C onRight(B b)) {
    return onRight(value);
  }

  @override
  bool operator ==(Object other) =>
      other is Right<A, B> && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
