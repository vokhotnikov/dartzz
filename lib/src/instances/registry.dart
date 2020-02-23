import 'int_instances.dart';
import 'option_instances.dart';

class InstanceRegistry {
  const InstanceRegistry();

  final forInt = const IntInstances();

  final forOption = const OptionInstances();


}

const zz = InstanceRegistry();