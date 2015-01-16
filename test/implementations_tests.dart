import 'package:unittest/unittest.dart';
import 'package:wired/wired.dart';

main() {  
  // First tests! 
  ApplicationContext.bootstrap();
  
  test('depencency tree test', () {
    var bean = ApplicationContext.getBeanByType(ASuper);
    ASuper d = bean;
    expect(d.name(), "BSuper");
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
