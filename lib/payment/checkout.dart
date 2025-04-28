import 'package:flutter/material.dart';
import 'checkout2.dart';

void main() {
  runApp(const Checkout());
}

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShippingAddressPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ShippingAddressPage extends StatefulWidget {
  @override
  _ShippingAddressPageState createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  final _formKey = GlobalKey<FormState>();

  bool saveConfirmation = false;

  String? selectedCountry;

  final List<String> countries = ['Indonesia', 'Malaysia', 'Singapore', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Checkout', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildStepIndicator(),
              const SizedBox(height: 24),
              buildTextField('Full Name'),
              const SizedBox(height: 16),
              buildTextField('Email Address', keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              buildTextField('Phone', keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              buildTextField('Address', maxLines: 2),
              const SizedBox(height: 16),
              buildTextField('NPWP'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: buildTextField('Zip Code')),
                  const SizedBox(width: 16),
                  Expanded(child: buildTextField('City')),
                ],
              ),
              const SizedBox(height: 16),
              buildDropdownField(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: saveConfirmation,
                    onChanged: (value) {
                      setState(() {
                        saveConfirmation = value!;
                      });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    activeColor: const Color(0xFF627D2C),
                  ),
                  const Text('Save Rent Confirmation'),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Checkout2(), // GANTI sesuai halaman tujuanmu
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF627D2C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF627D2C), width: 2),
              ),
              child: const Center(
                child: Icon(Icons.check, size: 16, color: Color(0xFF627D2C)),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Rent Confirmation',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Container(
          width: 40,
          height: 2,
          color: Colors.grey[300],
          margin: const EdgeInsets.symmetric(horizontal: 8),
        ),
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Payment Method',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildTextField(String label,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
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
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget buildDropdownField() {
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
      items: countries.map((country) {
        return DropdownMenuItem(
          value: country,
          child: Text(country),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCountry = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your country';
        }
        return null;
      },
    );
  }
}
