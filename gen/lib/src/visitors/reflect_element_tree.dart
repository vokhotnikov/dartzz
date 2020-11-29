import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ElementWithLevel {
  final Element element;
  final int depthLevel;

  const ElementWithLevel(this.element, this.depthLevel);
}

class ReflectElementTreeVisitor extends GeneralizingElementVisitor {
  final Element root;
  List<ElementWithLevel> result = [];

  ReflectElementTreeVisitor(this.root);

  int _elementLevel(Element element) {
    int res = 0;
    var el = element;
    while (!identical(el, root) && res < 100) {
      ++res;
      el = el.enclosingElement;
    }

    return res;
  }

  @override
  visitElement(Element element) {
    result.add(ElementWithLevel(element, _elementLevel(element)));
    return super.visitElement(element);
  }
}
