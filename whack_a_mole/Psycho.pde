class Psycho
{
  PImage image;
  int yOffset;
  int iterationCount = 0;
  boolean isHitted = false;

  public Psycho( )
  {
    this.image = null;
    this.yOffset = 0;
  }

  public Psycho(String path)
  {
    this.image = loadImage(path);
    this.yOffset = 0;
  }


  boolean drawCylinder(Hole hole)
  {
    //assign variables
    int r = 50;
    int detail = 60;
    float angle = 360 / detail;
    float w = this.image.width / detail;
    boolean isRunning;

    //offset the cylinders a little to the right and rotate them to make it look a little better
    pushMatrix();
    translate(hole.xLocation + 10, hole.yLocation);
    rotateY(radians(90));
    beginShape(QUADS);
    //map the image to the shape created
    texture(this.image);
    for (int i = 0; i < detail; i++)
    {
      vertex(r * cos(radians(i * angle)), -this.yOffset, r * sin(radians(i * angle)), i * w, 0);
      vertex(r * cos(radians((i + 1) * angle)), -this.yOffset, r * sin(radians((i + 1) * angle)), (i + 1) * w, 0);
      vertex(r * cos(radians((i + 1) * angle)), 0, r * sin(radians((i + 1) * angle)), (i + 1) * w, this.yOffset);
      vertex(r * cos(radians(i * angle)), 0, r * sin(radians(i * angle)), i * w, this.yOffset);
    }
    endShape();
    popMatrix();
    //increment/decrement the offset (top 2 vertices) every iteration
    this.yOffset+=dir*5;
    //if the cylinder reached the full height or a height of 0, reverse the direction and increment the iterationCount
    if (this.yOffset >= this.image.height || this.yOffset <= 0)
    {
      dir*=-1;
      this.iterationCount++;
    }
    //if the cylinder has gone to the top and returned, set isRunning global variable to false to randomize the psycho and hole again in the main function
    
    if(this.iterationCount < 2)
    {
       if(mousePressed==true){
         if((mouseX >= hole.xLocation-45 && mouseX <= hole.xLocation+45) && (mouseY <= hole.yLocation && mouseY >= hole.yLocation-this.yOffset)){
           isHitted = true;
           if(iterationCount == 1)
             dir*=-1;
           iterationCount=0;
           isRunning = false;
           return isRunning;
         }
       } 
    }
    if (this.iterationCount == 2)
    {
      iterationCount = 0;
      isRunning = false;
    } 
    else //if not, continue without randomizing to be able to fully complete the movement
       isRunning = true;
       
    return isRunning;
  }
}
