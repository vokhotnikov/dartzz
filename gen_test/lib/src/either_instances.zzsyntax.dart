// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'either_instances.dart';

// **************************************************************************
// SyntaxEnrichmentGenerator
// **************************************************************************

// Found 1 instances
// Instance type: ReferencedType(EitherInstanceForTesting, [ReferencedType(L, [])])
// Raw instance supertype: FunctorForTesting<Kind<ForEither, L>>
// Typeclass type: ReferencedType(FunctorForTesting, [ReferencedType(Either, [ReferencedType(L, [])])])
// scheduling syntax type substitution ReferencedType(F, []) -> ReferencedType(Either, [ReferencedType(L, [])])
// Method xmap
// params: [Kind<F, A> f, B Function(A) mapper]
// param types: (Kind<F, A>, B Function(A))
// param runtime type: (InterfaceTypeImpl, FunctionTypeImpl)
//   TypeParameterElementImpl A (A)
//   TypeParameterElementImpl B (B)
//   ParameterElementImpl f (Kind<F, A> f)
//   ParameterElementImpl mapper (B Function(A) mapper)

// Subject type: ReferencedType(Either, [ReferencedType(L, [])])
// Syntax type: ReferencedType(FunctorForTestingSyntax, [ReferencedType(Either, [ReferencedType(L, [])])])
// Constructed 1 proxy extensions
// proxy will be generated here
extension Either__FunctorForTesting__Ext<L> on Either<L> {
  static const syntax =
      FunctorForTestingSyntax<Either<L>>(EitherInstanceForTesting<L>());

// methods will be here
  Kind<Either<L>, B> xmap<A, B>(Func1<B, A> mapper) =>
      syntax.xmap(this, mapper).fix();
}
