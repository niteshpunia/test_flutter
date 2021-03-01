import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'random num gen'),
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
  var randomNum = "";

  getRandomNumber() async {
    var response =
        await Dio().get('https://csrng.net/csrng/csrng.php?min=1&max=1000');
    randomList.add(response.data[0]['random']);
    print(randomList);
    setState(() {
      randomNum = response.data[0]['random'].toString();
    });
    return response.data[0]['random'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                child: Text(
                  'Get Random Number',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  getRandomNumber();
                }),
            Text("$randomNum"),
            Text("History"),
            ListView.builder(
              itemCount: randomList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${randomList[index]}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
