import 'package:flutter/material.dart';
import 'bloc_base.dart';


Type _typeOf<T>() => T;


class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key? key,
    required this.child,
    required this.blocs,
 
  }):super(key:key);

  final Widget child;
  final List<T> blocs;
 

  @override
  BlocProviderState<T> createState() => BlocProviderState<T>();

  static List<T> of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProviderInherited<T>>();

    
   final InheritedElement? inheritedElement = context.getElementForInheritedWidgetOfExactType<BlocProviderInherited<T>>();
   

   BlocProviderInherited<T>? provider = inheritedElement!.widget as BlocProviderInherited<T>?;

   
    return provider!.blocs;
  }
}

class BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {

  @override
  void dispose() {
    widget.blocs.map((bloc){ 
      bloc.dispose();
    });    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderInherited<T>(
      blocs: widget.blocs,
      child: widget.child,
    );
  }
}

class BlocProviderInherited<T> extends InheritedWidget {
  const BlocProviderInherited({
    Key? key,
    required Widget child,
    required this.blocs,
  }) : super(key: key, child: child);

  final List<T> blocs;

  @override
  bool updateShouldNotify(BlocProviderInherited<T> oldWidget) => false;
}


/* import 'package:flutter/material.dart';

// Generic Interface for all BLoCs
abstract class BlocBase {
  void dispose();
}

// Generic BLoC provider
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  const BlocProvider({
    super.key,
    required this.child,
    required this.bloc,
  });

  final T bloc;
  final Widget child;

  @override
  State<BlocProvider<BlocBase>> createState() => _BlocProviderState<T>();

  static T? of<T extends BlocBase>(BuildContext context) {
    BlocProvider<T>? provider =
        context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider?.bloc;
  }
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
 */