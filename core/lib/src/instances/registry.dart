import 'int_instances.dart';
import 'id_instances.dart';
import 'option_instances.dart';
import 'either_instances.dart';
import 'listk_instances.dart';

class InstanceRegistry {
  const InstanceRegistry();

  final forInt = const IntInstances();

  final forId = const IdInstances();
  final forOption = const OptionInstances();
  final forListK = const ListKInstances();

  EitherInstances<L> forEither<L>() {
    return EitherInstances<L>();
  }
}

const zz = InstanceRegistry();