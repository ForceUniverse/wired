import 'package:unittest/unittest.dart';
import 'package:force_it/force_it.dart';

main() {  
  // First tests! 
  ApplicationContext.bootstrap();
  
  test('lookup SomeComp', () {
    var bean = ApplicationContext.components.first;
    DoSomeComp dsc = bean;
    expect(dsc.someCalc(), 9);
  });
}

@Config()
class SomeConfig {
  
  @Bean()
  Counter counter() {
    return new Counter();
  }
  
  @Bean()
  Calc calc() {
    return new Calc();
  }
  
}

@Component()
class DoSomeComp {
  
  @Autowired()
  Calc calc;
  
  int someCalc () {
    calc.counter.increase();
    calc.counter.increase();
    calc.counter.increase();
    
    return calc.multiply();
  }
}

class Calc {
  
  @Autowired()
  Counter counter;
  
  int multiply() => (counter.value() * counter.value());

}

class Counter {
  
   int count = 0;
  
   int value() {
      return count;
   }
   
   void increase() {
     count++;
   }
   
   void decrease() {
     count--;
   }
}