import 'package:clean_arch/presentation/screens/payment-screens/payment-success-screen.dart';
import 'package:clean_arch/presentation/widgets/headers/Payment-header.dart';
import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  final double totalPrice;

  const PaymentMethodScreen({super.key, required this.totalPrice});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? selectedPayment = ''; // Variable to hold the selected payment method

  @override
  Widget build(BuildContext context) {
    // Assuming fixed delivery fee and discount values
    double deliveryFee = 10.0;
    double discount = 50.0;
    double finalTotal = widget.totalPrice + deliveryFee - discount;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              PaymentHeader(title: 'Payment Method'),
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Credit Card',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            leading: Image.network(
                                'http://192.168.1.13:8000/uploads/images/paiment/mastercard.png',
                                width: 40),
                            title: const Text('MasterCard'),
                            subtitle: const Text('**** 1234'),
                            trailing: Radio<String>(
                              value: 'MasterCard',
                              groupValue: selectedPayment,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedPayment = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            leading: Image.network(
                                'http://192.168.1.13:8000/uploads/images/paiment/visa.png',
                                width: 40),
                            title: const Text('Visa'),
                            subtitle: const Text('**** 5678'),
                            trailing: Radio<String>(
                              value: 'Visa',
                              groupValue: selectedPayment,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedPayment = value;
                                });
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Center(
                              child: Text(
                                '+ Add other card',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          const Divider(),
                          const Text(
                            'Bank Account',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            leading: Image.network(
                                'http://192.168.1.13:8000/uploads/images/paiment/bank.png',
                                width: 40),
                            title: const Text('Al Tijari Bank'),
                            subtitle: const Text('IBAN: ****5678'),
                            trailing: Radio<String>(
                              value: 'Bank',
                              groupValue: selectedPayment,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedPayment = value;
                                });
                              },
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Center(
                              child: Text(
                                '+ Add Bank',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Subtotal:',
                                  style: TextStyle(fontSize: 16)),
                              Text('${widget.totalPrice.toStringAsFixed(2)} Dt',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Delivery Fee:',
                                  style: TextStyle(fontSize: 16)),
                              Text('${deliveryFee.toStringAsFixed(2)} Dt',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Discount:',
                                  style: TextStyle(fontSize: 16)),
                              Text('-${discount.toStringAsFixed(2)} Dt',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total:',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${finalTotal.toStringAsFixed(2)} Dt',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => const PaymentSuccessPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(16),
                                backgroundColor: Colors.black,
                              ),
                              child: const Text(
                                'Pay Now',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
