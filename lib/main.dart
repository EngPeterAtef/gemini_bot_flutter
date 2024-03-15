import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:gemini_bot_flutter/components/code_wrapper.dart';

void main() {
  Gemini.init(
    apiKey: const String.fromEnvironment('apiKey'),
    enableDebugging: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gemini',
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  final _controller = TextEditingController();
  final gemini = Gemini.instance;

  var _result = '';
  bool _geminiAsk = true;

  /// This function is called when the user submits a question
  Future<void>? _onSubmitQuestion(String val) async {
    gemini
        .text(
      val,
      generationConfig: GenerationConfig(
        temperature: 0.5,
        // maxOutputTokens: 512,
      ),
    )
        .then((value) {
      setState(() {
        _result += value?.output ?? 'No result found';
        print("Output: $value");
      });
    }).onError((e) {
      print('text generation exception: ${e!}');
    } as FutureOr<Null> Function(Object error, StackTrace stackTrace));
    // Stream Generate Content
    // gemini
    //     .streamGenerateContent(
    //   value,
    //   generationConfig: GenerationConfig(
    //     temperature: 0.5,
    //     // maxOutputTokens: 512,
    //   ),
    // )
    //     .listen((value) {
    //   setState(() {
    //     _result += value.output ?? 'No result found';
    //     _geminiAsk = !_geminiAsk;
    //     print("Output: $value");
    //   });
    // }).onError((e) {
    //   print('streamGenerateContent exception: $e');
    // });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final config =
        isDark ? MarkdownConfig.darkConfig : MarkdownConfig.defaultConfig;
    final codeWrapper =
        (child, text, language) => CodeWrapperWidget(child, text, language);

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
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter the question for Gemini:',
                  ),
                  controller: _controller,
                  onSubmitted: (value) {
                    _onSubmitQuestion(value);
                    setState(() {
                      _geminiAsk = !_geminiAsk; //it should be false
                    });
                  },
                  enabled: _geminiAsk,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // after toggling the boolean
                      setState(() {
                        _geminiAsk = !_geminiAsk; //it should be false
                        if (_geminiAsk == true) {
                          // this means that you want to ask the question
                          _result = '';
                          _controller.clear();
                        } else {
                          _onSubmitQuestion(_controller.text);
                        }
                      });
                    },
                    child: Text(_geminiAsk ? 'Ask Gemini' : "Stop Execution"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _result = '';
                        _geminiAsk = true;
                        _controller.clear();
                      });
                    },
                    child: const Text('Clear Result'),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              // scrollable list to show the results of the questions
              (_geminiAsk == false && _result == '')
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context)
                              .colorScheme
                              .inversePrimary), // Change the color
                      strokeWidth: 4.0, // Adjust the thickness
                      backgroundColor: Colors.grey, // Set the background color
                    )
                  : (_geminiAsk == false && _result != '')
                      ? Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: const EdgeInsets.all(20),
                            // margin: const EdgeInsets.only(bottom: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                            child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                if (index == 1) {
                                  // return ListTile(
                                  //   title: Text(
                                  //     _result,
                                  //     style: const TextStyle(
                                  //       color: Colors.white,
                                  //       fontSize: 15,
                                  //     ),
                                  //   ),
                                  // );
                                  return MarkdownWidget(
                                    data: _result,
                                    config: config.copy(
                                      configs: [
                                        isDark
                                            ? PreConfig.darkConfig
                                                .copy(wrapper: codeWrapper)
                                            : const PreConfig()
                                                .copy(wrapper: codeWrapper),
                                        const PConfig(
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        ListConfig(
                                          marker: (isOrdered, depth, index) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  left: 10 * depth.toDouble()),
                                              child: Text(
                                                isOrdered
                                                    ? '${index + 1}.'
                                                    : '•',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                    selectable: true,
                                    shrinkWrap: true,
                                  );
                                } else if (index == 0) {
                                  return const ListTile(
                                    title: Text(
                                      'Gemini Response:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                } else {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      : const SizedBox(),
              //this means the question has been asked
            ],
          ),
        ),
      ),
    );
  }
}
