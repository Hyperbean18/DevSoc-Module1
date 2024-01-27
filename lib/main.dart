import 'package:flutter/material.dart';
//import 'MyButton.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:time/time.dart';

void main() {

    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
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

  var userInput = '';
  var answer = '0';
  var errMsg;
  bool _visible = false;

  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context){
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: AppBar(
        backgroundColor: colorScheme.secondary,
        title: Text("Calculator", style: TextStyle(color: colorScheme.onSecondary)),
      ),
      body: Column(
        children: [
          Expanded(
            flex:1,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: _visible ? 1.0 : 0.0 ,
                      child: Container(
                        height: 200,
                        width: 200,
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            /* boxShadow: [
                              BoxShadow(
                              color: colorScheme.shadow,
                                offset: const Offset(2,2),
                                blurRadius: 20.0,
                                spreadRadius: 10.0,
                            ),
                            ], */
                        border: Border.all(width: 6),
                        borderRadius: BorderRadius.circular(12),
                        color: colorScheme.error,
                        ),
                        child: Text("Error was thrown: $errMsg",style: TextStyle(fontSize: 18, color: colorScheme.onError), ),
                      ),
                   ),
                ),
                Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userInput, style: TextStyle(fontSize:18, color: colorScheme.onPrimary)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(answer, style: TextStyle(fontSize: 30, color: colorScheme.onPrimary)),
                  )
                ],
              ),
            ]
            ),
          ),
          Expanded(
              flex:2,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index){
                  switch (index){
                    case 0:
                      return MyButton(
                        buttonPress: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                            errMsg= '';
                          });
                        },
                        buttonText: buttons[index],
                        buttonColor: Colors.blue[50],
                        textColor: Colors.black,
                      ); //clear button

                    case 2:
                      return MyButton(
                        buttonPress: () {
                          setState(() {
                          userInput += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        buttonColor: Colors.blue[50],
                        textColor: Colors.black,
                      );// % button

                    case 1:
                      return MyButton(
                        buttonPress: () {
                          setState(() {
                            if (userInput.substring(0,1).contains('-')){
                              userInput = userInput.substring(1);
                              //print('$userInput');
                            }
                            else {
                              userInput = '-$userInput';
                              //print('$userInput');
                            }
                          }
                          );
                        },
                        buttonText: buttons[index],
                        buttonColor: Colors.blue[50],
                        textColor: Colors.black,
                      ); // +/- button

                    case 3:
                      return MyButton(
                        buttonPress: () {
                          setState(() {
                            userInput = userInput.substring(0, userInput.length -1);
                          });
                        },
                        buttonText: buttons[index],
                        buttonColor: Colors.blue[50],
                        textColor: Colors.black,
                      );// DEL button

                    case 18:
                      return MyButton(
                        buttonPress: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        buttonColor: Colors.orange[700],
                        textColor: Colors.white,
                      );// equal to button

                    default:
                      return MyButton(
                        buttonPress: () {
                          setState(() {
                            userInput+= buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        buttonColor: isOperator(buttons[index])
                            ? Colors.blueAccent
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );// all other buttons
                  }
                }
              ),
          )
        ],
      ),
    );

  }
// used to decide the colors of buttons
  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
//on pressing equal to
  void equalPressed() {
    String finaluserinput = userInput.replaceAll('x', '*');

    try {
      Parser p = Parser();
      Expression exp = p.parse(finaluserinput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      answer = eval.toString();
    } catch (err){
      errMsg=err;
      setState(() {
        _visible = !_visible;
      });

      errorAnim();
    }

  }

//error button animation handler
  void errorAnim() async{
    await 3.seconds.delay;
    setState(() {
      _visible = !_visible;
    });
  }

}



class MyButton extends StatelessWidget{

  final buttonColor;
  final textColor;
  final buttonText;
  final buttonPress;

  MyButton({this.buttonColor,this.textColor,this.buttonText,this.buttonPress});

  @override
  Widget build(BuildContext context){
    return Padding(
            padding: const EdgeInsets.all(0.38),
                child: Material(
                  color: buttonColor,
                  child: InkResponse(
                    splashColor: Colors.grey,
                    enableFeedback: true,
                    containedInkWell: false,
                    onTap: buttonPress,
                    highlightShape: BoxShape.circle,
                    child: Center(
                      child: Text(buttonText, style: TextStyle(fontSize:20,fontWeight:FontWeight.bold, color: textColor )),
                    ),
                  ),
                ),


    );
  }

}