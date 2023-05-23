import 'package:dartworkbench/myButtonIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

import 'myButton.dart';

List<String> buttonNames = [
  'C', '( )', 'divide', '<=',
  '7', '8', '9', 'multiply',
  '4', '5', '6', 'plus',
  '1', '2', '3', 'minus',
  '.', '0', '%', '='
];

bool isOperator(String nameOf)
{
  if(nameOf == 'divide' || nameOf == 'multiply' || nameOf == 'plus' || nameOf == 'minus' || nameOf == '<=' || nameOf == 'C' || nameOf == '( )' || nameOf == '(')
    return true;
  else
    return false;
}

bool isOperatorArithmetic(String nameOf)
{
  if(nameOf == '/' || nameOf == '*' || nameOf == '+' || nameOf == '-' || nameOf == '<=' || nameOf == 'C' || nameOf == '( )' || nameOf == '(' || nameOf == '%')
    return true;
  else
    return false;
}

bool isOperatorIcons(String nameOf)
{
  if(nameOf == 'divide' || nameOf == 'multiply' || nameOf == 'plus' || nameOf == 'minus' || nameOf == '=')
    return true;
  else
    return false;
}

bool isEqual(String nameOf)
{
  if(nameOf == '=')
    return true;
  else
    return false;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  var output = '';
  double charSize = 85;
  int count = 0;
  int bracketCount = 0;
  bool parenthesis = false;
  String errorName = '';

  void OnPressed(String nameOf)
  {
    setState(() {

      if(nameOf == 'plus')
        output += '+';

      else if(nameOf == 'divide')
        output += '/';

      else if(nameOf == 'multiply')
        output += '*';
      
      else if(nameOf == 'minus')
        output += '-';

      else
        output += nameOf;
    });
  }

  void ClearScreen()
  {
    setState(() {
      parenthesis = false;
      output = '';
      CheckSize();
    });
  }

  void ClearDigit()
  {
    setState(() {
      if(output[output.length - 1] == '(')
      {
        parenthesis = false;
        bracketCount--;
      }
      
      if(output[output.length - 1] == ')')
      {
        parenthesis = true;
        bracketCount++;
      }

      output = output.substring(0, output.length-1);
      count = output.length;
      if(count >= 0 && count <= 5)
      {
        charSize = 85;
        return;
      }

      else if(count > 4 && count < 10)
        charSize += 6;

    });
  }

  void Brackets()
  {
    setState(() {

      if(output.length == 0)
      {
        output += '(';
        bracketCount++;
        print("Current count: $bracketCount");
        CheckSize();
        parenthesis = true;
        return;
      }

      else if(parenthesis == false && isOperatorArithmetic(output[output.length - 1]))
      {
        output += '(';
        bracketCount++;
        print("Current count: $bracketCount");
        CheckSize();
        parenthesis = true;
        return;
      }

      else if(isOperatorArithmetic(output[output.length - 1]))
      {
        output += '(';
        bracketCount++;
        print("Current count: $bracketCount");
        CheckSize();
      }

      else if(isOperator(output[output.length - 1]) == false && parenthesis == true)
      {
        output += ')';
        bracketCount--;
        print("Current count: $bracketCount");
        CheckSize();
        if(bracketCount == 0)
          parenthesis = false;
      }
    });
  }

  void Calculate()
  {
    setState(() {
      //parse the expression string
      Parser p = Parser();
      Expression exp = p.parse(output);
      
      // Bind variables:
      ContextModel cm = ContextModel();
      
      // Evaluate expression:
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      output = eval.toString();
      
      if(output[output.length-1] == '0' && output[output.length - 2] == '.')
      {
        output = output.substring(0, output.length - 2);
      }

      CheckSize(); 
    });
  }

  void CheckSize()
  {
    count = output.length;
    setState(() {
      if(count >= 0 && count <= 4)
        charSize = 85;
      
      else if(count == 5)
        charSize = 79;

      else if(count == 6)
        charSize = 73;

      else if(count == 7)
        charSize = 67;
      
      else if(count == 8)
        charSize = 61;
      
      else if(count == 9)
        charSize = 55;

      else if(count == 10)
        charSize = 49;
      
      else
        charSize = 50.0;

      if(charSize < 50.0)
        return;
      
    });
  }

  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children:  [
              //Text area
              Container(
              width: size.width,
              color: Color.fromARGB(255, 200, 203, 206),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                textDirection: TextDirection.ltr,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      output,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: charSize,
                        letterSpacing: 8
                        ),
                      ),
                  ),
                ],
              )
              ),
            DraggableScrollableSheet(
              initialChildSize: 0.754,
              minChildSize: 0.2,
              maxChildSize: 0.754,

              builder: (BuildContext context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                      color: Color(0xff343a40),
                    ),
                  child: ScrollConfiguration(
                    behavior: MaterialScrollBehavior().copyWith(overscroll: false),
                    child: ListView(
                      physics: null,
                      controller: scrollController,
                      children: [
                        Container(
                    height: size.height / 1.41,
                                
                    //buttons grid
                    child: Column(
                      children: [

                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 233, 223, 223),
                                  borderRadius: BorderRadius.circular(20)
                                ),
                              ),
                            ),
                          )
                        ),

                        Expanded(
                          flex: 60,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 28, horizontal: 5),
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: buttonNames.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                              itemBuilder: (context, index) 
                              {
                                if(index == 0) //ClearScreen
                                {
                                  return GestureDetector(
                                  onTap: () => {
                                    ClearScreen(),
                                    HapticFeedback.lightImpact(),
                                    },
                                  
                                  child: myButton(buttonNames[index], Color.fromARGB(255, 233, 105, 105))
                                );
                                }
                                    
                                else if(index == 1) //Parenthesis
                                {
                                  return GestureDetector(
                                  onTap: () => {
                                    Brackets(),
                                    HapticFeedback.lightImpact()
                                    },
                                  
                                  child: (isEqual(buttonNames[index])) ? 
                                    myButton(buttonNames[index], Color.fromARGB(255, 26, 255, 125)) :
                                    myButton(buttonNames[index], isOperator(buttonNames[index]) ?
                                    Color(0xff9a8c98) :
                                    Color(0xfff6f4d2)),
                                );
                                }
                                  
                                else if(index == 3) //BackSpace(ClearDigit)
                                {
                                  return GestureDetector(
                                  onTap: () => {
                                    ClearDigit(),
                                    HapticFeedback.lightImpact(),
                                    },
                                  
                                  onLongPress: () =>
                                  {
                                    ClearScreen(),
                                    HapticFeedback.lightImpact()
                                  },
                                  
                                  child: myButtonIcon(buttonNames[index], Color.fromARGB(255, 233, 105, 105), false)
                                );
                                }
                        
                                else if(index == 19) //Equals Button
                                {
                                  return GestureDetector(
                                  onTap: () {
                                    Calculate();
                                    HapticFeedback.lightImpact();
                                  },
                                  
                                  child: myButton(buttonNames[index], Color.fromARGB(255, 78, 218, 139))
                                );
                                }
                                else
                                {
                                  return GestureDetector(
                                  onTap: () => {
                                    OnPressed(buttonNames[index]),
                                    HapticFeedback.lightImpact(),
                                    CheckSize(),
                                  },
                                    
                                  child: (
                                    isOperatorIcons(buttonNames[index]) ?
                                    myButtonIcon(buttonNames[index], Color(0xff9a8c98), true) :
                                    myButton(buttonNames[index], Color.fromARGB(255, 200, 203, 206))
                                  ),
                                );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                                )
                      ],
                    ),
                  ),
                );
              },
            )
            ]
              ),
        ),
        );
  }
}
