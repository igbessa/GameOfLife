import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = false; //used to start and stop program


public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
 buttons = new Life[NUM_ROWS][NUM_COLS]; //empty 
 for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      buttons[r][c] = new Life(r,c);//gets filled, no longer empty
    }
  }
  
  //your code to initialize buffer goes here
  buffer = new boolean[NUM_ROWS][NUM_COLS];
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){ //rules go here
      if(countNeighbors(r,c) == 3){
        //buttons[r][c].setLife(true);
        buffer[r][c] = true;
      }
      else if(countNeighbors(r,c) == 2 && buttons[r][c].getLife() == true){
        //buttons[r][c].setLife(true);
        buffer[r][c] = true;
      }
      else{
        buffer[r][c] = false;
      }
      buttons[r][c].draw();
    }
  }
  
  copyFromBufferToButtons();
}

public void keyPressed() {
  //your code here
  if(key == ' '){
    running = !running;
  }
  if(key == 'c'){
   for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c].setLife(false);
      }
    }
  }
}

public void copyFromBufferToButtons() {
  //your code here
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      if(buffer[r][c] == true){
        buttons[r][c].setLife(true);
      }
      else{
        buttons[r][c].setLife(false);//code setlife and getlife
      }
    }//end inner loop
  }//end outer loop
}

public void copyFromButtonsToBuffer() {
  //your code here
   for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      if(buttons[r][c].getLife() == true){
        buffer[r][c] = true;
      }
      else{
        buffer[r][c] = false;
      }
    }//end inner loop
  }//end outer loop
}

public boolean isValid(int r, int c) {
   if(r < NUM_ROWS && c < NUM_COLS){
    if(r >=0 && c >=0){
      return true;
    }
    else{ return false; }
  }
  else{
    return false; 
  }
}//end isValid

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  if(isValid(row,col) == true){ //&& 
    if(isValid(row-1, col-1) == true){//top left corner
      if(buttons[row-1][col-1].getLife() == true){
        neighbors += 1;
      }
    }
    if(isValid(row-1, col) == true){// top middle
      if(buttons[row-1][col].getLife() == true){
        neighbors += 1;
      }
    }
    if(isValid(row-1, col+1) == true){//top right
      if(buttons[row-1][col+1].getLife() == true){
        neighbors += 1;
      }
    }
    if(isValid(row, col+1) == true){//middle right 
      if(buttons[row][col+1].getLife() == true){
       neighbors += 1;
      }
    }
    if(isValid(row+1, col+1) == true){//bottom right
      if(buttons[row+1][col+1].getLife() == true){
       neighbors += 1;
      }
    }
    if(isValid(row+1, col) == true){//bottom middle 
      if(buttons[row+1][col].getLife() == true){
        neighbors += 1;
      }
    }
    if(isValid(row+1, col-1) == true){//bottom left
      if(buttons[row+1][col-1].getLife() == true){
        neighbors += 1;
     }
    }
    if(isValid(row, col-1) == true){//middle left
     if(buttons[row][col-1].getLife() == true){
        neighbors += 1;
     }
    }
  }
  else{
    neighbors = neighbors + 0;
  }
  return neighbors;
}//end countNeighbors

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    //alive = false;
    alive = false; 
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill( 56, 217, 99 );
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    return alive;
  }
  public void setLife(boolean living) {
    alive = living;
  }
}//end life Class
