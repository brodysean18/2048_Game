import java.io.File;

static int[] openPositions = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
static int[] previousPositions = {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1};

BufferedReader reader;
PrintWriter output;
int highscore;

Tiles[] Tiles = new Tiles[16];

int move;
int frame;

int score = 0;

float opacity1 = 0;
float opacity2 = 0;

int over = 0;

void setup() {
  size(600,700);
  background(#8E6442);
  noStroke();
  
  drawRestartButton();
  
  Tiles[0] = new Tiles(openPositions);
  openPositions[Tiles[0].getPosition()] = 0;
  
  Tiles[1] = new Tiles(openPositions);
  openPositions[Tiles[1].getPosition()] = 0;
  
  Tiles[0].drawTile(Tiles[0].getPosition(), 10);
  Tiles[1].drawTile(Tiles[1].getPosition(), 10);
  
  reader = createReader("highscore.txt"); 
  String s_highscore;
  try {
    s_highscore = reader.readLine();
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
    s_highscore = null;
  }
  highscore = int(s_highscore);
  overwritten = false;
}

void draw() {
  //Check game over
  over = checkGameOver();
  
  //Draw background
  if(over == 0) {
    drawBackground1();
  }
  else if(over == 1) {
    drawBackground2();
  }
  
  //Draw score
  drawScore();
  
  //Draw Tiles
  drawTiles();
  
  //Draw game over screen
  if(over == 1) {
    drawGameOver();
  }
}

void keyPressed() {  
  if (key == CODED) {
    // UP BUTTON PRESSED
    if (keyCode == UP) {
      prepMovement();
      moveUp();
    } 
    
    // DOWN BUTTON PRESSED
    else if (keyCode == DOWN) {
      prepMovement();
      moveDown();
    } 
    
    // LEFT BUTTON PRESSED
    else if (keyCode == LEFT) {
      prepMovement();
      moveLeft();
    } 
    
    // RIGHT BUTTON PRESSED
    else if (keyCode == RIGHT) {
      prepMovement();
      moveRight();
    } 
  }
  
  //Allow all tiles to combine again
  for(int i = 0; i < 16; ++i) {
    if(Tiles[i] != null) {
      Tiles[i].setCombined(0);
    }
  }
}

void mouseClicked() {
  if(checkGameOver() == 1) {  
    if((mouseX >= 150 && mouseX <= 450) && (mouseY >= 575 && mouseY <= 675)) {
      for(int i = 0; i < 16; ++i) {
        Tiles[i] = null;
        openPositions[i] = 1;
        previousPositions[i] = -1;
      }
      score = 0;
      opacity1 = 0;
      opacity2 = 0;
      
      setup();
    }
  }
  
  if(over == 0 && ((mouseX >= 20 && mouseX <= 80) && (mouseY >= 625 && mouseY <= 685))) {
    for(int i = 0; i < 16; ++i) {
        Tiles[i] = null;
        openPositions[i] = 1;
        previousPositions[i] = -1;
      }
      score = 0;
      opacity1 = 0;
      opacity2 = 0;
      
      setup();
  }
}

void drawTiles() {
  int x = 0;
  while(x < 16) {
    if(previousPositions[x] == -1 && Tiles[x] != null && Tiles[x].getNewTile() == 0) {
      Tiles[x].drawTile(Tiles[x].getPosition(), frame);
    }
    else if(Tiles[x] != null && Tiles[x].getNewTile() == 0) {      
      Tiles[x].drawTile(previousPositions[x], frame);
    }
    x += 1;
  }
  
  updateFrame();
  
  if(frame == 6) {
    for(int i = 0; i < 16; ++i) {
      if(Tiles[i] != null && Tiles[i].getNewTile() == 1) {
        Tiles[i].drawTile(Tiles[i].getPosition(), 6);
      }
    }
  }
}

void prepMovement() {
  //Sort tiles array
  condense();
  int high = count();
  quickSort(Tiles, 0, high);
  
  //Reset frames
  frame = 0;
  
  //Save previous tile positions
  for(int i = 0; i < 16; ++i) {
    if(Tiles[i] != null) {
      previousPositions[i] = Tiles[i].getPosition();
    }
    else if(Tiles[i] == null) {
      previousPositions[i] = -1;
    }
  }
  
  move = 0;
}

void moveUp() {
  int x = 0;
  while(x < 16) {
    if(Tiles[x] != null) {
      openPositions = Tiles[x].moveUp(openPositions);
    }
    x += 1;
  }
        
  x = 0;
  while(x < 16 && Tiles[x] != null) {
    x += 1;
  }
  
  if(move > 0) {
    Tiles[x] = new Tiles(openPositions);
    Tiles[x].setNewTile(1);
    openPositions[Tiles[x].getPosition()] = 0;
  }
}

void moveDown() {
  int x = 15;
  while(x >= 0) {
    if(Tiles[x] != null) {
      openPositions = Tiles[x].moveDown(openPositions);
    }
    x -= 1;
  }
  
  x = 0;
  while(x < 16 && Tiles[x] != null) {
    x += 1;
  }
  
  if(move > 0) {
    Tiles[x] = new Tiles(openPositions);
    Tiles[x].setNewTile(1);
    openPositions[Tiles[x].getPosition()] = 0;
  }
}

void moveLeft() {
  int x = 0;
  while(x < 16) {
    if(Tiles[x] != null) {
      openPositions = Tiles[x].moveLeft(openPositions);
    }
    x += 1;
  }
  
  x = 0;
  while(x < 16 && Tiles[x] != null) {
    x += 1;
  }
  
  if(move > 0) {
    Tiles[x] = new Tiles(openPositions);
    Tiles[x].setNewTile(1);
    openPositions[Tiles[x].getPosition()] = 0;
  }
}

void moveRight() {
  int x = 15;
  while(x >= 0) {
    if(Tiles[x] != null) {
      openPositions = Tiles[x].moveRight(openPositions);
    }
    x -= 1;
  }
  
  x = 0;
  while(x < 16 && Tiles[x] != null) {
    x += 1;
  }
  
  if(move > 0) {
    Tiles[x] = new Tiles(openPositions);
    Tiles[x].setNewTile(1);
    openPositions[Tiles[x].getPosition()] = 0;
  }
}

int checkGameOver() {
  int x = 0;
  int moves = 0;
  
  while(x < 16 && Tiles[x] != null) {
    moves += Tiles[x].checkMove(openPositions);
    x++;
  }
  
  if(moves == 0) {
    return 1;
  }else{return 0;}
}
