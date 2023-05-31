import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'first_flutter_app',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
} // MyApp

/*********************************
 ******* MY APP STATE *******
 *********************************
  * This is the state of the app
  * It is a ChangeNotifier
  * It has a WordPair called current
  * It has a list of WordPair called favorites
  * It has a method called getNext() that changes the current WordPair
  * It has a method called toggleFavorite() that adds or removes the current WordPair from the favorites list
 * */
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  // this getNext() method is called from the ElevatedButton onPressed
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  // ↓ favorites is a list of WordPair
  var favorites = <WordPair>[];

  // this method is called from the IconButton onPressed
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
} // MyAppState

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // device independent pixels. 20px will be same independent of device used!
            SizedBox(height: 20.0),
            BigCard(pair: pair),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // I want to print the appState.getNext() here
                appState.getNext();
              },
              child: Text('Next'),
              // style: ElevatedButton.styleFrom(
              //   backgroundColor: Colors.deepOrange,
              //   foregroundColor: Colors.white,
              //   disabledBackgroundColor: Colors.grey,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asPascalCase,
          style: textStyle,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
