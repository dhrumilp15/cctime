import 'dart:math';

enum Walls {
  up,
  right,
  left,
  down,
}

class Cell {
  final int row;
  final int col;
  var visited = false;
  var walls = List<bool>(Walls.values.length);

  Cell(this.row, this.col)
  {
    for (var i = 0; i != Walls.values.length; ++i)
    {
      walls[i] = true;
    }
//    print(walls);
  }
}

class Move {
  final Cell from;
  final Cell to;

  Move(this.from,this.to);
}

class Maze {
  final int rows;
  final int cols;
  final List<Cell> maze;
  final skipped = List<Move>();
  final rand = Random(); // to avoid bias with random walking

  int onedtrans(int row, int col) => row * rows + col; // Easier to treat the array as 1d, can map to 2d array in view

  Maze(this.rows, this.cols) : maze = List<Cell>(rows * cols) {
    for (var col = 0; col < cols; ++col)
    {
      for (var row = 0; row < rows; ++row)
      {
        maze[onedtrans(row, col)] = Cell(row, col);
      }
    }
  }

  Cell getCell(int row, int col) => (row < 0 || row >= rows || col < 0 || col >= cols) ? null : maze[onedtrans(row, col)];

  Cell adjacentCell(Cell sourceCell, Walls wall) {
    switch(wall)
    {
      case Walls.up:
        return getCell(sourceCell.row - 1, sourceCell.col );
      case Walls.down:
        return getCell(sourceCell.row + 1, sourceCell.col );
      case Walls.left:
        return getCell(sourceCell.row, sourceCell.col - 1);
      case Walls.right:
        return getCell(sourceCell.row, sourceCell.col + 1);
      default:
        return null;
    }
  }

  List<Cell> binTree(possibleMoves) {
	return possibleMoves
	  .where((cell) => cell.walls[0] != null || cell.walls[1] != null)
	  .toList();
  }



  Iterable<Cell> generate(algValue) sync* { // sync* is basically to clean up making dynamic lists of widgets
    var startcell = getCell(rand.nextInt(rows), rand.nextInt(cols));

    while (true) {
      //yield Cell;
	  startcell.visited = true;

	  yield startcell;

      var possiblemoves = Walls.values
		.map((wall) => adjacentCell(startcell, wall))
		.where((cell) => cell != null && !cell.visited)
		.toList(); // Only handles adjacent cells that exist and haven't been visited

      Move move;

      if (possiblemoves.isNotEmpty) // if you can go to adjacent cells
      {
        List<Cell> upright;

        switch(algValue) // Currently supports scaling for algorithms that only control how new moves are selected
		{
		  default: //This includes the case of Binary Tree
			upright = binTree(possiblemoves);
			break;
		}

        Cell endcell = possiblemoves[rand.nextInt(upright.length)];

        move = Move(startcell, endcell);

        skipped.addAll(
		  possiblemoves
			  .where((cell) => !identical(cell, move.to))
			  .map((cell) => Move(startcell, cell))
		);
      }
      else {// if you've visited the adjacent cells, just jump to an unseen one
        move = skipped.firstWhere((nextmove) => !nextmove.to.visited, orElse: () => null);
	  }

      if (move != null) // Handles breaking down wall between the cells in the move
	  {
		var wallstart = Walls.values
			.firstWhere((wall) => identical(adjacentCell(move.from, wall), move.to));
		var wallend = Walls.values[(4 - (wallstart.index + 1))];

		move.from.walls[wallstart.index] = false;
		move.to.walls[wallend.index] = false;

		startcell = move.to;
	  } else {
        break;
	  }
    }
  }
}
