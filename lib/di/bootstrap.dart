part of force_it;

class ApplicationContext {
  static Map<String, Object> _singletons = new Map<String, Object>();
  static List<Object> components = new List<Object>();
  
  static void bootstrap() {
    // first bootstrap your beans
    Scanner<Config, Object> classesHelper = new Scanner<Config, Object>();
    List<Object> classes = classesHelper.scan();
          
    for (var obj in classes) {
        _register(obj);
    }
    
    // search for Components and then inject 
    Scanner<Component, Object> componentHelper = new Scanner<Component, Object>();
    List<Object> componentsScanned = componentHelper.scan();
            
    for (var component in componentsScanned) {
        // do something with the component
        components.add(component);  
    }
    
    // inject the autowired
    _singletons.forEach((key, value) {
      _inject(value);
    });
    for (var component in components) {
        // do something with the components
        _inject(component);  
    }
  }
  
  static Object getBean(String name) => _singletons[name];
  
  static Object _inject(Object obj) {
    MetaDataHelper<Autowired> varMirrorHelper = new MetaDataHelper<Autowired>();
    List<MetaDataValue<Autowired>> varMirrorModels = varMirrorHelper.getVariableMirrorValues(obj);
          
    for(MetaDataValue<Autowired> varMM in varMirrorModels) {
       var value = _singletons[varMM.name];
       if (value!=null) {
           varMM.instanceMirror.setField(varMM.memberName, value);
       }
    }
    return obj;
  }
  
  static void _register(Object obj) {
       List<MetaDataValue<Bean>> mirrorValues = new MetaDataHelper<Bean>().getMirrorValues(obj);
            
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