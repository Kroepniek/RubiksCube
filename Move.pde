class Move
{
  float angle = 0;
  
  PVector vec;
  
  int dir;
  
  boolean animating = false;
  boolean finished = false;

  Move(int x, int y, int z, int dir)
  {
    this.vec = new PVector(x, y, z);
    
    this.dir = dir;
  }

  Move copy()
  {
    return new Move(int(vec.x), int(vec.y), int(vec.z), dir);
  }

  void reverse()
  {
    dir *= -1;
  }

  void start()
  {
    animating = true;
    finished = false;
    
    this.angle = 0;
  }

  boolean finished()
  {
    return finished;
  }

  void update()
  {
    if (animating)
    {
      angle += dir * speed;
      
      if (abs(angle) > HALF_PI)
      {
        angle = 0;
        
        animating = false;
        finished = true;
        
        if (abs(vec.z) > 0)
        {
          turnZ(int(vec.z), dir);
        }
        else if (abs(vec.x) > 0)
        {
          turnX(int(vec.x), dir);
        }
        else if (abs(vec.y) > 0)
        {
          turnY(int(vec.y), dir);
        }
      }
    }
  }
}
