part of wired;

const Autowired = const _Autowired();

class _Autowired {

  const _Autowired();

}

const Bean = const _Bean();

class _Bean {

  const _Bean();

}

class Component {

  final String name;

  const Component({this.name});

}

class Order {

  final int priority;

  const Order(this.priority);

}

const Config = const _Config();
const Configuration = const _Config();

class _Config {

  const _Config();

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
