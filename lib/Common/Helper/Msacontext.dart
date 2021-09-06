import 'package:behtarino/Common/Variebles/Constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

BuildContext Msacontext() {
  return navigatorKey.currentContext!;
}

GlobalKey<NavigatorState> MsaNavigatorState() {
  return navigatorKey;
}

// class Second extends BuildContext {
//   @override
//   // TODO: implement debugDoingBuild
//   bool get debugDoingBuild => throw UnimplementedError();

//   @override
//   InheritedWidget dependOnInheritedElement(InheritedElement ancestor,
//       {Object? aspect}) {
//     // TODO: implement dependOnInheritedElement
//     throw UnimplementedError();
//   }

//   @override
//   T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>(
//       {Object? aspect}) {
//     // TODO: implement dependOnInheritedWidgetOfExactType
//     throw UnimplementedError();
//   }

//   @override
//   DiagnosticsNode describeElement(String name,
//       {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.errorProperty}) {
//     // TODO: implement describeElement
//     throw UnimplementedError();
//   }

//   @override
//   List<DiagnosticsNode> describeMissingAncestor(
//       {required Type expectedAncestorType}) {
//     // TODO: implement describeMissingAncestor
//     throw UnimplementedError();
//   }

//   @override
//   DiagnosticsNode describeOwnershipChain(String name) {
//     // TODO: implement describeOwnershipChain
//     throw UnimplementedError();
//   }

//   @override
//   DiagnosticsNode describeWidget(String name,
//       {DiagnosticsTreeStyle style = DiagnosticsTreeStyle.errorProperty}) {
//     throw UnimplementedError();
//   }

//   @override
//   T? findAncestorRenderObjectOfType<T extends RenderObject>() {
//     throw UnimplementedError();
//   }

//   @override
//   T? findAncestorStateOfType<T extends State<StatefulWidget>>() {
//     throw UnimplementedError();
//   }

//   @override
//   T? findAncestorWidgetOfExactType<T extends Widget>() {
//     throw UnimplementedError();
//   }

//   @override
//   RenderObject? findRenderObject() {
//     throw UnimplementedError();
//   }

//   @override
//   T? findRootAncestorStateOfType<T extends State<StatefulWidget>>() {
//     throw UnimplementedError();
//   }

//   @override
//   InheritedElement?
//       getElementForInheritedWidgetOfExactType<T extends InheritedWidget>() {
//     throw UnimplementedError();
//   }

//   @override
//   BuildOwner? get owner => throw UnimplementedError();

//   @override
//   Size? get size => throw UnimplementedError();

//   @override
//   void visitAncestorElements(bool Function(Element element) visitor) {
//     // TODO: implement visitAncestorElements
//   }

//   @override
//   void visitChildElements(ElementVisitor visitor) {
//     // TODO: implement visitChildElements
//   }

//   @override
//   // TODO: implement widget
//   Widget get widget => throw UnimplementedError();
// }

NavigatorState MsaNavigator(BuildContext? context) {
  return navigatorKey.currentState ?? Navigator.of(context!);
}
