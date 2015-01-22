import 'package:unittest/unittest.dart';
import 'package:wired/wired.dart';

main() {  
  // First tests! 
  ApplicationContext.bootstrap();
  
  test('depencency tree interfaces test', () {
    var bean = ApplicationContext.getBeanByType(ASuper);
    ASuper d = bean;
    expect(d.name(), "BSuper");
  });
  
  test('depencency tree interfaces difficult test', () {
      var bean = ApplicationContext.getBeanByType(AS);
      AS d = bean;
      expect(d.name(), "CCC ...");
    });
}

@Config
class SomeConfig {
  
  @Bean
  Rrr justsomething() {
    return new Rrr();
  }
  
  @Bean
  ASuper asuper() {
    return new BeSuper();
  }
  
  @Bean
  AS as() {
    return new C();
  }

}

class Rrr {
  String justsomething() => "Rrr";
}

class ASuper {
  String name() => "ASuper";
}

class BeSuper implements ASuper {
  String name() => "BSuper";
}

class AS {
  String name() => "ASuper";
}

class BeSuperNext implements AS {
  String name() => "BSuper";
}

class C extends BeSuperNext {
  String name() => "CCC ...";
}