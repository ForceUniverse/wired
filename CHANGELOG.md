### Changelog ###

This file contains highlights of what changes on each version of the wired package. 

#### Pub version 0.3.3 ####

Adding setBean method in ApplicationContext

#### Pub version 0.3.2+1 ####

Update YAML dependency.

#### Pub version 0.3.2 ####

Add static method getBeanByType on ApplicationContext
Also resolve autowired cases by Type and not only by name
Rename package to 'wired'

#### Pub version 0.3.1 ####

Improved the addComponents method

#### Pub version 0.3.0 ####

Add documentation
Change component(Scanner scanner) to addComponents(Iterable objs)
Change MetaDataHelper().getVariableMirrorValues(obj) to MetaDataHelper<_Autowired, VariableMirror>().from(obj)
Change MetaDataHelper().getMirrorValues(obj) to MetaDataHelper<_Bean, MethodMirror>().from(obj)

#### Pub version 0.2.1+1 ####

Moving repo to ForceUniverse organisation  

#### Pub version 0.2.1 ####

Fix scanning of config classes and component classes.  

#### Pub version 0.2.0 ####

Remove parentheses from annotations.  

#### Pub version 0.1.3+2 ####

Yaml value can be anything! Change the return type to dynamic to get a value!

#### Pub version 0.1.3+1 ####

Adding a method to get a value from a yaml file through ApplicationContext.

#### Pub version 0.1.3 ####

Now you can inject yaml values into your dart classes.

#### Pub version 0.1.2 ####

Adding the Qualifier annotation to this package, so you can name the beans you configure.

#### Pub version 0.1.1 & 0.1.1+1 ####

Make it possible to switch order of the classes when they are created!

#### Pub version 0.1.0+1 ####

Adding documentation

#### Pub version 0.1.0 ####

Initial setup of the package