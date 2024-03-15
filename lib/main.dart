import 'dart:async';
import 'package:flutter/material.dart';
// TODO: Import the flutter_gemini package
// TODO: Import the markdown_widget package
// TODO: Import the code_wrapper component

void main() {
  // TODO: Initialize the Gemini instance
  // TODO: pass the apiKey as environment variable
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gemini',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 77, 12, 189)),
        useMaterial3: true,
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Gemini'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // TODO: Create a TextEditingController

  // TODO: Create a Gemini instance

  // TODO: Create a variable to store the result of the question

  // TODO: Create a variable to store the state of the model it represents if you can ask now or not

  // TODO: Create a function to handle the submission of the question
  /// _onSubmitQuestion is a function is called when the user submits a question
  /// It takes the question [String] as a parameter and returns a [Future]
  Future<void>? _onSubmitQuestion(String val) async {
    // TODO: use the gemini instance to call text method that takes the question as parameter and also model configuration

    // TODO: handle the result of the question using then method and also handle the error using onError method
    // TODO: set the result of the question to the _result variable

    // HINT: convert the error type to: FutureOr<Null> Function(Object error, StackTrace stackTrace));
  }

  @override
  Widget build(BuildContext context) {
    // get the brightness of the theme
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // get the config of the markdown based on the brightness of the theme
    // final config =
    //     isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig;
    // get the code wrapper component as a function
    // final codeWrapper =
    //     (child, text, language) => CodeWrapperWidget(child, text, language);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                // TODO: Create a TextField to take the question from the user and set the controller to the _controller
                // TODO: Set the onSubmitted to the _onSubmitQuestion function and also set the toggle the _geminiAsk variable so that TextField is disabled
                child: null,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              // TODO: Create an ElevatedButton to submit the question and clear the result
              // TODO: toggle state of _geminiAsk variable
              // TODO: if _geminiAsk is true, set the _result to empty string and clear the _controller and if it is false, call the _onSubmitQuestion function. WHY?????
              // TODO: the child of the ElevatedButton should be a Text widget with the text 'Ask Gemini' if _geminiAsk is true and 'Clear Result' if _geminiAsk is false

              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              // scrollable list to show the results of the questions
              // TODO: create a condition to show a CircularProgressIndicator which is if you can't ask now and the result is empty that means it's laoding

              // TODO: create a condition to show the result of the question if the question has been asked and the result is not empty
              // TODO: use the MarkdownWidget to display the result of the question
              // TODO: use the config and codeWrapper to style the result of the question
              // TODO: otherwise show an empty container as this means the question has been asked

              //
            ],
          ),
        ),
      ),
    );
  }
}
