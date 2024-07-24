import 'package:flutter/material.dart';
import 'screens/logistics_query_screen.dart';
import 'screens/route_query_screen.dart';
import 'screens/quote_query_screen.dart';
import 'screens/order_screen.dart'; // 导入订单页面
import 'screens/order_tracking_screen.dart'; // 导入订单跟踪页面
import 'screens/finance_screen.dart'; // 导入财务管理页面
import 'screens/points_screen.dart'; // 导入会员积分管理页面
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // 这是你的应用程序的主题.
        //
        // 尝试运行你的应用程序：试着运行 "flutter run"。你会看到
        // 应用程序有一个紫色的工具栏。然后，在不退出应用程序的情况下，
        // 尝试将下面 colorScheme 中的 seedColor 改为 Colors.green
        // 然后执行 "热重载" (保存你的更改或按下 Flutter 支持的 IDE 中的 "热重载" 按钮，
        // 或者如果你是使用命令行启动应用程序的，按 "r" 键).
        //
        //
        // 注意计数器没有重置为零；在重载期间应用程序的状态不会丢失。要重置状态，请使用热重启.
        //
        //
        // 这不仅适用于值的更改：大多数代码更改也可以通过热重载进行测试。
        //
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(250, 238, 219, 4)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/logistics_query': (context) => const LogisticsQueryScreen(),
        '/route_query': (context) => const RouteQueryScreen(),
        '/quote_query': (context) => const QuoteQueryScreen(),
        '/order': (context) => const OrderScreen(), // 添加订单页面的路由
        '/order_tracking': (context) => const OrderTrackingScreen(), // 添加订单跟踪页面的路由
        '/finance': (context) => const FinanceScreen(), // 添加财务管理页面的路由
        '/points': (context) => const PointsScreen(), // 添加会员积分管理页面的路由
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // 这个小部件是你的应用程序的主页。它是有状态的，这意味着它有一个 State 对象（定义在下面），该对象包含影响其外观的字段。

  // 这个类是状态的配置。它保存由父级（在这个例子中是 App 小部件）提供的值（在这个例子中是标题），并由 State 的 build 方法使用。
  // Widget 子类中的字段总是标记为 "final"。

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // 这个对 setState 的调用告诉 Flutter 框架，这个 State 中有些东西发生了变化，
      // 这会导致它重新运行下面的 build 方法，以便显示能够反映更新后的值。
      // 如果我们在不调用 setState() 的情况下更改 _counter，那么 build 方法将不会再次被调用，
      // 因此不会有任何变化。
      //
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 每次调用 setState 时都会重新运行这个方法，例如上面的 _incrementCounter 方法。
    //
    //
    // Flutter 框架已经过优化，使得重新运行 build 方法非常快速，
    // 因此你可以只重建需要更新的内容，而不必单独更改小部件的实例。
    //
    return Scaffold(
      appBar: AppBar(
        // 尝试一下：尝试将这里的颜色更改为特定的颜色（例如 Colors.amber？），
        // 然后触发热重载，看看 AppBar 的颜色变化，而其他颜色保持不变。
        //
        backgroundColor: Colors.amber,
        // 在这里，我们从由 App.build 方法创建的 MyHomePage 对象中获取值，并使用它来设置我们的 AppBar 标题。
        //
        title: const Text('货代小KID的海运app'),
      ),
      body: Center(
        // Center 是一个布局小部件。它接受一个子小部件并将其置于父级的中间。
        //
        child: Column(
          // Column 也是一个布局小部件。它接受一个子小部件列表并将它们垂直排列。
          // 默认情况下，它会根据子小部件的宽度进行自我调整，并尝试与父级一样高。
          //
          //
          // Column 有各种属性来控制它的尺寸和子小部件的位置。
          // 在这里我们使用 mainAxisAlignment 来垂直居中子小部件；
          // 这里的主轴是垂直轴，因为 Column 是垂直的（交叉轴则是水平的）。
          //
          //
          // 尝试一下：调用 "调试绘制"（在 IDE 中选择 "Toggle Debug Paint" 操作，或在控制台中按 "p" 键），
          // 以查看每个小部件的线框。
          //
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '今天摸鱼的次数:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 10.0, // 主轴方向上的间距
              runSpacing: 10.0, // 交叉轴方向上的间距
              alignment: WrapAlignment.center, // 主轴方向上的对齐方式
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/logistics_query');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('单号查询'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/route_query');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('船期查询'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/quote_query');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('报价查询'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/order');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('自助下单'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/order_tracking');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('订单跟踪'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/finance');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('财务管理'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/points');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('会员积分管理'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: ImageIcon(
          AssetImage('assets/icons/muyu.gif'), // 使用木鱼图标
          size: 24,
        ),
      ), // 这个尾随逗号使得 build 方法的自动格式化更好看。
    );
  }
}
Future<void> createOrder(Map<String, dynamic> orderData) async {
  final response = await http.post(
    Uri.parse('http://localhost:5000/order'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(orderData),
  );

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print('Order created: $responseData');
  } else {
    print('Failed to create order');
  }
}