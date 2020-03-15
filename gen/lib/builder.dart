import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/case_classes_generator.dart';

Builder caseClassesBuilder(BuilderOptions options) =>
  SharedPartBuilder([CaseClassesGenerator()], "caseclasses");