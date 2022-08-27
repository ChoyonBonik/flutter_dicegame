import 'dart:math';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _diceList = <String>[
    'images/d1.png',
    'images/d2.png',
    'images/d3.png',
    'images/d4.png',
    'images/d5.png',
    'images/d6.png',
    'images/dice.png',
  ];
  int _index1 = 0, _index2 = 0, _diceSum = 0, _point = 0;
  bool _hasGameStarted = false;
  bool _isGameOver = false;
  final _random = Random.secure();
  String _gameFinishedMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
      child: _hasGameStarted? _gamePage() : _startPage(),
      ),
    );
  }

  Widget _startPage(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset('images/dice.png'),
        Text('Lets Play Dice Game with FUN !!!', style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold,
        ),),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 330,
            width: double.infinity,
            child: Column(
              children: [
                Text('RULES!!!'),
                Text('* You can roll two dice. Each dice has six face. These faces contain 1,2,3,4,5 and 6.', textAlign: TextAlign.justify,),
                Text('** After the dice have come to rest, the sum of the spots on the two upward face calculated.', textAlign: TextAlign.justify,),
                Text('*** If the sum is 7 or 11 on the first throw, The players wins.',textAlign: TextAlign.justify,),
                Text('**** If the sum is 2,3 or 12 on the first throw, the players loses',textAlign: TextAlign.justify,),
                Text('***** If the sum is 4,5,6,8,9 or 10 on the first throw, then that sum becomes the players Points. To win, the players must continue rolling the dice until match his points. if in the mid time the sum is 7, then the players should be lose the game',textAlign: TextAlign.justify, ),
              ],
            ),
            color: Colors.deepOrangeAccent,
          ),
        ),
        SizedBox(height: 10,),
        ElevatedButton(
            onPressed: (){
              setState((){
                _hasGameStarted = true;
              });
            },
            child:
            const Text('START'),
        ),
      ],
    );
  }

  Widget _gamePage(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _diceList[_index1],
              height: 100,
              width: 100,
            ),
            SizedBox(width: 10,),
            Image.asset(
              _diceList[_index2],
              height: 100,
              width: 100,
            ),
          ],
        ),
        Text(
          'Dice Sum: $_diceSum',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
        if(_point > 0) Text(
          'Your Points: $_point', style: TextStyle(
          fontSize: 15,
          backgroundColor: Colors.black12,
        ),
        ),
        ElevatedButton(
            onPressed: _isGameOver ? null : _rollTheDice,
            child: Text('ROLL'),
        ),



        if(_point > 0 && !_isGameOver) const Text(
          'Keep Trying until match your point', style: TextStyle(
          fontSize: 18, color: Colors.black87,
        ),
        ),
        if(_isGameOver) Text(_gameFinishedMsg, style: TextStyle(
          fontSize: 25,
        ),),
        if(_isGameOver) ElevatedButton(
            onPressed: _resetGame,
            child: const Text('Play Again'),),
      ],
    );
  }

  void _rollTheDice(){
    setState((){
      _index1 = _random.nextInt(6);
      _index2 = _random.nextInt(6);
      _diceSum = _index1 + _index2 + 2;
      if(_point > 0) {
        _checkSecondThrow();
      } else {
        _checkFirstThrow();
      }
    });
  }

  _resetGame() {
    setState(() {
      _hasGameStarted = false;
      _isGameOver = false;
      _index1 = 0;
      _index2 = 0;
      _diceSum = 0;
      _point = 0;
    });
  }

  void _checkFirstThrow(){
    switch(_diceSum) {
      case 7:
      case 11:
        _gameFinishedMsg = 'You Win !!!';
        _isGameOver = true;
        break;
      case 2:
      case 3:
      case 12:
        _gameFinishedMsg = 'You Lost !!!';
        _isGameOver = true;
        break;
      default:
        _point = _diceSum;
        break;
    }
  }

  void _checkSecondThrow(){
    if(_diceSum == _point) {
      _gameFinishedMsg = 'You Win !!!';
      _isGameOver = true;
    } else if(_diceSum == 7) {
      _gameFinishedMsg = 'You Lost !!!';
      _isGameOver = true;
    }
  }
}
