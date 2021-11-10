import java.util.Random;

public class Tiles {
  private static final int SIZE = 125;  
  private final int[] COLRS = {#F0DADA, #E5C797, #E07536, #E34537, #DB94BE, #A37FC1, #7B7FEA, #3EA8C1, #3EC167, #58AF33, #E2E32C};
  private int colr;
  private int value;
  private int position;
  private int combined;
  private int newTile;
  private Random random = new Random();
  
  //Constructor
  public Tiles(int[] p) {
    value = (random.nextInt(2) + 1) * 2;
    colr = COLRS[(int)(Math.log(value) / Math.log(2) + 1e-10) - 1];
    while(p[position = random.nextInt(16)] == 0);
  }
  
  //**********************************************************************************************
  //Getters
  public int getPosition() {
    return position;
  }
  
  public int getColor() {
    return colr;
  }
  
  public int getValue() {
    return value;
  }
  
  public int getCombined() {
    return combined;
  }
  
  public int getNewTile() {
    return newTile;
  }
  
  //**********************************************************************************************
  //Setters
  public void setCombined(int c) {
    combined = c;
  }
  
  public void setNewTile(int n) {
    newTile = n;
  }
  //**********************************************************************************************
  
  //Methods
  public void drawTile(int start_position, int frame) {
    fill(colr);
    float x1 = ((int)start_position % 4) * 150 + 12.5;
    float y1 = ((int)start_position / 4) * 150 + 12.5;
    
    float x2 = ((int)position % 4) * 150 + 12.5;
    float y2 = ((int)position / 4) * 150 + 12.5;
    
    float true_x = (((x2 - x1)/6)*frame) + x1;
    float true_y = (((y2 - y1)/6)*frame) + y1;
    
    rect(true_x, true_y, SIZE, SIZE, 7);
    
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(40);
    text(value, true_x + 61, true_y + 59);
  }
  
  public int[] moveUp(int[] p) {  
    
    //Exclude tiles in the first row
    while(position > 3) {
      //If the position above the tile is NOT occupied, move the tile to that position
      if(p[position - 4] == 1) {
        p[position] = 1;
        position -= 4;
        p[position] = 0;
        move++;
        combined = 0;
        
        score += 5;
      }
      
      //If the position above the tile is occupied
      else if(p[position - 4] == 0) {
        int x = 0;
        
        //Find the other tile in the Tiles array
        while(x < 16 && (Tiles[x] == null || Tiles[x].getPosition() != position - 4)) {
          x += 1;
        }

        //If the value of the other tile is the same as the current tile, combine the two
        if(value == Tiles[x].getValue() && Tiles[x].getCombined() == 0) {
          int prev = 0;
          
          //Find the other tile in the previous positions array
          while(prev < 16 && (previousPositions[prev] == -1 || Tiles[x].getPosition() != position - 4)) {
            prev += 1;
          }
          previousPositions[prev] = -1;
          
          Tiles[x] = null;
          p[position] = 1;
          position -= 4;
          updateValue();
          move++;
          combined = 1;
          
          score += 20;
          break;
        }
        else {
          combined = 0;
          break;
        }
      }
      
      else {
          break;
      }
    }
    newTile = 0;
    return p;
  }
  
  public int[] moveDown(int[] p) {
    
    //Exclude tiles in the last row
    while(position < 12) {
      //If the position above the tile is NOT occupied, move the tile to that position
      if(p[position + 4] == 1) {
        p[position] = 1;
        position += 4;
        p[position] = 0;
        move++;
        combined = 0;
        score += 5;
      }
      
      //If the position below the tile is occupied
      else if(p[position + 4] == 0) {
        int x = 0;
        
        //Find the other tile in the Tiles array
        while(x < 16 && (Tiles[x] == null || Tiles[x].getPosition() != position + 4)) {
          x += 1;
        }

        //If the value of the other tile is the same as the current tile, combine the two
        if(value == Tiles[x].getValue() && Tiles[x].getCombined() == 0) {
          int prev = 0;
          
          //Find the other tile in the previous positions array
          while(prev < 16 && (previousPositions[prev] == -1 || Tiles[x].getPosition() != position + 4)) {
            prev += 1;
          }
          previousPositions[prev] = -1;
          
          Tiles[x] = null;
          p[position] = 1;
          position += 4;
          updateValue();
          move++;
          combined = 1;
          
          score += 20;
          break;
        }
        else {
          combined = 0;
          break;
        }
      }
      
      else {
          break;
      }
    }
    newTile = 0;
    return p;
  }
  
  public int[] moveLeft(int[] p) {
    
    //Exclude tiles in the first column
    while(position % 4 != 0) {
      //If the position above the tile is NOT occupied, move the tile to that position
      if(p[position - 1] == 1) {
        p[position] = 1;
        position -= 1;
        p[position] = 0;
        move++;
        combined = 0;
        
        score += 5;
      }
      
      //If the position to the left of the tile is occupied
      else if(p[position - 1] == 0) {
        int x = 0;
        
        //Find the other tile in the Tiles array
        while(x < 16 && (Tiles[x] == null || Tiles[x].getPosition() != position - 1)) {
          x += 1;
        }

        //If the value of the other tile is the same as the current tile, combine the two
        if(value == Tiles[x].getValue() && Tiles[x].getCombined() == 0) {
          int prev = 0;
          
          //Find the other tile in the previous positions array
          while(prev < 16 && (previousPositions[prev] == -1 || Tiles[x].getPosition() != position - 1)) {
            prev += 1;
          }
          previousPositions[prev] = -1;
          
          Tiles[x] = null;
          p[position] = 1;
          position -= 1;
          updateValue();
          move++;
          combined = 1;
          
          score += 20;
          break;
        }
        else {
          combined = 0;
          break;
        }
      }
      
      else {
          break;
      }
    }
    newTile = 0;
    return p;
  }
  
  public int[] moveRight(int[] p) {
    
    //Exclude tiles in the last column
    while(position %4 != 3) {
      //If the position to the right of the tile is NOT occupied, move the tile to that position
      if(p[position + 1] == 1) {
        p[position] = 1;
        position += 1;
        p[position] = 0;
        move++;
        combined = 0;
        
        score += 5;
      }
      
      //If the position to the right of the tile is occupied
      else if(p[position + 1] == 0) {
        int x = 0;
        
        //Find the other tile in the Tiles array
        while(x < 16 && (Tiles[x] == null || Tiles[x].getPosition() != position + 1)) {
          x += 1;
        }

        //If the value of the other tile is the same as the current tile, combine the two
        if(value == Tiles[x].getValue() && Tiles[x].getCombined() == 0) {
          int prev = 0;
          
          //Find the other tile in the previous positions array
          while(prev < 16 && (previousPositions[prev] == -1 || Tiles[x].getPosition() != position + 1)) {
            prev += 1;
          }
          previousPositions[prev] = -1;
          
          Tiles[x] = null;
          p[position] = 1;
          position += 1;
          updateValue();
          move++;
          combined = 1;
          
          score += 20;
          break;
        }
        else {
          combined = 0;
          break;
        }
      }
      
      else {
          break;
      }
    }
    newTile = 0;
    return p;
  }
  
  public int checkMove(int[] p) {
    return checkUp(p) + checkDown(p) + checkLeft(p) + checkRight(p);
  }
  
  private int checkUp(int[] p) {
    if(position > 3) {
    
      //Check if the position above is occupied
      if(p[position - 4] == 1) {
        return 1;
      }
      
      //If it's occupied, can the two merge
      else {
        int x = 0;
          
        //Find the other tile in the Tiles array
        while(x < 16 && (Tiles[x] == null || Tiles[x].getPosition() != position - 4)) {
          x += 1;
        }
        
        //If the value of the other tile is the same as the current tile, combine the two
        if(value == Tiles[x].getValue() && Tiles[x].getCombined() == 0) {
          return 1;
        }
        
        else {
          return 0;
        }
      }
    }
    else {
      return 0;
    }
  }
  
  private int checkDown(int[] p) {
    if(position < 12) {
    
      //Check if the position above is occupied
      if(p[position + 4] == 1) {
        return 1;
      }
      
      //If it's occupied, can the two merge
      else {
        int x = 0;
          
        //Find the other tile in the Tiles array
        while(x < 16 && (Tiles[x] == null || Tiles[x].getPosition() != position + 4)) {
          x += 1;
        }
        
        //If the value of the other tile is the same as the current tile, combine the two
        if(value == Tiles[x].getValue() && Tiles[x].getCombined() == 0) {
          return 1;
        }
        
        else {
          return 0;
        }
      }
    }
    else {
      return 0;
    }
  }
  
  private int checkLeft(int[] p) {
    if(position % 4 != 0) {
    
      //Check if the position above is occupied
      if(p[position - 1] == 1) {
        return 1;
      }
      
      //If it's occupied, can the two merge
      else {
        int x = 0;
          
        //Find the other tile in the Tiles array
        while(x < 16 && (Tiles[x] == null || Tiles[x].getPosition() != position - 1)) {
          x += 1;
        }
        
        //If the value of the other tile is the same as the current tile, combine the two
        if(value == Tiles[x].getValue() && Tiles[x].getCombined() == 0) {
          return 1;
        }
        
        else {
          return 0;
        }
      }
    }
    else {
      return 0;
    }
  }
  
  private int checkRight(int[] p) {
    if(position % 4 != 3) {
    
      //Check if the position above is occupied
      if(p[position + 1] == 1) {
        return 1;
      }
    
      //If it's occupied, can the two merge
      else {
        int x = 0;
        
        //Find the other tile in the Tiles array
        while(x < 16 && (Tiles[x] == null || Tiles[x].getPosition() != position + 1)) {
          x += 1;
        }
        
        //If the value of the other tile is the same as the current tile, combine the two
        if(value == Tiles[x].getValue() && Tiles[x].getCombined() == 0) {
          return 1;
        }
        
        else {
          return 0;
        }
      }
    }
    else {
      return 0;
    }
  }
  
  public void updateValue() {
    value *= 2;    
    colr = COLRS[(int)(Math.log(value) / Math.log(2) + 1e-10) - 1];
  }
}
