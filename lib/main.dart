import 'package:flutter/material.dart';
import 'package:yut/http/core/hi_error.dart';
import 'package:yut/http/core/hi_net.dart';
import 'package:yut/http/request/test_request.dart';
import 'common/logs/logs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
      TestRequest request = TestRequest();
      request.add("aa", "dddd").add("bb", "ccc").add("requestParams", "kkkkkk");
      try {
        var result = await HiNet.getInstance().fire(request);
        print(result);
      } on NeedAuth catch (e) {
        print("NeedAuth error: ");
      }on NeedLogin catch (e) {
        print("NeedLogin error: ");
      }on HiNetError catch (e) {
        print("HiNetError error: ");
      } catch (e) {
        print("error: ");
      }

      Log.info("hello world",StackTrace.current);
    setState(() {
      _counter++;
    });
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
