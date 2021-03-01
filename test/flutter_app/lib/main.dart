import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(randomList());
}

class randomList extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Random num gen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List randomList = [];

  getCountries() async {
    var response =
    await Dio().get('https://csrng.net/csrng/csrng.php?min=1&max=1000');
    randomList.add(response.data[0]['random']);
    print(randomList);
    return response.data[0]['random'];
  }

  Widget myItmes() {
    return Column(
      // Text('You CANNOT put other Widgets here'),
      children: randomList.map((item) => Text(item)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                child: Text(
                  'Get New Random Number',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  getCountries();
                }),
            Text("Previous NUmbers"),
            myItmes()

          ],
        ),
      ),

    );
  }
}