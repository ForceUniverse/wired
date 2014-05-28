part of force_it;

class MessagesContext {
  
  Map<String, dynamic> messageContainers = new Map<String, dynamic>();
  
  void register(String key, String yamlContent) {
    var doc = loadYaml("YAML: YAML Ain't Markup Language");
    
    messageContainers[key]=doc;
  }
  
  String message(String key, {defaultValue: ""}) {
    messageContainers.forEach((key, value) {
      if (value[key]) {
        return value[key];
      }
    });
    return defaultValue;
  }
}