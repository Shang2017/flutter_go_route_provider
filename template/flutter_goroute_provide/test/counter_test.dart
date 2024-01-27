import 'package:flutter_application_6/counter.dart';
import 'package:test/test.dart';

void main() {
  test('Counter value should be incremented',() {
    final counter = Counter();
    counter.increment();
    expect(counter.value,1);
  });
  group('Test start,increment,decrement',(){
    test('value should start at 0',(){
      expect(Counter().value,0);
    });
    test('value should incremented',(){
      final counter = Counter();
      counter.increment();
      expect(counter.value,1);
    });
  });
}
