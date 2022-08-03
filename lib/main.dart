import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Counter",
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: BlocProvider(
            create: (context) => CounterCubit(), child: const HomePage()));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  late CounterCubit cubit;

  @override
  void didChangeDependencies() {
// TODO: implement didChangeDependencies
    cubit = BlocProvider.of<CounterCubit>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter Clicker"),
      ),
      body: BlocConsumer<CounterCubit, int>(
    bloc: cubit,
    listener: (context, state) {
    const snackbar = SnackBar(
    content: Text('State is reached'),
    );

    if (state == 5) {
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    },
        builder: (context, state){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a number',
                      ),
                    ),
                  ),
                  Text(
                    "$state",
                    style: TextStyle(fontSize: 100),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(

                          onPressed: () {
                            cubit.increment();

                          },
                          child: const Text("Increment")),

                      ElevatedButton(
                          onPressed: () {
                            cubit.decrement();
                          },
                          child: const Text("Decrement")),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,),
                          onPressed: () {
                            cubit.reset();
                          },
                          child: const Text("Reset")),
                    ],
                  )
                ],
              ),
            );

          },
        ),

    );
  }
}