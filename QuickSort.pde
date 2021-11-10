/* low  --> Starting index,  high  --> Ending index */
void quickSort(Tiles[] t, int low, int high) {
    if (low < high) {
        /* pi is partitioning index, arr[pi] is now
           at right place */
        int pi = partition(t, low, high);

        quickSort(t, low, pi - 1);  // Before pi
        quickSort(t, pi + 1, high); // After pi
    }
}

/* This function takes last element as pivot, places
   the pivot element at its correct position in sorted
    array, and places all smaller (smaller than pivot)
   to left of pivot and all greater elements to right
   of pivot */
int partition(Tiles[] t, int low, int high) {
    // pivot (Element to be placed at right position)
    Tiles pivot = t[high];  
 
    int i = (low - 1);  // Index of smaller element

    for (int j = low; j <= high- 1; j++) {
        // If current element is smaller than the pivot
        if (t[j].getPosition() < pivot.getPosition()) {
            i++;    // increment index of smaller element
            swap(t, i, j);
        }
    }
    swap(t, i + 1, high);
    return (i + 1);
}

void condense() {
  for(int i = 0; i < 16; ++i) {
    if(Tiles[i] == null) {
      int j = i + 1;
      while(j < 16) {
        if(Tiles[j] != null) {
          swap(Tiles, i, j);
          break;
        }
        j++;
      }
      if(j == 16) {
        return;
      }
    }
  }
}

int count() {
  int high = 0;
  while(high < 16 && Tiles[high] != null) {
    high++;
  }
  return high - 1;
}

void swap(Tiles[] t, int i, int j) {
  Tiles temp = t[i];
  t[i] = t[j];
  t[j] = temp;
}
