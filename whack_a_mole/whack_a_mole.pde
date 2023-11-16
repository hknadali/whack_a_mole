import javax.swing.JOptionPane;

//global variables
int originalWidth, originalHeight;
PFont font, font2;
PImage bg;
int widthRatio, heightRatio;
ArrayList<Psycho> characters;
ArrayList<Hole> holes;
int dir = 1;
boolean isRunning = false;
Psycho character;
Hole hole;
int score, time, timeStart;
int elapsedMinute = 0;

void setup()
{
  //set screen size to the monitor size and set the renderer to 3D
  fullScreen(P3D);
  //load the background image from the folder
  bg = loadImage("background.png");
  //get the width and height of the original picture
  originalWidth = bg.width;
  originalHeight = bg.height;
  //calculate the ratio of the screen width/height to the picture width/height
  widthRatio = displayWidth/originalWidth;
  heightRatio = displayHeight/originalHeight;
  //resize the background image according to the screen size of the monitor
  bg.resize(displayWidth, displayHeight);
  //the points where the pictures should be placed
  noStroke();
  font = createFont("ConcaveFrames.ttf", 90);
  font2 = createFont("ivory_emery.ttf", 75);
  
  //create the "psycho" list
  characters = new ArrayList<Psycho>();
  characters.add(new Psycho("amogus.png"));
  characters.add(new Psycho("saul.png"));
  characters.add(new Psycho("finger.png"));
  characters.add(new Psycho("walter.png"));
  characters.add(new Psycho("jesse.png"));
  characters.add(new Psycho("gus.png"));
  characters.add(new Psycho("hank.png"));
  characters.add(new Psycho("hector.png"));
  characters.add(new Psycho("trollface.png"));

  //create the hole list
  holes = new ArrayList<Hole>();
  for (int i = 0; i < 9; i++)
  {
    int x = 0;
    int y = 0;
    x = 150 + 320 * (i % 3);
    if (i < 3) // couldn't formulate this part
    {
      y = 240;
    } else if (i < 6)
    {
      y = 560;
    } else if (i < 9)
    {
      y = 880;
    }
    holes.add(new Hole(x * widthRatio, y * heightRatio));
  }
  score = 0;
  timeStart = millis();
}

void draw()
{
  background(bg);
  textFont(font);
  text("Whack a Mole", 20*widthRatio, 70*heightRatio);
  textSize(50);
  textFont(font2);
  text("Score:", 450*widthRatio, 70*heightRatio);
  text(score, 500*widthRatio, 70*heightRatio);
  text("Elapsed time:", 725*widthRatio, 70*heightRatio);
  time = millis() - timeStart;
  if(time/1000 == 60){
    elapsedMinute+=1;
    timeStart = millis();
  }
  //elapsedTime = elapsedMinute + " : " + millis()/1000;
  text((elapsedMinute + " : " + time/1000), 825*widthRatio, 70*heightRatio);
  
  //if any list is empty, do not try to run the below code
  if (characters.size() == 0 || holes.size() == 0 || score == 9)
  {
    JOptionPane.showMessageDialog(null, "You are the danger!!", "WINNER", JOptionPane.INFORMATION_MESSAGE);
    noLoop();
    exit();
  }
  //is the function is already running for an instance of Psycho, don't randomize it until it finishes
  if (!isRunning)
  {
    character = characters.get((int)random(0, characters.size()));
    hole = holes.get((int)random(0, holes.size()));
  }
    isRunning = character.drawCylinder(hole);
    if(character.isHitted == true){
       characters.remove(character);
       score++;
    }
    
}
