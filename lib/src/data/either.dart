import '../common/kind.dart';

abstract class ForEither {}

abstract class Either<A, B> extends Kind<Kind<ForEither, A>, B> {
  const Either();

  C foldEither<C>(C onLeft(A a), C onRight(B b));
}

extension EitherFixableExt<A, B> on Kind<Kind<ForEither, A>, B> {
  Either<A, B> fix() { return this as Either<A, B>; }
}

class Left<A, B> extends Either<A, B> {
  final A value;

  const Left(this.value);

  @override
  C foldEither<C>(C onLeft(A a), C onRight(B b)) {
    return onLeft(value);
  }
}

class Right<A, B> extends Either<A, B> {
  final B value;

  const Right(this.value);

  @override
  C foldEither<C>(C onLeft(A a), C onRight(B b)) {
    return onRight(value);
  }
}