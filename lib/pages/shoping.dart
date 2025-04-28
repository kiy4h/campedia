import 'package:flutter/material.dart';
import '../components/navbar.dart';
import '../paymen/checkout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Shoping(),
    );
  }
}

class Item {
  final String name;
  final String type;
  final double price;
  int quantity;
  final String imageUrl;

  Item({
    required this.name,
    required this.type,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}

class Shoping extends StatefulWidget {
  const Shoping({Key? key}) : super(key: key);

  @override
  State<Shoping> createState() => _ShopingState();
}

class _ShopingState extends State<Shoping> {
  List<Item> items = [
    Item(
      name: 'Tenda Dome',
      type: 'TENDA',
      price: 7.2,
      quantity: 3,
      imageUrl: 'https://via.placeholder.com/100',
    ),
    Item(
      name: 'Tenda Dome',
      type: 'TENDA',
      price: 6.3,
      quantity: 1,
      imageUrl: 'https://via.placeholder.com/100',
    ),
    Item(
      name: 'Tenda Dome',
      type: 'TENDA',
      price: 11.4,
      quantity: 2,
      imageUrl: 'https://via.placeholder.com/100',
    ),
    Item(
      name: 'Tenda Dome',
      type: 'TENDA',
      price: 2.7,
      quantity: 1,
      imageUrl: 'https://via.placeholder.com/100',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        currentIndex: 2,
      ),

      body: Column(
        children: [
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Dismissible(
                  key: Key(item.name + index.toString()),
                  background: Container(color: Colors.white),
                  secondaryBackground: Container(
                    color: const Color(0xFF5D6D3E),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      items.removeAt(index);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Image with price badge
                        Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(item.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '\$${item.price}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        // Item details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.type,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Price
                        Text(
                          '\$${(item.price * item.quantity).toStringAsFixed(1)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Quantity selector
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'QTY',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (item.quantity > 1) {
                                        setState(() {
                                          item.quantity--;
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: const Icon(
                                        Icons.remove,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 30,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${item.quantity}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        item.quantity++;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: const Icon(
                                        Icons.add,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // HAPUS bagian bottom bar manual yaa
          // Ini sudah dihapus sesuai request kamu
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(
        context: context,
        currentIndex: 2,
      ),
    );
  }
}



// Function to build AppBar
PreferredSizeWidget buildAppBar({
  required BuildContext context,
  required int currentIndex,
}) {
  String title = '';
  List<Widget> actions = [];

  // Tentukan judul dan aksi berdasarkan currentIndex
  switch (currentIndex) {
    case 0:
      title = 'Home';
      actions = [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: Colors.black),
        ),
      ];
      break;
    case 1:
      title = 'Category';
      actions = [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order placed!')),
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.amber,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          child: const Text('Place Order'),
        ),
      ];
      break;
    case 2:
      title = 'Shopping Cart';
      actions = [
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                DateTime? startDate;
                DateTime? endDate;
                bool isExpanded = false; // untuk kontrol lihat selengkapnya

                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Center(
                        child: Text(
                          'Konfirmasi Akhir',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Bagian Detail Penyewaan
                            Text(
                              'Detail Penyewaan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),

                            // Scrollable List
                            Container(
                              constraints: BoxConstraints(
                                maxHeight: isExpanded ? double.infinity : 150,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Tenda Dome (x2)\nRp50.000 x 2 x 3 Hari = Rp300.000\n'),
                                    Text('Tenda Besar (x1)\nRp80.000 x 1 x 3 Hari = Rp240.000\n'),
                                    Text('Sleeping Bag (x3)\nRp20.000 x 3 x 3 Hari = Rp180.000\n'),
                                    Text('Matras (x2)\nRp15.000 x 2 x 3 Hari = Rp90.000\n'),
                                    Text('Kompor Camping (x1)\nRp30.000 x 1 x 3 Hari = Rp90.000\n'),
                                    Text('Nestle Gas (x1)\nRp20.000 x 1 x 3 Hari = Rp60.000\n'),
                                    Text('Kursi Lipat (x2)\nRp25.000 x 2 x 3 Hari = Rp150.000\n'),
                                    Text('Meja Lipat (x1)\nRp40.000 x 1 x 3 Hari = Rp120.000\n'),
                                    // Tambahin item lain kalau mau
                                  ],
                                ),
                              ),
                            ),

                            // Tombol Lihat Selengkapnya
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Text(isExpanded ? 'Tutup' : 'Lihat Selengkapnya'),
                              ),
                            ),

                            SizedBox(height: 16),

                            // Bagian Durasi Sewa
                            Text(
                              'Durasi Sewa',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                // Tanggal Mulai
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          startDate = picked;
                                        });
                                      }
                                    },
                                    child: AbsorbPointer(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: startDate == null
                                              ? 'DD/MM/YYYY'
                                              : '${startDate!.day.toString().padLeft(2, '0')}/${startDate!.month.toString().padLeft(2, '0')}/${startDate!.year}',
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Icon(Icons.arrow_forward),
                                ),
                                // Tanggal Selesai
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          endDate = picked;
                                        });
                                      }
                                    },
                                    child: AbsorbPointer(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: endDate == null
                                              ? 'DD/MM/YYYY'
                                              : '${endDate!.day.toString().padLeft(2, '0')}/${endDate!.month.toString().padLeft(2, '0')}/${endDate!.year}',
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),

                            // Bagian Total Bayar
                            Text(
                              'Total Bayar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Rp360.000',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'KEMBALI',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Checkout(), // <-- Ganti ini ke page tujuanmu
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green[700],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'BAYAR SEKARANG',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
          child: const Text('Place Order'),
        ),
      ];
      break;



    case 3:
      title = 'Favorite';
      actions = [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order placed!')),
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.amber,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          child: const Text('Place Order'),
        ),
      ];
      break;
    case 4:
      title = 'Profile';
      actions = [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings, color: Colors.black),
        ),
      ];
      break;
    default:
      title = 'App';
  }


  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    actions: actions,
  );
}