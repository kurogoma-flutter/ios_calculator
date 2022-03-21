# ios_calculator
出来損ないのiPhoneにある電卓です。
<br><br>
あと練習用のカウンターアプリです。

## カウンターアプリ
### 結果画面
<img width="300" src="https://user-images.githubusercontent.com/67848399/159236178-861325c2-6369-463a-8494-b86d59a64d36.png">

### メイン機能
up,down,clearというテキストでロジックも切り替えてみました。
```dart
// ボタン部分
Row(
 mainAxisAlignment: MainAxisAlignment.center,
 children: [
 　　/// 各種ボタン テキスト、ボタン色、ロジックを指定
  CounterButton('- 1', Colors.blue, 'down'),
 　　CounterButton('Clear', Colors.grey, 'clear'),
  CounterButton('+ 1', Colors.red, 'up'),
　　],
)

// 共通化したウィジェット
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

  /*******************************
   *      カウンターのメソッド
   ******************************/

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
```

## 電卓アプリ
### 結果画面
<img width="300" src="https://user-images.githubusercontent.com/67848399/159236277-934a3f86-a44e-4dc3-b5c9-6740e9d14d82.png">

### メイン機能
FloatingActionButtonのサイズ調整するためにSizedBoxでラップしてます
#### ロジックリスト
- _addNumber : 数字を右側に足します。
- _addSymbol : 記号を右側に足すが、一番右が記号であれば入れ替える処理
- _addDot : ドットを右側に足すが、一番右が記号であれば反応しないような処理
- _convertPlusMinus : 先頭のプラマイだけひっくり返す（ここは甘い）
- _reset : 計算式をリセットする
- _calculate : 計算を実行する

#### ボタンのウィジェット
以下の要素を指定するように共通化した。
- 背景色
- 文字色
- テキスト
- ロジック

```dart
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
```

### 計算ロジック
コードは割愛しますが、以下のようなロジックで作っています。
1. 計算式を数字、記号で分割する
2. 左から順に計算していく
※ 本来乗除の計算が優先されるべきですが、今回は実装できていません。左から処理がされます。


