//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

//Add x and y member variables. They will hold the corner location of each segment of the snake.
int segx;
int segy;

// Add a constructor with parameters to initialize each variable.
  public Segment(int x, int y){
    segx=x;
    segy=y;
  }


}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*
Segment head;
int foodx;
int foody;
int direction = UP;
int foodEaten = 0;
ArrayList <Segment> tail = new ArrayList <Segment>();

//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
     size(500,500);
     frameRate(20);
     head = new Segment(250,250);
     dropFood();
}

void dropFood() {
  //Set the food in a new random location
    foodx = ((int)random(50)*10);
    foody = ((int)random(50)*10);
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(0);
  drawFood();
  drawSnake();
  move();
  eat();
}

void drawFood() {
  //Draw the food
  fill(255,2,5);
  rect(foodx, foody, 10, 10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  fill(25,255,25);
  rect(head.segx, head.segy,10,10);
  manageTail();
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
  for(int i=0; i<tail.size(); i++){
    rect(tail.get(i).segx, tail.get(i).segy, 10, 10);
  }
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  checkTailCollision();
  drawTail();
  rect(head.segx, head.segy, 10, 10);
  tail.remove(0);
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for(int i=0; i<tail.size(); i++){
    if(head.segx==tail.get(i).segx && head.segy==tail.get(i).segy){
      foodEaten=1;
      tail = new ArrayList<Segment>();
      tail.add(new Segment(head.segx, head.segy));
    }
  }
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if(keyCode==38){
    direction=UP;
  }
  if(keyCode==39){
    direction=RIGHT;
  }
  if(keyCode==40){
    direction=DOWN;
  }
  if(keyCode==37){
    direction=LEFT;
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.
  
  switch(direction) {
  case UP:
    head.segy-=5;
    break;
  case DOWN:
    head.segy+=5;
    break;
  case LEFT:
   head.segx-=5;
    break;
  case RIGHT:
    head.segx+=5; 
    break;
  }
  checkBoundaries();
}

void checkBoundaries() {
 //If the snake leaves the frame, make it reappear on the other side
 if(head.segx<-10){
   head.segx=510;
 }
 if(head.segx>510){
   head.segx=-10;
 }
 if(head.segy>510){
   head.segy=-10;
 }
 if(head.segy<-10){
   head.segy=510;
 }

}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
  if(head.segx<=foodx && head.segx+10>=foodx+10 && head.segy<=foody && head.segy+10>=foody+10){
    dropFood();
    foodEaten++;
    
    tail.add(new Segment (head.segx, head.segy));
  }
}
