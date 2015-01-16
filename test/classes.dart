import 'package:wired/wired.dart';

@Component()
class DoSomeComp {
  
  @Autowired
  Calc calc;
  
  int someCalc () {
    calc.counter.increase();
    calc.counter.increase();
    calc.counter.increase();
    
    return calc.multiply();
  }
}

class Calc {
  
  @Autowired
  Counter counter;
  
  int multiply() => (counter.value() * counter.value());

}

class Counter {
  
   int count = 0;
  
   Counter({this.count: 0});
   
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

class UpperCase {
  
  String value;
  
  UpperCase(this.value) {
    this.value = this.value.toUpperCase();   
  }
 
}
