## Flutter counter using flutter_bloc state management

#### Step 0

Create a empty Flutter project and add the `flutter_bloc` package from [pub.dev](https://pub.dev/). Next inside the `lib` folder create a folder named `blocs` which will contain all the bloc files. For example, we will create a folder `counter_bloc`. Then inside it create 3 files - `counter_event.dart`, `counter_state.dart` and `counter_bloc.dart`.

#### Step 1

Define a Event class inside `counter_event.dart` which will be extended by the `Bloc`. You can mark this class as abstract so that it can't be instanciated. Now define all the possible events that can possibly occur. For example in our app, there can exist only two kinds of events - increment and decrement. These events must extend the event class which we defined first, these will tell Bloc that they are of same type.

```
abstract class CounterEvent {} // Defining the parent class abstract

class IncrementCount extends CounterEvent {}

class DecrementCount extends CounterEvent {}
```

#### Step 2

Define a State class inside the `counter_state.dart` along with the data members(if exists). Next define the initial state and all other states that can possibly exist in your app and extend them from the parent state class defined before. If your state class has any data member, it must be initialzed from the sub classes extending it using the `super` keyword.

```
class CounterState {
  final int count;
  CounterState({required this.count});
}

class CounterInitialState extends CounterState {
  CounterInitialState() : super(count: 0); // Initialize the data members with initial values
}
```

#### Step 3

Now define a class that will be extending the `Bloc` inside the `counter_bloc.dart`. The `Bloc` is a generic class so you must specify the type parameters it accepts, i.e. the `Event` and the `State` inside the arrow brackets `<>` (The Event and the State class you created before must be passed here). Next inside the class declare a constructor which passes the initial state that we created before to it's super class.

```
CounterBloc() : super(CounterInitialState()) {}
```

While using `Bloc` you must remember that <b>Events are added</b> and <b> States are emitted</b>. So for every event you add, you must also specify the state that it emits.
For example, for the `IncrementCount` event, we want to emit a state where the count is incremented by 1. So we implement it like this-

```
 on<IncrementCount>((event, emit) => emit(CounterState(count: state.count + 1)));
```

After defining all the events and states, your `CounterBloc` class should look like this.

```
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitialState()) {
    on<IncrementCount>(
      (event, emit) => emit(CounterState(count: state.count + 1)),
    );
    on<DecrementCount>(
      (event, emit) => emit(CounterState(count: state.count - 1)),
    );
  }
}
```

#### Step 4

Here we have to specify the scope of the `Bloc`. You can use it globally or use it over a particular widget. For now, we are defining it globally, so we'll wrap the `MaterialApp` with the `BlocProvider`. `BlocProvider` as the name suggests provides all the events and states that are being managed thoughout the app. It accepts a `create` parameter where we pass the instance the `CounterBloc` we created.

```
BlocProvider(
  create: (context) => CounterBloc(),
  child: const MaterialApp(
    home: CounterHomePage(),
  ),
)
```

#### Step 5

Now move to the widget where all the events and states will be managed. Here, we are managing them inside the `CounterHomePage`. For emitting the states when a event is triggered, we use the `BlocBuilder` which accepts a `builder` and reciprocates when the event is fired. In some cases when some event is triggered we may not want to update any state but want some functionality to work in background, like showing a SnackBar or Toast. In this case a `BlocListener` is ideal choice for us which takes `listener` as a parameter. If you want to implement both the functionalities, you must go with the `BlocConsumer` which takes both the parameters `builder` and `listener`. In our case, `BlocBuilder` is a ideal choice for us.

```
BlocBuilder<CounterBloc, CounterState>(
  // The builder takes a function which accepts context and the state
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Counter'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Count',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              state.count.toString(), // Data to be updated here
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(IncrementCount()); // Adding the event to increment count
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).add(DecrementCount()); // Adding the event to decrement count
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  },
)
```
