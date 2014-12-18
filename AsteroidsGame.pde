SpaceShip bob = new SpaceShip();
Star[] susie = new Star[500];
ArrayList <Asteroid> rocksList;
ArrayList <Bullet> bulletList;

public static final int a_corners = 6;
int astXcorners[] = { -12,8,12,6,-11,-5,  };
int astYcorners[] = { -7,-7,0,11,9,0,  };
public static final int rocksNum = 15;

public void setup() 
{
  
  bulletList = new ArrayList <Bullet>();
  rocksList = new ArrayList <Asteroid>();
  size(600, 600);
  for (int i = 0; i < susie.length; i++) {
    susie[i] = new Star();
  }

  for(int r=0;r< rocksNum ;r++){
    rocksList.add( new Asteroid()); 
  }
}
public void draw() 
{
  
  for(int r=0;r<rocksList.size();r++){
    if(rocksList.get(r).distance(bob) < 20){ rocksList.remove(r); }
  }
  background(0);
  for (int i = 0; i < susie.length; i++) {
    susie[i].showStars();
  }       
  for(int r = 0; r < rocksList.size();r++){
    if(rocksList.get(r).distance(bob) < 20) { 
    rocksList.remove(r);
      }
 for(int bb=0;bb<bulletList.size();bb++){
      if(rocksList.get(r).bbDistance(bulletList.get(bb)) < 20){
        rocksList.remove(r); bulletList.remove(bb);
        break;
      }
    }     
  }

 for(Asteroid ast : rocksList){
    ast.move(); 
    ast.show();
  }
  
  bob.move();
  bob.show(); 
  moveShow();
}

public void moveShow(){
  for(int bb=0;bb<bulletList.size();bb++){
    bulletList.get(bb).move(); 
    bulletList.get(bb).show();
  }
}


public void keyPressed() {
  if (keyCode == LEFT) {    //rotate
    bob.rotate(-15);
  }
  if (keyCode == RIGHT) {   //rotate
    bob.rotate(15);
  }
  
  if (keyCode == UP) {     
    bob.accelerate(0.7);
  }

  if (keyCode == DOWN) {
    bob.accelerate(-0.7);
  }
  
  if(keyCode == ' '){
    System.out.println("Bullet!");
    bulletList.add(new Bullet(bob));
  }
  //hyperspace
  if (key == 'h') {
    bob.setX((int)(Math.random()*301));
    bob.setY((int)(Math.random()*301));
  }
}
class SpaceShip extends Floater  
{   
  public void setX(int x) { myCenterX=x; }
  public int getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY=y;}  
  public int getY() { return (int)myCenterY;}  
  public void setDirectionX(double x) {myDirectionX=x; }   
  public double getDirectionX() { return (int)myDirectionX;  }   
  public void setDirectionY(double y) { myDirectionY=y; }  
  public double getDirectionY() { return (int)myDirectionY;  }
  public void setPointDirection(int degrees) { myPointDirection=degrees;  }   
  public double getPointDirection() { return (int)myPointDirection; }
  
  public SpaceShip() {
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
class Star {
  double xPos;
  double yPos;
  public Star() {
    xPos = Math.random()*600;
    yPos = Math.random()*600;
  }
  void showStars() {
    fill((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255));
    ellipse((float)xPos, (float)yPos, 5, 5);
  }
}
public class Asteroid extends Floater {
   private int rotationSpeed; 
   public void setX(int x){myCenterX=x;}
    public int getX(){return (int)myCenterX;}
    public void setY(int y){myCenterY=y;}
    public int getY(){return (int)myCenterY;}
    public void setDirectionX(double x){myDirectionX=x;}
    public double getDirectionX(){return myDirectionX;}
    public void setDirectionY(double y){myDirectionY=y;}
    public double getDirectionY(){return myDirectionY;}
    public void setPointDirection(int degrees){myPointDirection=degrees;}
    public double getPointDirection(){return myPointDirection;}

  public Asteroid() {
    rotationSpeed = (int)((Math.random()*8)-4);
    corners = 4;
    xCorners = new int [corners];
    yCorners = new int [corners];
    myDirectionX = (double)((Math.random()*3)-1);
    myDirectionY = (double)((Math.random()*3)-1);
    myPointDirection = 0;
    myColor = #fff403;
    myCenterX = (double)(Math.random()*500);
    myCenterY = (double)(Math.random()*500);
       
  for (int i = 0; i < corners; i++) { //initializes all the asteroids in the array
      xCorners[i] = astXcorners[i];
      yCorners[i] = astYcorners[i];
    }
   
  }
  public void move() {
    rotate(rotationSpeed); 
    super.move(); //calls original move!
  }
  
   public float distance(SpaceShip shippy){
    return dist((float)myCenterX, (float)myCenterY, shippy.getX(), shippy.getY());
  }
  
   public float bbDistance(Bullet bull){
    return dist((float)myCenterX, (float)myCenterY, bull.getX(), bull.getY());
  }
  
}

public class Bullet extends Floater {

    public void setX(int x){myCenterX=x;}
    public int getX(){return (int)myCenterX;}
    public void setY(int y){myCenterY=y;}
    public int getY(){return (int)myCenterY;}
    public void setDirectionX(double x){myDirectionX=x;}
    public double getDirectionX(){return myDirectionX;}
    public void setDirectionY(double y){myDirectionY=y;}
    public double getDirectionY(){return myDirectionY;}
    public void setPointDirection(int degrees){myPointDirection=degrees;}
    public double getPointDirection(){return myPointDirection;}

  public Bullet(SpaceShip theShip){
    myCenterX = theShip.getX(); myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    double dRadians =myPointDirection*(Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + theShip.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + theShip.getDirectionX();

  }
   public void show(){
    fill(247,162,46);
    ellipse((float)myCenterX,(float)myCenterY, 6, 6);
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
    
    //wrap around screen    
    if (myCenterX >width)
    {     
      myCenterX = 0;
    } else if (myCenterX<0)
    {     
      myCenterX = width;
    }    
    if (myCenterY >height)
    {    
      myCenterY = 0;
    } else if (myCenterY < 0)
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
    for (int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated, yRotatedTranslated);
    }   
    endShape(CLOSE);
  }
} 
