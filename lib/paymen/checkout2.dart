import 'package:flutter/material.dart';
import 'thankyouPage.dart'; // pastikan nama file kamu kecil semua

class Checkout2 extends StatefulWidget {
  @override
  _Checkout2State createState() => _Checkout2State();
}

class _Checkout2State extends State<Checkout2> {
  String selectedPayment = 'Credit Card';
  bool saveCardDetails = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Checkout2', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildStepIndicator(),
            const SizedBox(height: 24),
            buildPaymentOptions(),
            const SizedBox(height: 24),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    buildCardSelection(),
                    const SizedBox(height: 24),
                    buildTextField('Card Holder Name'),
                    const SizedBox(height: 16),
                    buildTextField('Card Number', keyboardType: TextInputType.number),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: buildTextField('Month/Year')),
                        const SizedBox(width: 16),
                        Expanded(child: buildTextField('CVV', keyboardType: TextInputType.number)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildDropdownCountry(),
                    const SizedBox(height: 16),
                    buildSaveCardCheckbox(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            buildConfirmButton(context, _formKey),
          ],
        ),
      ),
    );
  }

  // Step Indicator
  Widget buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        stepCircle(isActive: false),
        stepLine(),
        stepCircle(isActive: true),
      ],
    );
  }

  Widget stepCircle({required bool isActive}) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isActive
                ? null
                : Border.all(color: const Color(0xFF627D2C), width: 2),
            color: isActive ? const Color(0xFF627D2C) : Colors.transparent,
          ),
          child: Center(
            child: Icon(
              Icons.check,
              size: 16,
              color: isActive ? Colors.white : const Color(0xFF627D2C),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isActive ? 'Payment Method' : 'Rent Confirmation',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget stepLine() {
    return Container(
      width: 40,
      height: 2,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  // Payment Options
  Widget buildPaymentOptions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                selectedPayment = 'QRIS Payment QR';
              });
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: selectedPayment == 'QRIS Payment QR'
                    ? const Color(0xFF627D2C)
                    : Colors.grey,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              backgroundColor: selectedPayment == 'QRIS Payment QR'
                  ? const Color(0xFFFAF9F7)
                  : Colors.white,
            ),
            child: const Text('QRIS Payment QR', style: TextStyle(color: Colors.black)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedPayment = 'Credit Card';
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF627D2C),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Credit Card', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  // Card Selection
  Widget buildCardSelection() {
    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.amber[700],
                  image: const DecorationImage(
                    image: AssetImage('assets/credit_card_gold.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Positioned(
                bottom: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 12,
                  child: Icon(Icons.check, size: 16, color: Color(0xFF627D2C)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[300],
            ),
          ),
        ),
      ],
    );
  }

  // Text Field
  Widget buildTextField(String label, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFBCCB9F)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF627D2C)),
        ),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  // Country Dropdown
  Widget buildDropdownCountry() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintText: 'Choose your country',
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFBCCB9F)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF627D2C)),
        ),
      ),
      items: ['Indonesia', 'Malaysia', 'Singapore', 'Other'].map((country) {
        return DropdownMenuItem(
          value: country,
          child: Text(country),
        );
      }).toList(),
      onChanged: (value) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your country';
        }
        return null;
      },
    );
  }

  // Save Card Checkbox
  Widget buildSaveCardCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: saveCardDetails,
          onChanged: (value) {
            setState(() {
              saveCardDetails = value!;
            });
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          activeColor: const Color(0xFF627D2C),
        ),
        const Text('Save credit card details'),
      ],
    );
  }

  // Confirm Button
  Widget buildConfirmButton(BuildContext context, GlobalKey<FormState> formKey) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order Confirmed!')),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ThankYouPage()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF627D2C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text(
          'CONFIRM ORDER',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
