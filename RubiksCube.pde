// Based on version of Daniel Shiffman (https://github.com/shiffman)

import peasy.*;

PeasyCam cam;

ArrayList<QB> qbs = new ArrayList<QB>();;

int size = 3;

float speed = 0.5;

ArrayList<Move> allMoves = new ArrayList<Move>();

ArrayList<Move> sequence = new ArrayList<Move>();
ArrayList<Move> solver = new ArrayList<Move>();

int counter = 0;

boolean started = false;

boolean shuffeling = false;
boolean solving = false;

Move currentMove;

void setup()
{
  size(600, 600, P3D);
  
  cam = new PeasyCam(this, 0, 0, 0, 100);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(500);
  
  if (size < 2) size = 3;
  if (size % 2 == 0) size++;
      
  for (int z = ((size - 1) / 2) * -1; z <= (size - 1) / 2; z++)
  {
    for (int y = ((size - 1) / 2) * -1; y <= (size - 1) / 2; y++)
    {
      for (int x = ((size - 1) / 2) * -1; x <= (size - 1) / 2; x++)
      {
        PMatrix3D matrix = new PMatrix3D();
        matrix.translate(x, y, z);
        PVector vector = new PVector(x, y, z);
        
        qbs.add(new QB(matrix, vector));
      }
    }
  }
  
  for (int x = ((size - 1) / 2) * -1; x <= (size - 1) / 2; x++)
  {
    if (x != 0)
    {
      Move newMove = new Move(x, 0, 0, 1);
      Move newCounterMove = new Move(x, 0, 0, -1);
      
      allMoves.add(newMove);
      allMoves.add(newCounterMove);
    }
  }
  
  for (int y = ((size - 1) / 2) * -1; y <= (size - 1) / 2; y++)
  {
    if (y != 0)
    {
      Move newMove = new Move(0, y, 0, 1);
      Move newCounterMove = new Move(0, y, 0, -1);
      
      allMoves.add(newMove);
      allMoves.add(newCounterMove);
    }
  }
  
  for (int z = ((size - 1) / 2) * -1; z <= (size - 1) / 2; z++)
  {
    if (z != 0)
    {
      Move newMove = new Move(0, 0, z, 1);
      Move newCounterMove = new Move(0, 0, z, -1);
      
      allMoves.add(newMove);
      allMoves.add(newCounterMove);
    }
  }
}

void solve()
{
  if (!solving)
  {
    solving = true;
    
    if (solver.size() > 0)
    {    
      sequence.clear();
      
      for (int i = solver.size() - 1; i >= 0; i--)
      {
        sequence.add(solver.get(i));
      }
      
      solver.clear();
      
      currentMove = sequence.get(counter);
      currentMove.start();
    }
  }
}

void shuffleCube()
{
  if (!shuffeling)
  {
    shuffeling = true;
    
    solve();
    
    for (int i = 0; i < 25; i++)
    {
      int r = int(random(allMoves.size()));
      
      Move m = allMoves.get(r);
      sequence.add(m);
  
      Move rev = m.copy();
      rev.reverse();
      
      solver.add(rev);
    }
    
    currentMove = sequence.get(0);
    currentMove.start();
  }
}

void draw()
{
  background(32);
  
  scale(10);
  
  rotateX(-(QUARTER_PI * 0.75));
  rotateY(QUARTER_PI);
  rotateZ(0);
  
  if (currentMove != null)
  {
    currentMove.update();
    
    if (currentMove.finished())
    {
      if (counter < sequence.size() - 1)
      {
        counter++;
        currentMove = sequence.get(counter);
        currentMove.start();
      }
      else
      {
        solving = false;
        shuffeling = false;
        
        counter = 0;
        sequence.clear();
        currentMove = null;
      }
    }
  }
  else
  {
    if (sequence.size() > 0)
    {
      currentMove = sequence.get(0);
      currentMove.start();
    }
  }
  
  for (int i = 0; i < qbs.size(); i++)
  {
    push();
    
    if (currentMove != null)
    {
      if (abs(qbs.get(i).vector.z) > 0 && qbs.get(i).vector.z == currentMove.vec.z)
      {
        rotateZ(currentMove.angle);
      }
      else if (abs(qbs.get(i).vector.x) > 0 && qbs.get(i).vector.x == currentMove.vec.x)
      {
        rotateX(currentMove.angle);
      }
      else if (abs(qbs.get(i).vector.y) > 0 && qbs.get(i).vector.y ==currentMove.vec.y)
      {
        rotateY(-currentMove.angle);
      }
    }
    
    qbs.get(i).show();
    pop();
  }
}
