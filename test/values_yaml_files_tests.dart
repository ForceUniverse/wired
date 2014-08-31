import 'dart:io';
import 'package:unittest/unittest.dart';
import 'package:wired/wired.dart';
import 'classes.dart';

main() {  
  var _basePath = new File(Platform.script.toFilePath());
       var valuesUri = new Uri.file(_basePath.path).resolve("app.yaml");
       var file = new File(valuesUri.toFilePath());
       file.readAsBytes().then((data) {
            var yaml = new String.fromCharCodes(data);
                
            ApplicationContext.registerMessage("app", yaml);
            ApplicationContext.bootstrap();
            
            test('named bean', () {
                var bean = ApplicationContext.getBean("upperCase");
                UpperCase dsc = bean;
                expect(dsc.value, "FORCE");
              });
       });
}

@Config
class SomeConfig {
  
  @Value("framework")
  String framework;
  
  @Bean
  UpperCase upperCase() {
    return new UpperCase(framework);
  } 
  
}