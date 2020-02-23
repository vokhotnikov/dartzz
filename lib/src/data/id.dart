import '../common/kind.dart';

abstract class ForId { }

class Id<A> extends Kind<ForId, A>{
  final A value;

  const Id(this.value);
}

extension ExIdFixable<A> on Kind<ForId, A> {
  Id<A> fix() { return this as Id<A>; }
}