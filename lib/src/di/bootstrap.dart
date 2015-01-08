part of wired;
/**
 * Class that is in charge of mantaining the Application Context.
 * ie. list of Components, Controllers, ...
 */
class ApplicationContext {
  static Map<String, Object> _singletons = new Map<String, Object>();
  static List<Object> components = [];
  static MessagesContext _messageContext = new MessagesContext();
  
  static void registerMessage(String key, String yamlContent) {
    _messageContext.register(key, yamlContent);
  }

  /**
   * Bootstrap the Application Context. ie. Scan for components
   * annotated with @Config or @Component and inject the @Values
   * and @Autowired
   */
  static void bootstrap() {
    // first bootstrap your configuration
    new Scanner<_Config>().scan().forEach((obj) {
        // DependencyTree dt = _registerOnTree(obj);
        _register(_injectValue(obj));
    });
 
    // inject the _Autowired
    _singletons.forEach((key, value) =>
      _inject(_injectValue(value))
    );

    // search for Components and then inject
    addComponents(new Scanner<Component>().scan());
  }

  /**
   * Add the list of components and inject them the @Value and @Autowired
   */
  static Iterable addComponents(Iterable scannedComponents) {
    for (var scannedComponent in scannedComponents) {
        // do something with the component
        var injectedComponent = _injectValue(scannedComponent);
        components.add(injectedComponent); 
        
        _inject(injectedComponent);
    }
    
    return scannedComponents;
  }

  /**
   * Gets the Named Bean declared in @Config files
   */
  static Object getBean(String name) => _singletons[name];
  
  /**
   * Register a bean in the singletons array
   */
  static void setBean(String name, Object obj) {
    _singletons[name] = obj;
  }
  
  /**
   * Gets the Named Bean by [Type] declared in @Config files
   */
  static Object getBeanByType(Type type) {
    for ( var obj in _singletons.values ) {
      if (obj.runtimeType == type) {
        return obj;
      }
    }
    return null;
  }

  /**
   * Inject the variables annotated with @[Autowired]
   */
  static Object _inject(Object obj) {
    List<MetaDataValue<_Autowired>> varMirrorModels = new MetaDataHelper<_Autowired, VariableMirror>().from(obj);
          
    for(MetaDataValue<_Autowired> varMM in varMirrorModels) {
       var value = _singletons[varMM.name];
       if (value==null) {
         // look for type!
         Type type = varMM.typeOfOwner();
         value = getBeanByType(type);
       }
       if (value!=null) {
           varMM.instanceMirror.setField(varMM.memberName, value);
       }
    }
    return obj;
  }

  /**
   * inject the value of the @[Value] annotation
   */
  static Object _injectValue(Object obj) {
    List<MetaDataValue<Value>> varMirrorModels = new MetaDataHelper<Value, VariableMirror>().from(obj);
    
    for(MetaDataValue<Value> varMM in varMirrorModels) {
       Value value = varMM.object;
       varMM.instanceMirror.setField(varMM.memberName, _messageContext.message(value.name, defaultValue: value.defaultValue));
    }
    return obj;
  }

  /**
   * Gets the value of the annotation @[Value]
   */
  static String getValue(String key, {String defaultValue: ""}) {
    return _messageContext.message(key, defaultValue: defaultValue);
  }
  
  /**
   * Register all elements annotated with @Bean
   */
  static void _register(Object obj) {
       List<MetaDataValue<_Bean>> mirrorValues = new MetaDataHelper<_Bean, MethodMirror>().from(obj);

       for (MetaDataValue mv in mirrorValues) {
            _instantiateSingletons(mv);
       }
  }
  
  /**
   * create an object based upon his [MetaDataValue]
   */
  static void _instantiateSingletons(MetaDataValue mv) {
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