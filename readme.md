### Wired ###

![LOGO!](https://raw.github.com/ForceUniverse/dart-force/master/resources/dart_force_logo.jpg)

Part of the Dart Force Framework.

A library to do dependency injection! It uses the same annotations as in java spring applications.

#### Walkthrough ####

To bootstrap your injections call

	ApplicationContext.bootstrap();
	
To configure your classes make a configuration class

	@Config
	class SomeConfig {
	  
	  @Bean
	  Counter counter() {
	    return new Counter();
	  }
	  
	  @Bean
	  Calc calc() {
	    return new Calc();
	  }
	  
	}
	
When you want to access an instance you can call 

	ApplicationContext.getBean("counter");

You can also define Components by using the @Component annotation

For the moment we only support set dependency injections and not constructor dependency injection.

#### Qualifier ####

You can use a Qualifier to give the bean a specific name, it is usefull when you want to configure 2 instances of the same class. 

	@Qualifier(name: "firstCounter")
	@Bean
	Calc calc() {
		return new Calc();
	}
	
#### Values ####

You can add yaml values into your classes.
First add them to the applicationContext. The first value is the key of the messages and the second value is the yaml content.

	ApplicationContext.registerMessage("sentences", "sentence: Is this good?");
	
Register the messages before calling the method bootstrap of ApplicationContext.

You can add the @Value annotation into a scanned bean.

	@Value("sentence")
	String value;

You can also get a value from ApplicationContext, like follow:

	ApplicationContext.getValue("sentence");

#### TODO ####

- add Value annotation

### Notes to Contributors ###

#### Fork Force_it ####

If you'd like to contribute back to the core, you can [fork this repository](https://help.github.com/articles/fork-a-repo) and send us a pull request, when it is ready.

If you are new to Git or GitHub, please read [this guide](https://help.github.com/) first.

#### Dart Force ####

Realtime web framework for dart that uses forcemvc & forcemirrors & wired [source code](https://github.com/ForceUniverse/dart-force)

#### Twitter ####

Follow us on twitter https://twitter.com/usethedartforce

#### Google+ ####

Follow us on [google+](https://plus.google.com/111406188246677273707)