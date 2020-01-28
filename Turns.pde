void turnZ(int index, int dir)
{
  for (int i = 0; i < qbs.size(); i++)
  {
    QB qb = qbs.get(i);
    
    if (qb.vector.z == index)
    {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.vector.x, qb.vector.y);
      qb.update(round(matrix.m02), round(matrix.m12), round(qb.vector.z));
      qb.turnFacesZ(dir);
    }
  }
}

void turnY(int index, int dir)
{
  for (int i = 0; i < qbs.size(); i++)
  {
    QB qb = qbs.get(i);
    
    if (qb.vector.y == index)
    {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.vector.x, qb.vector.z);
      qb.update(round(matrix.m02), round(qb.vector.y), round(matrix.m12));
      qb.turnFacesY(dir);
    }
  }
}

void turnX(int index, int dir)
{
  for (int i = 0; i < qbs.size(); i++)
  {
    QB qb = qbs.get(i);
    
    if (qb.vector.x == index)
    {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.vector.y, qb.vector.z);
      qb.update(round(qb.vector.x), round(matrix.m02), round(matrix.m12));
      qb.turnFacesX(dir);
    }
  }
}
