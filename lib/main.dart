import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  late List<List<String>> grid;
  late bool player1Turn;
  late String winner;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      grid = List.generate(3, (_) => List<String>.filled(3, ""));
      player1Turn = true;
      winner = "";
    });
  }

  void makeMove(int row, int col) {
    if (grid[row][col].isEmpty && winner.isEmpty) {
      setState(() {
        if (player1Turn) {
          grid[row][col] = 'X';
        } else {
          grid[row][col] = 'O';
        }
        player1Turn = !player1Turn;
        checkWinner(row, col);
      });
    }
  }

  void checkWinner(int row, int col) {
    // Check rows, columns, and diagonals for a win
    if (grid[row][0] == grid[row][1] && grid[row][1] == grid[row][2]) {
      winner = grid[row][0];
    } else if (grid[0][col] == grid[1][col] && grid[1][col] == grid[2][col]) {
      winner = grid[0][col];
    } else if (grid[0][0] == grid[1][1] && grid[1][1] == grid[2][2]) {
      winner = grid[0][0];
    } else if (grid[0][2] == grid[1][1] && grid[1][1] == grid[2][0]) {
      winner = grid[0][2];
    } else {
      // Check for a draw
      bool isFull = true;
      for (var row in grid) {
        if (row.contains('')) {
          isFull = false;
          break;
        }
      }
      if (isFull) {
        winner = 'Draw';
      }
    }
  }

  Widget buildGrid() {
    return Column(
      children: List.generate(3, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (col) {
            return GestureDetector(
              onTap: () => makeMove(row, col),
              child: Container(
                width: 80.0,
                height: 80.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.0, // Thickness of the border
                  ),
                ),
                child: Text(
                  grid[row][col],
                  style: const TextStyle(fontSize: 40.0),
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        backgroundColor: const Color.fromARGB(252, 181, 17, 2),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.orange[500],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text(
              winner.isEmpty
                  ? (player1Turn ? "Player X's turn" : "Player O's turn")
                  : "Winner: $winner",
              style: const TextStyle(fontSize: 30.0),
            ),
            const SizedBox(height: 20.0),
            buildGrid(),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: resetGame,             
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(252, 181, 17, 2), // Background color of the button
              ),
              child:const  Text('Reset Game'),
            ),
          ],
        ),
      ),
    );
  }
}
