final String accept = "fFbBuUdDlLrR";

void keyPressed()
{
  if (accept.contains("" + key))
  {
    if (!solving && !shuffeling)
    {
      applyMove(key);
    }
  }
  
  if (key == ' ')
  {
    solve();
  }
  
  if (key == 'x')
  {
    shuffleCube();
  }
}

void applyMove(char move)
{
  switch (move)
  {
    case 'f': 
      //turnZ(1, 1);
      sequence.add(new Move(0, 0, 1, 1));
      break;
    case 'F': 
      //turnZ(1, -1);
      sequence.add(new Move(0, 0, 1, -1));
      break;  
    case 'b': 
      //turnZ(-1, 1);
      sequence.add(new Move(0, 0, -1, 1));
      break;
    case 'B': 
      //turnZ(-1, -1);
      sequence.add(new Move(0, 0, -1, -1));
      break;
    case 'u': 
      //turnY(1, 1);
      sequence.add(new Move(0, 1, 0, 1));
      break;
    case 'U': 
      //turnY(1, -1);
      sequence.add(new Move(0, 1, 0, -1));
      break;
    case 'd': 
      //turnY(-1, 1);
      sequence.add(new Move(0, -1, 0, 1));
      break;
    case 'D': 
      //turnY(-1, -1);
      sequence.add(new Move(0, -1, 0, -1));
      break;
    case 'l': 
      //turnX(-1, 1);
      sequence.add(new Move(1, 0, 0, 1));
      break;
    case 'L': 
      //turnX(-1, -1);
      sequence.add(new Move(1, 0, 0, -1));
      break;
    case 'r': 
      //turnX(1, 1);
      sequence.add(new Move(-1, 0, 0, 1));
      break;
    case 'R': 
      //turnX(1, -1);
      sequence.add(new Move(-1, 0, 0, -1));
      break;
  }
  
  Move rev = sequence.get(sequence.size() - 1).copy();
  rev.reverse();
  
  solver.add(rev);
}
