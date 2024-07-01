# About Project
This Project is made by Ignasius Santoni M Rajagukguk for technical test purpose from Palm Code.
* Please note that after downloading the code, you have to at least run these commands bellow in terminal:
...
$ flutter pub get
$ flutter pub run build_runner build --delete-conflicting-outputs 
...


## Clean Architecture

As mentioned in this [article](https://betterprogramming.pub/flutter-clean-architecture-test-driven-development-practical-guide-445f388e8604)

> Architecture is very important in developing an application. Architecture can be likened to a floor plan that describes how the flow in an application project. The main purpose of implementing the architecture is the separation of concern (SoC). So, it will be easier if we can work by focusing on one thing at a time.

> In the context of Flutter, clean architecture will help us to separate code for business logic with code related to platforms such as UI, state management, and external data sources. In addition, the code that we write can be easier to test (testable) independently.


## Project Structure

```
|-- /lib
|   |-- /src
|       |-- /common
|       |   |-- /constant
|       |   |-- /enum
|       |   |-- /injection
|       |   |-- /router
|       |   |-- /util
|       |-- /data
|       |   |-- /datasources
|       |   |   |-- /remote
|       |   |   |-- /local
|       |   |-- /models
|       |-- /domain
|       |   |-- /usecase
|       |-- presentation
|           |-- /effects
|           |-- /screens
|           |   |-- /screen_a
|           |       |-- /screen_a_bloc
|           |       |-- /screen_a_widgets
|           |       |-- screen_a.dart
|           |-- /widgets
|-- /test

```

## Getting Started

Since the project structure and architecture change, there are several things that need to be changed.

[Model](#model) </br>
[Injection](#injection) </br>
[Data Source](#datasource) </br>
[Repository](#repository) </br>
[Usecase](#usecase) </br>
[BloC](#bloc) </br>
[Asset](#asset) </br>


### Model

Model is the part of `data` layer, which will interact with repository to transform/convert data from raw Map object (JSON), into usable object. Therefore data serialization is belongs to it (`fromJson`, `fromEntity`, `toJson`).

```
class ModelA {
    ModelA({
        ...
    }): super(...);

    factory ModelA.fromJson(Map<String, dynamic> json) => ModelA(...);

    factory ModelA.fromEntity(EntityA json) => ModelA(...);

    Map<String, dynamic> toJson() => {...};
}
```

### Injection
#### Current Injection

On Current implementation, the output will be generated inside `lib/src/common/injection/injector.config.dart` using belows command

```
$ flutter pub run build_runner build --delete-conflicting-outputs
```

and in the `main.dart` we only need to call `configureDependencies()`.


### Datasource
#### Defining Datasource

```
abstract class DatasourceA {
    Function doSomething({dynamic param});
}

@LazySingleton(as: DatasourceA)
class DatasourceAImpl with InternalServiceExec implements RepositoryA {
    final InternalServiceOption option;
    DatasourceAImpl({required this.option});
}
```

> _Note_: <br/> > `@LazySingleton(as: ...)` will be required here, since we will inject the class using lazy singleton approach.


### BloC
#### Defining BLoC

Click [here](https://bloclibrary.dev/#/gettingstarted) to get more information about BLoC.

```
@injectable
class BlocA extends Bloc<BlocAEvent, BlocAState> {
    final UsecaseA usecaseA;
    BlocA({required this.repositoryA}) super(BlocAinitialState()){
        on<DoSomeEvent>(_doSomeEvent)
    };

    void _doSomeEvent (event, emit){...}
}
```

> _Note_: <br/>
> `@injectable` will be required here, since we will inject the class using dependency injection approach.


### Usecase

#### Defining Usecase

```

@lazySingleton
class UsecaseA {
    final RepositoryA repositoryA;
    UsecaseA({required this.repfositoryA});

    @override
    Future<ResponseObject> call({RequestEntity payload}) async {...}
}
```

> _Note_: <br/>
> `@lazySingleton` will be required here, since we will inject the class using lazy singleton approach.


## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).
