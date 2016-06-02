import 'package:unittest/unittest.dart';
import 'package:wired/wired.dart';
import 'package:yaml/yaml.dart';

const String yamlString = '''
value:
  level:
    nesting: 'with value'
    another: 'wohooo'
iterable:
- val1
- val2
stringliteral: 'has a value'
numbervalue: 42
''';

main() {
  group('YAML complex values', () {
    setUp(() {
      ApplicationContext.registerMessage('configyaml', yamlString);
    });

    test('can read string key', () {
      String value = ApplicationContext.getValue('stringliteral');
      expect(value, isNotNull);
    });

    test('can read int key', () {
      int value = ApplicationContext.getValue('numbervalue');
      expect(value, isNotNull);
    });

    test('can read map key', () {
      YamlMap map = ApplicationContext.getValue('value');
      expect(map.containsKey('level'), isTrue);
    });

    test('can read list key', () {
      YamlList list = ApplicationContext.getValue('iterable');
      expect(list, hasLength(2));
    });
  });

  group('Complex @Value types', () {
    setUp(() {
      ApplicationContext.bootstrap();
    });

    test('interable assigned', () {
      ListPrinter printer = ApplicationContext.getBeanByType(ListPrinter);
      expect(printer.getPrintable(), allOf(
          contains('val1'),
          contains('val2')
      ));
    });
    test('map assigned', () {
      MapPrinter printer = ApplicationContext.getBeanByType(MapPrinter);
      expect(printer.getPrintable(), allOf(
          contains('level'),
          contains('another'),
          contains('with value')
      ));
    });
  });
}

class ListPrinter {
  final List list;
  ListPrinter(this.list);

  String getPrintable() {
    return '[${list.join(', ')}]';
  }
}

class MapPrinter {
  final Map map;
  MapPrinter(this.map);

  String getPrintable() {
    StringBuffer buffer = new StringBuffer();
    map.forEach((key, val) {
      buffer.write('{ $key: $val }');
    });
    return buffer.toString();
  }
}

@Config
class SomeConfig {
  @Value("iterable")
  List listVal;

  @Value('value')
  Map mapVal;

  @Bean
  ListPrinter listPrinter() {
    return new ListPrinter(listVal);
  }

  @Bean
  MapPrinter mapPrinter() {
    return new MapPrinter(mapVal);
  }
}