import 'package:flutter_intermediate/utils/import.dart';

/// TODO: onPressedにasync await追加
class CalculatorPage extends StatelessWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: const CalculatorApp(),
      routes: {
        '/home': (context) => const MyApp(),
      },
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

/// 画　面
class _CalculatorAppState extends State<CalculatorApp> {
  /// ＜変数・定数＞
  /// _letter => 計算結果の表示
  /// numberColor => FABの数字の背景色
  String _letter = '0';
  Color numberColor = const Color(0xFF2B2B2B);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'Counter',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            /// 計算結果の表示エリア
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                alignment: Alignment.centerRight,
                width: size.width,
                height: size.height * 0.2,
                child: ColorText(context, _letter, 60, Colors.white),
              ),
            ),

            /// 電卓キー部分のエリア
            SizedBox(
              height: size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton('AC', 'reset', Colors.grey, Colors.black),
                      CalculatorButton('±', 'convert', Colors.grey, Colors.black),
                      CalculatorButton('%', 'symbol', Colors.grey, Colors.black),
                      CalculatorButton('÷', 'symbol', Colors.orange, Colors.white),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton('7', 'number', numberColor, Colors.white),
                      CalculatorButton('8', 'number', numberColor, Colors.white),
                      CalculatorButton('9', 'number', numberColor, Colors.white),
                      CalculatorButton('×', 'symbol', Colors.orange, Colors.white),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton('4', 'number', numberColor, Colors.white),
                      CalculatorButton('5', 'number', numberColor, Colors.white),
                      CalculatorButton('6', 'number', numberColor, Colors.white),
                      CalculatorButton('-', 'symbol', Colors.orange, Colors.white),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton('1', 'number', numberColor, Colors.white),
                      CalculatorButton('2', 'number', numberColor, Colors.white),
                      CalculatorButton('3', 'number', numberColor, Colors.white),
                      CalculatorButton('+', 'symbol', Colors.orange, Colors.white),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CalculatorButton('0', 'number', numberColor, Colors.white),
                      CalculatorButton('00', 'number', numberColor, Colors.white),
                      CalculatorButton('.', 'dot', numberColor, Colors.white),
                      CalculatorButton('=', 'calculate', Colors.orange, Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /***********************************
   *         Widgetの共通化
   **********************************/
  /// 【 電卓ボタンのウィジェット 】
  /// text => キーに表示する文字
  /// type => メソッド切替用
  /// backgroundColor => ボタン背景色
  /// textColor => ボタンテキスト色
  SizedBox CalculatorButton(String text, String type, Color backgroundColor, Color textColor) {
    return SizedBox(
      width: 80,
      height: 80,
      child: FloatingActionButton(
        heroTag: text,
        onPressed: () {
          switch (type) {
            case 'number':
              _addNumber(text);
              break;
            case 'symbol':
              _addSymbol(text);
              break;
            case 'dot':
              _addDot();
              break;
            case 'convert':
              _convertPlusMinus();
              break;
            case 'reset':
              _reset();
              break;
            case 'calculate':
              _calculate();
              break;
            default:
              null;
          }
        },
        backgroundColor: backgroundColor,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 36),
        ),
      ),
    );
  }

/*********************************
 *　      ボタンアクション一覧
 *********************************/
  ///
  /// 算術記号を追加する
  ///
  _addSymbol(String symbol) {
    setState(() {
      List<String> letters = _letter.split('');
      String last = letters.last;
      String result = '';
      if (last != '.') {
        if (last == '%' || last == '÷' || last == '×' || last == '-' || last == '+') {
          for (int i = 0; i < letters.length - 1; i++) {
            result += letters[i];
          }
          _letter = result + symbol;
        } else {
          _letter += symbol;
        }
      }
    });
  }

  ///
  /// ドットを追加する
  ///
  _addDot() {
    setState(() {
      List<String> letters = _letter.split('');
      String last = letters.last;
      if (last != '%' && last != '÷' && last != '×' && last != '-' && last != '+' && last != '.') {
        _letter += '.';
      }
    });
  }

  ///
  /// 数字を追加する
  ///
  _addNumber(String number) {
    setState(() {
      if (_letter == '0' && number != '0') {
        _letter = '';
      }
      _letter += number;
    });
  }

  ///
  /// リセットする（０にする）
  ///
  _reset() {
    setState(() {
      _letter = '0';
    });
  }

  ///
  /// プラマイを切り替える
  ///
  _convertPlusMinus() {
    List<String> letters = _letter.split('');
    String result = '';
    // 0の場合、-だけ付与
    if (_letter == '0' || _letter == '') {
      _letter = '-';
    }
    // マイナスのオンオフ
    else {
      if (letters[0] == '-') {
        for (int i = 1; i < letters.length; i++) {
          result += letters[i];
        }
        _letter = result;
      } else {
        _letter = '-' + _letter;
      }
    }

    setState(() {
      _letter;
    });
  }

  ///
  /// イコールを押下した時の計算処理
  ///
  _calculate() {
    /// (1) 計算用の配列データを作成する   イメージ:['123', '+', '100' , '×', '5']
    List<String> letters = _letter.split(''); // 全てを１文字区切りしたもの
    List<String> calculateArray = []; // 文字と記号の塊で格納する配列
    String tempText = ''; // calculateArray作成用の変数
    String thisText = ''; // ループのデータを格納する
    for (int i = 0; i < letters.length; i++) {
      thisText = letters[i];
      // １文字目はとりあえず格納するだけ
      if (i == 0) {
        tempText += thisText;
      } else {
        if (thisText == '+' || thisText == '-' || thisText == '×' || thisText == '÷' || thisText == '%') {
          // 最後に記号を入れられていたら排除する
          if (i == letters.length) {
            break;
          }
          calculateArray.add(tempText); // それまでの数字
          calculateArray.add(thisText); // 記号
          tempText = '';
        } else {
          tempText += thisText;
          if (i == letters.length - 1) {
            calculateArray.add(tempText);
            tempText = '';
          }
        }
      }
    }

    ///  (2) 計算処理
    ///  TODO: Providerを使う。引数(type)にモデルを与える
    double result = 0; // 計算処理用
    for (int j = 0; j < calculateArray.length; j++) {
      if (j == 0) {
        result += double.parse(calculateArray[j]);
      } else {
        switch (calculateArray[j]) {
          case '+':
            result += double.parse(calculateArray[j + 1]);
            j++;
            break;
          case '-':
            result -= double.parse(calculateArray[j + 1]);
            j++;
            break;
          case '×':
            result = result * double.parse(calculateArray[j + 1]);
            j++;
            break;
          case '÷':
            result = result / double.parse(calculateArray[j + 1]);
            j++;
            break;
          case '%':
            result = result % double.parse(calculateArray[j + 1]);
            j++;
            break;
          default:

            /// エラー時のデバッグ処理
            print(calculateArray[j]);
        }
      }
      if (j == calculateArray.length) {
        break;
      }
    }

    setState(() {
      // もし整数だった場合、小数点以下を削除して返す。
      if (result % 1 == 0) {
        _letter = result.round().toString();
      } else {
        _letter = result.toString();
      }
    });
  }
}
