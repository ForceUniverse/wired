### Force IT ###

![LOGO!](https://raw.github.com/jorishermans/dart-force/master/resources/dart_force_logo.jpg)

Part of the Dart Force Framework.

A library to do dependency injection! It uses the same annotations as in java spring applications.

#### Walkthrough ####

To bootstrap your injections call

	ApplicationContext.bootstrap();
	
To configure your classes make a configuration class

	@Config()
	class SomeConfig {
	  
	  @Bean()
	  Counter counter() {
	    return new Counter();
	  }
	  
	  @Bean()
	  Calc calc() {
	    return new Calc();
	  }
	  
	}
	
When you want to access an instance you can call 

	ApplicationContext.getBean("counter");

You can also define Components by using the @Component annotation

For the moment we only support set dependency injections and not constructor dependency injection.

#### TODO ####

- add Qualifier annotation
- add Value annotation

### Notes to Contributors ###

#### Fork Force_it ####

If you'd like to contribute back to the core, you can [fork this repository](https://help.github.com/articles/fork-a-repo) and send us a pull request, when it is ready.

If you are new to Git or GitHub, please read [this guide](https://help.github.com/) first.

#### Dart Force ####

Realtime web framework for dart that uses forcemvc & forcemirrors [source code](https://github.com/jorishermans/dart-force)

#### Twitter ####

Follow us on twitter https://twitter.com/usethedartforce

#### Google+ ####

Follow us on [google+](https://plus.google.com/111406188246677273707)