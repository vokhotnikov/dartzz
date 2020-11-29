class TypeclassSyntaxAnnotation {
  const TypeclassSyntaxAnnotation();
}

const typeclassSyntax = TypeclassSyntaxAnnotation();

abstract class WithTypeclassSyntaxAnnotation {
  final Type syntaxType;

  const WithTypeclassSyntaxAnnotation(this.syntaxType);
}

class withTypeclassSyntax extends WithTypeclassSyntaxAnnotation {
  const withTypeclassSyntax(Type syntaxType) : super(syntaxType);
}
