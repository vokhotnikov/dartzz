import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

import 'package:dartzz_core/dartzz_core.dart';

class _ExtractChildrenOfTypeVisitor<T extends Element> extends GeneralizingElementVisitor {
  List<T> elements = [];

  @override 
  visitElement(Element element) {
    if (element is T) {
      elements.add(element);
    }

    return super.visitElement(element);
  }
}

extension ElementExt on Element {
  ListK<T> listChildren<T extends Element>() {
    final visitor = _ExtractChildrenOfTypeVisitor<T>();
    this.visitChildren(visitor);
    return List<T>.unmodifiable(visitor.elements).k();
  }
}

