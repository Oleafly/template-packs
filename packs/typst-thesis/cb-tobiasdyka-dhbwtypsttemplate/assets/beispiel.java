public class Beispiel {

    public static int fakultaet(int n) {
        if (n <= 1) return 1;
        return n * fakultaet(n - 1);
    }

    public static void main(String[] args) {
        int ergebnis = fakultaet(5);
        System.out.println("5! = " + ergebnis);
    }
}