import 'package:unittest/unittest.dart';
import 'package:wired/wired.dart';

main() {  
  // First tests! 
  ApplicationContext.bootstrap();
  
  test('depencency tree test', () {
    var bean = ApplicationContext.getBeanByType(D);
    D d = bean;
    expect(d.toString(), "D with A, B with A, C");
  });
}

@Config
class SomeConfig {
  
  @Bean
  D varD() {
    return new D();
  }
  
  @Bean
  A varA() {
    return new A();
  }
  
  @Bean
  B varB() {
    return new B();
  }
  
  @Bean
  C varC() {
    return new C();
  }
}

class A {
  
  String toString() {
    return "A";
  }
  
}

class B {
  
  @Autowired
  A varA;
  
  String toString() {
    return "B with $varA";
  }
  
}

class C {
  
  String toString() {
    return "C";
  }
  
}

class D {
  
  @Autowired
  A varA;
  
  @Autowired
  B varB;
  
  @Autowired
  C c;
  
  String toString() {
    return "D with $varA, $varB, $c";
  }
  
}