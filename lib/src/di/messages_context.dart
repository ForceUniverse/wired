part of wired;

class MessagesContext {
  
  Map<String, dynamic> messageContainers = new Map<String, dynamic>();
  List<dynamic> messages = new List<dynamic>();
  
  void register(String key, String yamlContent) {
    var doc = loadYaml(yamlContent);
    
    messageContainers[key]=doc;
    messages.add(doc);
  }
  
  dynamic message(String key, {defaultValue: ""}) {
    return _find(key, defaultValue);
  }
  
  dynamic _find(String key, defaultValue) {
    for (var doc in messages) {
      if (doc[key]!=null) {
        return doc[key];
      }
    }
    return defaultValue;
  }
  
}