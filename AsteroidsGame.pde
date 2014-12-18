SpaceShip bob = new SpaceShip();
Star[] susie = new Star[500];
public void setup() 
{
  size(600,600);
  for(int i = 0; i < susie.length ; i++){
    susie[i] = new Star();  
  }
}
public void draw() 
{
  background(0);
for(int i =0; i < susie.length; i++){
  susie[i].showStars(); 
  }
  bob.move();
  bob.show();
 }
public void keyPressed(){
  if(keyCode == LEFT){    //rotate
      bob.rotate(-15);
  }
  if(keyCode == RIGHT){   //rotate
      bob.rotate(15);
  }

// myDirectionX += ((dAmount) * Math.cos(dRadians));    
// myDirectionY += ((dAmount) * Math.sin(dRadians)); 
  if(keyCode == UP){     
     bob.accelerate(0.9);
  }
  
  if(keyCode == DOWN){
     bob.accelerate(-0.9);
  }
    //hyperspace
    if(key == 'h'){
       bob.setX((int)(Math.random()*301));
       bob.setY((int)(Math.random()*301));
    }
}
class SpaceShip extends Floater  
{   
  
    public void setX(int x){myCenterX=x;}
    public int getX(){return (int)myCenterX;}
    public void setY(int y){myCenterY=y;}  
    public int getY(){return (int)myCenterY;}  
    public void setDirectionX(double x){myDirectionX=x;}   
    public double getDirectionX(){return (int)myDirectionX;}   
    public void setDirectionY(double y){myDirectionY=y;}  
    public double getDirectionY(){return (int)myDirectionY;}
    public void setPointDirection(int degrees){myPointDirection=degrees;}   
    public double getPointDirection(){return (int)myPointDirection;}
    public SpaceShip(){
      corners = 3;
      xCorners = new int[corners];   //initialized all the variables
      yCorners = new int[corners];
      myColor = color(255);
      myDirectionX  = 0;
      myDirectionY = 0;
      myPointDirection = 0;
      myCenterX = 300;
      myCenterY = 300;
      xCorners[0] = -8;
      yCorners[0] = -8;
      xCorners[1] = 16;
      yCorners[1] = 0;
      xCorners[2] = -8;
      yCorners[2] = 8;   
  }
}
class Star{
    double xPos;
    double yPos;
  public Star(){
  xPos = Math.random()*600;
  yPos = Math.random()*600;
  }
 void showStars(){
    fill((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255));
    ellipse((float)xPos,(float)yPos,5,5);
 } 

}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 
  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;
    myDirectionX = 0.9 * myDirectionX;
    myDirectionY = 0.9 * myDirectionY;     
    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 
