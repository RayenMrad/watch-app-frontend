import 'package:clean_arch/presentation/widgets/Payment-header.dart';
import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? selectedPayment = ''; // Variable to hold the selected payment method

  @override
  Widget build(BuildContext context) {
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
                            leading: Image.asset('assets/images/mastercard.png',
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
                            leading: Image.asset('assets/images/visa.png',
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
                              child: Center(
                                child: const Text(
                                  '+ Add other card',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )),
                          const Divider(),
                          const Text(
                            'Bank Account',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            leading: Image.asset('assets/images/bank.png',
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
                            child: Center(
                              child: const Text(
                                '+ Add Bank',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Subtotal:', style: TextStyle(fontSize: 16)),
                              Text('300 Dt', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Delivery Fee:',
                                  style: TextStyle(fontSize: 16)),
                              Text('10 Dt', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Discount:', style: TextStyle(fontSize: 16)),
                              Text('-50 Dt', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Total:',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '260 Dt',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
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
