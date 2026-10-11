public class BubbleSort {
    public static void main(String[] args) {
        int[] arr = {5, 3, 8, 6, 7};
        
        // loop through all array elements
        for (int i = 0; i < arr.length - 1; i++) {
            // loop through the remaining 
            // unsorted part of the array
            for (int j = 0; j < arr.length - i - 1; j++) {
                // if this element is greater than 
                //the next one, swap them
                if (arr[j] > arr[j + 1]) {
                    int temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }
        
        // print the sorted array
        for (int i : arr) {
            System.out.print(i + " ");
        }
    }
}