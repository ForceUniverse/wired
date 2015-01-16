import 'package:unittest/unittest.dart';
import 'package:wired/wired.dart';

main() {  
  // First tests! 
  ApplicationContext.bootstrap();
  
  test('depencency tree test', () {
    var bean = ApplicationContext.getBeanByType(ASuper);
    ASuper d = bean;
    expect(d.name(), "C ...");
  });
}

@Config
class SomeConfig {
  
  @Bean
  ASuper asuper() {
    return new C();
  }

}

class ASuper {
  String name() => "ASuper";
}

class BeSuper extends ASuper {
  String name() => "BSuper";
}

class C extends BeSuper {
  String name() => "C ...";
}