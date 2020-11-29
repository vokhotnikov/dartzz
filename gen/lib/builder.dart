import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/case_classes_generator1.dart';
import 'src/syntax_enrichment_generator.dart';

Builder caseClassesBuilder(BuilderOptions options) =>
    SharedPartBuilder([CaseClassesGenerator1()], "caseclasses");

Builder syntaxBuilder(BuilderOptions options) =>
    PartBuilder([SyntaxEnrichmentGenerator()], ".zzsyntax.dart");
// LibraryBuilder(SyntaxEnrichmentGenerator(),
// generatedExtension: ".zzsyntax.dart");
// SharedPartBuilder([SyntaxEnrichmentGenerator()], "zzsyntax");
