import 'package:flutter/material.dart';

class Candy2 extends StatefulWidget {
  @override
  _Candy2 createState() => _Candy2();
}

class _Candy2 extends State<Candy2> {
  final List<List<int>> _grid = [
    [1, 2, 3, 4,5],
    [6, 7, 8,9,10],
    [ 11, 12,13, 14, 15],
    [16,17,18,19,20],
  ];

  final List<String> _images = [
    'assets/images/bombs/blue.png',
    'assets/images/bombs/green.png',
    'assets/images/bombs/orange.png',
    'assets/images/bombs/purple.png',
    'assets/images/bombs/red.png',
    'assets/images/bombs/yellow.png'
  ];

  void _onTap(int row, int col) {
    setState(() {
      // Swap the candy with the candy to its right
      if (col < _grid[row].length - 1) {
        final temp = _grid[row][col];
        _grid[row][col] = _grid[row][col + 1];
        _grid[row][col + 1] = temp;
      }

      // Check for matches
      for (var i = 0; i < _grid.length; i++) {
        for (var j = 0; j < _grid[i].length; j++) {
          final candy = _grid[i][j];
          if (candy == 0) {
            continue; // Empty cell
          }

          // Check horizontal
          if (j < _grid[i].length - 2 &&
              _grid[i][j + 1] == candy &&
              _grid[i][j + 2] == candy) {
            _grid[i][j] = 0;
            _grid[i][j + 1] = 0;
            _grid[i][j + 2] = 0;
          }

          // Check vertical
          if (i < _grid.length - 2 &&
              _grid[i + 1][j] == candy &&
              _grid[i + 2][j] == candy) {
            _grid[i][j] = 0;
            _grid[i + 1][j] = 0;
            _grid[i + 2][j] = 0;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Candy Crush"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/background3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _grid.length; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var j = 0; j < _grid[i].length; j++)
                        GestureDetector(
                          onTap: () => _onTap(i, j),
                          child: Container(
                            margin: EdgeInsets.all(4),
                            width: 50,
                            height: 50,
                            child: Image.asset(
                              _images[_grid[i][j] % _images.length],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
