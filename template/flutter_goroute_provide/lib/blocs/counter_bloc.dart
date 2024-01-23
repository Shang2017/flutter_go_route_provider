import 'dart:async';
import 'bloc_base.dart';

class CounterBloc extends BlocBase {
  final _controller = StreamController<int>();
  get counterSink => _controller.sink;
  get counterStream => _controller.stream;

  void increament(int count) {
    counterSink.add(++count);
  }

  void readData() async {
    int count=0;

  
  //StringBuffer buffer = StringBuffer();
 
   Timer.periodic(Duration(milliseconds: 10), (timer) {
    
            increament(++count);
        });
  }

  
  void dispose() {
    _controller.close();
  }
  
}