import '../../common/helpers.dart';
import '../option.dart';

extension OptionOpsExt<A> on Option<A> {
  A getOrElse(A def) => this.foldOption(() => def, identity);
}