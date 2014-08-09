import 'package:unittest/unittest.dart';
import 'package:force_it/force_it.dart';
import 'classes.dart';

main() {  
  // First tests! 
  ApplicationContext.bootstrap();
  
  test('order SomeComp', () {
    var bean = ApplicationContext.components.first;
    DoSomeComp dsc = bean;
    expect(dsc.someCalc(), 9);
  });
}

@Config
class SomeConfig {
  
  @Bean
  Calc calc() {
    return new Calc();
  }
  
  @Bean
  Counter counter() {
    return new Counter();
  }
  
}