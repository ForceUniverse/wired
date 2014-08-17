part of force_it;

class ApplicationContext {
  static Map<String, Object> _singletons = new Map<String, Object>();
  static List<Object> components = new List<Object>();
  static MessagesContext _messageContext = new MessagesContext();
  
  static void registerMessage(String key, String yamlContent) {
    _messageContext.register(key, yamlContent);
  }
  
  static void bootstrap() {
    // first bootstrap your beans
    Scanner<_Config, Object> classesHelper = new Scanner<_Config, Object>();
    List<Object> classes = classesHelper.scan();
          
    for (var obj in classes) {
        _register(_injectValue(obj));
    }
    
    // search for Components and then inject 
    Scanner<Component, Object> componentHelper = new Scanner<Component, Object>();
    
    // inject the autowired
    _singletons.forEach((key, value) {
      _inject(_injectValue(value));
    });
    
    component(componentHelper);
  }
  
  static List component(Scanner scanner) {
        List componentsScanned = scanner.scan();
                
        for (var component in componentsScanned) {
            // do something with the component
            components.add(_injectValue(component));  
        }
        
        for (var component in components) {
            // do something with the components
            _inject(component);  
        }
        return componentsScanned;
  }
  
  static Object getBean(String name) => _singletons[name];
  
  static Object _inject(Object obj) {
    MetaDataHelper<_Autowired> varMirrorHelper = new MetaDataHelper<_Autowired>();
    List<MetaDataValue<_Autowired>> varMirrorModels = varMirrorHelper.getVariableMirrorValues(obj);
          
    for(MetaDataValue<_Autowired> varMM in varMirrorModels) {
       var value = _singletons[varMM.name];
       if (value!=null) {
           varMM.instanceMirror.setField(varMM.memberName, value);
       }
    }
    return obj;
  }
  
  static Object _injectValue(Object obj) {
    MetaDataHelper<Value> varMirrorHelper = new MetaDataHelper<Value>();
    List<MetaDataValue<Value>> varMirrorModels = varMirrorHelper.getVariableMirrorValues(obj);
    
    for(MetaDataValue<Value> varMM in varMirrorModels) {
       Value value = varMM.object;
       varMM.instanceMirror.setField(varMM.memberName, _messageContext.message(value.name, defaultValue: value.defaultValue));
    }
    return obj;
  }
  
  static String getValue(String key, {String defaultValue: ""}) {
    return _messageContext.message(key, defaultValue: defaultValue);
  }
  
  static void _register(Object obj) {
       List<MetaDataValue<_Bean>> mirrorValues = new MetaDataHelper<_Bean>().getMirrorValues(obj);
            
       for (MetaDataValue mv in mirrorValues) {
            InstanceMirror res = mv.invoke([]);
            String beanName = mv.name;
            for (Object obj in mv.getOtherMetadata()) {
              if (obj is Qualifier) {
                  Qualifier qualifier = obj;
                  beanName = qualifier.name;
               }
            }
            
            if (res != null && res.hasReflectee) {
                _singletons[beanName] = res.reflectee;
            }
       }
  }
}