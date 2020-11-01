import '../either.dart';

extension EitherOpsExt<A, B> on Either<A, B> {
  bool get isLeft => this.foldEither((a) => true, (b) => false);
  bool get isRight => this.foldEither((a) => false, (b) => true);
}
