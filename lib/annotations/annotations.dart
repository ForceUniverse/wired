part of force_it;

class Autowired {
  
  const Autowired();
  
}

class Bean {
  
  const Bean();
  
}

class Component {
  
  final String name;
  
  const Component({this.name});
  
}

class Config {
  
  const Config();
  
}

class Qualifier {
  
  final String name;
    
  const Qualifier({this.name});
  
}

class Value {
  
  final String name;
  final String defaultValue;
  
  const Value(this.name, {this.defaultValue: ""});
  
}
