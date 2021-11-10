int alpha = 250;
int d_alpha = 5;
boolean overwritten = false;

void drawBackground1() {
  fill(#8E6442);
  rect(0, 0, 600, 610);
  fill(#50321A);
  for(int i = 0; i < 16; ++i) {
    rect(((i % 4) * 150) + 5, ((i / 4) * 150) + 5, 140, 140, 7);
  }
  
  stroke(0);
  strokeWeight(3);
  line(0, 610, 600, 610);
  noStroke();
}

void drawBackground2() {  
  background(#8E6442);
  fill(#50321A);
  for(int i = 0; i < 16; ++i) {
    rect(((i % 4) * 150) + 5, ((i / 4) * 150) + 5, 140, 140, 7);
  }
  
  stroke(0);
  strokeWeight(3);
  line(0, 610, 600, 610);
  noStroke();
}

void drawRestartButton() {
  fill(#8E6442);
  rect(0, 613, 600, 90);
  
  PImage img;

  img = loadImage("restart_button.png");
  image(img, 20, 625, 60, 60);
}

void drawScore() {
  fill(#8E6442);
  rect(100, 613, 400, 90);
  
  fill(255);
  textAlign(CENTER, CENTER);
  text("Score: " + score, 300, 650);
}

void drawGameOver() {
  fill(50, opacity1);
  rectMode(CORNER);
  rect(0, 0, 600, 700);
  updateOpacity1();
  
  if(opacity1 >= 200) {
    if(opacity2 == 0) {
      delay(300);
    }
    
    if(score > highscore) {
      drawHighScoreText();
    }
    drawGameOverBox();
  }
}

void drawHighScoreText() {
  if(alpha >= 255 || alpha <= 80) { d_alpha *= -1; }
  alpha += d_alpha;
  fill(255, alpha);
  textSize(65);
  textAlign(CENTER,CENTER);
  text("NEW HIGHSCORE!", 300, 80);
}

void drawGameOverBox() {
  stroke(1);
  strokeWeight(3);
  rectMode(CENTER);
  fill(#8E6442, opacity2);
  rect(300, 350, 400, 350, 10);
  
  noStroke();
  fill(#50321A, opacity2);
  rect(300, 260, 385, 150, 7);
  rect(300, 380, 280, 70, 7);
  rect(300, 470, 280, 70, 7);
  
  
  textAlign(CENTER, CENTER);
  textSize(60);
  fill(255, opacity2);
  text("GAME OVER", 300, 250);
  textSize(35);
  text("Score: " + score, 300, 375);
  textSize(29);
  if(score > highscore) {
    text("Highscore: " + score, 300, 465);
    if(!overwritten) {
      output = createWriter("data/highscore.txt");
      output.print(score);
      output.flush(); // Writes the remaining data to the file
      output.close(); // Finishes the file
      overwritten = true;
    }
  }
  else {
    text("Highscore: " + highscore, 300, 465);
  }
  
  
  rectMode(CORNER);
  
  updateOpacity2();
  
  if(opacity2 >= 250) {
    drawPlayAgainButton();
  }
}

void drawPlayAgainButton() {
  float x = 150, y = 575, w = 300, h = 100;
  
  stroke(1);
  strokeWeight(3);
  rectMode(CORNER);
  if((mouseX >= x && mouseX <= x + w) && (mouseY >= y && mouseY <= y + h)) {
    fill(250);
  }
  else {
    fill(#8E6442);
  }
  rect(x, y, w, h, 70);
  noStroke();
  
  if((mouseX >= x && mouseX <= x + w) && (mouseY >= y && mouseY <= y + h)) {
    fill(0);
  }
  else {
    fill(255);
  }
  
  textAlign(CENTER, CENTER);
  textSize(40);
  text("PLAY AGAIN", 300, 620);
}

void updateOpacity1() {
  if(opacity1 < 200) {
    opacity1 += 2;
  }
}

void updateOpacity2() {
  if(opacity2 < 255) {
    opacity2 += 25;
  }
}

void updateFrame() {
  if(frame < 6) {
    frame++;
  }
}
