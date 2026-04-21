package model;

public class payment {
    public payment{
        double amountPaid;
        double discountRate = 0.1; // 10% discount

        double applyDiscount(double totalAmount) {
            return totalAmount - (totalAmount * discountRate);
        }

        void makePayment(double totalAmount) {
            Scanner sc = new Scanner(System.in);

            // Apply discount
            double discountedAmount = applyDiscount(totalAmount);

            System.out.println("Original Amount: Rs. " + totalAmount);
            System.out.println("Discount (10%): Rs. " + (totalAmount * discountRate));
            System.out.println("Amount to Pay: Rs. " + discountedAmount);

            System.out.print("Enter payment amount: Rs. ");
            amountPaid = sc.nextDouble();

            if (amountPaid >= discountedAmount) {
                double balance = amountPaid - discountedAmount;
                System.out.println("✅ Payment Successful!");
                System.out.println("💰 Balance (Remainder): Rs. " + balance);
            } else {
                double remaining = discountedAmount - amountPaid;
                System.out.println("❌ Payment Failed!");
                System.out.println("⚠️ Remaining amount to pay: Rs. " + remaining);
            }
        }
    }
}
