import 'package:flutter/material.dart';
import 'package:movies/model/api.dart';

import 'package:movies/model/mode.dart';

class BitcoinPriceScreen extends StatefulWidget {
  const BitcoinPriceScreen({super.key});

  @override
  _BitcoinPriceScreenState createState() => _BitcoinPriceScreenState();
}

class _BitcoinPriceScreenState extends State<BitcoinPriceScreen> {
  late Future<BitcoinPrice> futureBitcoinPrice;

  // List of different types of Bitcoin

  @override
  void initState() {
    super.initState();
    futureBitcoinPrice = ApiService().fetchCurrentBitcoinPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text('Current Bitcoin Price'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Network image below the app bar
          Image.asset(
            'asset/image/bit1.png', // Replace with your image URL
            // Adjust height as needed
            // Adjust fit as needed
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Center(
                child: FutureBuilder<BitcoinPrice>(
                  future: futureBitcoinPrice,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return const Text('No price found.');
                    } else {
                      final price = snapshot.data!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Current Price:',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$${price.rate.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(height: 20),
                          Text(price.description),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                futureBitcoinPrice =
                                    ApiService().fetchCurrentBitcoinPrice();
                              });
                            },
                            child: const Text('Refresh Price'),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
