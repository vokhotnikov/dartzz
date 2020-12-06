import 'package:dartzz_core/dartzz_core.dart';

import 'codegen_model.dart';

Option<ReferencedType> _resolveTypeSubstitutions(
    Func1<Option<ReferencedType>, ReferencedType> resolver,
    ReferencedType source) {
  final substitutedArgs =
      source.typeArgs.map((a1) => _resolveTypeSubstitutions(resolver, a1));
  if (substitutedArgs.flatten().isEmpty) {
    return resolver(source);
  }

  final newArgs = source.typeArgs
      .zipWith(substitutedArgs)
      .map((p) => p.it2.getOrElse(p.it1));

  final newType = ReferencedType(source.name, newArgs);
  return resolver(newType).getOrElse(newType).some();
}

ReferencedType withTypeSubstitution(
    Func1<Option<ReferencedType>, ReferencedType> resolver,
    ReferencedType source) {
  return _resolveTypeSubstitutions(resolver, source).getOrElse(source);
}

Func1<Option<ReferencedType>, ReferencedType> _compositeSubstitution(
    ListK<Func1<Option<ReferencedType>, ReferencedType>> substitutions) {
  return (t) => substitutions
      .map((s) => s(t))
      .flatten()
      .headOption(); // TODO should be lazy evaluated
}

Func1<Option<ReferencedType>, ReferencedType> _literalTypeSubstitution(
    ReferencedType from, ReferencedType to) {
  return (t) => (t == from) ? to.some() : none();
}

Func1<Option<ReferencedType>, ReferencedType> _kindedTypeSubstitution() {
  return (t) => (t.name == "Kind" &&
          t.typeArgs.length >= 2 &&
          t.typeArgs
              .headOption()
              .map((a) => a.name.startsWith("For"))
              .getOrElse(false))
      ? zz.forOption.applicative.map2(
          t.typeArgs.headOption(),
          t.typeArgs.tailOption(),
          (ReferencedType ha, ListK<ReferencedType> ta) =>
              ReferencedType(ha.name.substring(3), ta))
      : none();
}

ReferencedType substituteTypes(
        ListK<Tuple2<ReferencedType, ReferencedType>> mapping,
        ReferencedType source) =>
    withTypeSubstitution(
        _compositeSubstitution(
            mapping.map((m) => _literalTypeSubstitution(m.it1, m.it2))),
        source);

ReferencedType fixHigherKinds(ReferencedType source) =>
    withTypeSubstitution(_kindedTypeSubstitution(), source);

Option<FunctionOrMethod> applyFuncTypeSubstitutions(
    Func1<Option<ReferencedType>, ReferencedType> resolver,
    FunctionOrMethod f) {
  final newReturnType = _resolveTypeSubstitutions(resolver, f.returnType);
  final resolvedParameters = f.parameters.map((p) =>
      _resolveTypeSubstitutions(resolver, p.type)
          .map((nt) => FunctionParameter(p.name, nt)));

  return newReturnType.isEmpty && resolvedParameters.flatten().isEmpty
      ? none()
      : FunctionOrMethod(
              f.name,
              newReturnType.getOrElse(f.returnType),
              f.genericParams,
              resolvedParameters
                  .zipWith(f.parameters)
                  .map((p) => p.it1.getOrElse(p.it2)),
              f.body,
              f.returnsHigherKinded)
          .some();
}

FunctionOrMethod removeFuncTypeParameters(
    ListK<String> toRemove, FunctionOrMethod f) {
  final toRemoveSet = Set.from(toRemove.toList());

  final newTypeParams =
      f.genericParams.filter((a) => !toRemoveSet.contains(a.name));

  return (f.genericParams.length == newTypeParams.length)
      ? f
      : FunctionOrMethod(f.name, f.returnType, newTypeParams, f.parameters,
          f.body, f.returnsHigherKinded);
}

Option<ReferencedType> higherKindMarkerToGenericKind(
    ReferencedType maybeMarkerType) {
  // TODO this would likely need to be changed to something more robust
  if (maybeMarkerType.typeArgs.isEmpty &&
      maybeMarkerType.name.startsWith("For")) {
    return ReferencedType(
            "Kind",
            <ReferencedType>[
              maybeMarkerType,
              ReferencedType("A", <ReferencedType>[].k())
            ].k())
        .some();
  } else
    return none();
}
