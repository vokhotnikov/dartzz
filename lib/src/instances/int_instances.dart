import '../typeclasses/show.dart';

class _ShowForIntInstance extends ShowFromToString<int> {
  const _ShowForIntInstance();
}

class IntInstances {
  const IntInstances();

  final Show<int> show = const _ShowForIntInstance();
}