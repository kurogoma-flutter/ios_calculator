import 'package:flutter_intermediate/utils/import.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter',
      home: const CounterApp(),
      routes: {
        '/home': (context) => const MyApp(),
      },
    );
  }
}

class CounterApp extends StatefulWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  /// 変数・定数設定
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Counter',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlaneText(context, 'Counter', 24),
            PlaneText(context, _count.toString(), 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// 各種ボタン テキスト、ボタン色、ロジックを指定
                CounterButton('- 1', Colors.blue, 'down'),
                CounterButton('Clear', Colors.grey, 'clear'),
                CounterButton('+ 1', Colors.red, 'up'),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// ボタンのウィジェット
  /// TODO: typeにモデルを与える。Providerで状態管理。
  Padding CounterButton(String text, Color color, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          switch (type) {
            case 'up':
              _countUp();
              break;
            case 'down':
              _countDown();
              break;
            case 'clear':
              _countReset();
              break;
            default:
              null;
          }
        },
        child: Text(text),
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
      ),
    );
  }

  /****************************************
   *      カウンターのメソッド
   ***************************************/

  /// １を足すメソッド
  void _countUp() {
    setState(() {
      _count++;
    });
  }

  /// １減らすメソッド
  void _countDown() {
    setState(() {
      _count--;
    });
  }

  /// リセット（0にする）メソッド
  void _countReset() {
    setState(() {
      _count = 0;
    });
  }
}
