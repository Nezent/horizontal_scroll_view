import 'package:flutter/material.dart';
import 'package:horizontal_scroll_view/horizontal_scroll_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Horizontal Scroll View Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 200, 16, 0),
          child: Column(
            children: [
              HorizontalScrollView(
                  itemWidth:
                      (2 / 3) * 153, // Number of items displayed per row.
                  crossAxisSpacing:
                      8.0, // Spacing between items in the same row.
                  alignment: CrossAxisAlignment
                      .start, // Alignment of items within the row (default is center)
                  children: [
                    ListItemTwo(hasTitle: true),
                    ListItemTwo(hasTitle: false),
                    ListItemTwo(hasTitle: true),
                    ListItemTwo(hasTitle: true),
                    ListItemTwo(hasTitle: true),
                    ListItemTwo(hasTitle: true),
                    ListItemTwo(hasTitle: true),
                    ListItemTwo(hasTitle: true),
                    ListItemTwo(hasTitle: true),
                  ]),
              SizedBox(
                height: 30,
              ),
              HorizontalScrollView.builder(
                itemWidth: (16 / 9) * 80, // Number of items displayed per row.
                crossAxisSpacing: 16, // Spacing between items in the same row.
                alignment: CrossAxisAlignment
                    .center, // Alignment of items within the row (default is center)
                itemCount: 12, // Total number of items in the list.
                itemBuilder: (BuildContext context, int index) {
                  // Create and return the widgets for each item.
                  return ListItemOne();
                },
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ListItemTwo extends StatelessWidget {
  final bool hasTitle;
  const ListItemTwo({
    super.key,
    required this.hasTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 153,
            width: (2 / 3) * 153,
            child: Image.network(
              'https://via.placeholder.com/200x300',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        if (hasTitle == true)
          SizedBox(
            width: (2 / 3) * 153,
            child: Text(
              "Mission Impossible II Breaking the Barrier",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
      ],
    );
  }
}

class ListItemOne extends StatelessWidget {
  const ListItemOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 80,
            width: (16 / 9) * 80,
            child: Image.network(
              "https://via.placeholder.com/150",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        SizedBox(
          width: (16 / 9) * 80,
          child: Text(
            "Mission Impossible II Breaking the Barrier",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
