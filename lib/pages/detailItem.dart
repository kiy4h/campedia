import 'package:flutter/material.dart';
import '../components/navbar.dart';


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
        scaffoldBackgroundColor: const Color(0xFFFFF8E1),
      ),
      home: const DetailItem(),
    );
  }
}

class DetailItem extends StatefulWidget {
  const DetailItem({Key? key}) : super(key: key);

  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _quantity = 3;
  bool _isFavorite = true;
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTab = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Tent Image Section
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/600x400'),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    width: index == 0 ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: index == 0 ? Colors.white : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Content Section
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFF8E1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header info
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TENT',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          'Tenda Dome Naturehike',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Rp 45.000 / hari',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const Text(
                              '4.5',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              ' (128 reviews)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(
                                _isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: Colors.red,
                                size: 28,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isFavorite = !_isFavorite;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(Icons.check_circle, color: Colors.green, size: 18),
                            SizedBox(width: 4),
                            Text(
                              'Available · 3 items',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Tab Bar
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black45,
                    indicatorColor: Colors.amber,
                    indicatorWeight: 3,
                    tabs: const [
                      Tab(text: 'Description'),
                      Tab(text: 'Review'),
                      Tab(text: 'Discussion'),
                    ],
                  ),
                  
                  // Tab Content
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Description Tab
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Naturehike Cloud Up 2 adalah tenda dome ringan dan praktis yang cocok untuk dua orang. Dibuat dari material berkualitas tinggi dan tahan air, tenda ini siap menemani petualangan kamu di alam terbuka — baik di gunung, pantai, maupun hutan.',
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Review Tab
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Single Review
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                                    radius: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Mira A. - Bandung',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Tenda ringan banget dan gampang dipasang! Saya pakai untuk camping di Ranca Upas, hujan semalaman tetap kering. Recommended banget buat yang suka camping.',
                                          style: TextStyle(
                                            fontSize: 15,
                                            height: 1.5,
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
                        
                        // Discussion Tab
                        const Center(
                          child: Text('No discussions yet'),
                        ),
                      ],
                    ),
                  ),
                  
                  // Bottom Section - Quantity and Add to Cart
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'QTY',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  if (_quantity > 1) {
                                    setState(() {
                                      _quantity--;
                                    });
                                  }
                                },
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                iconSize: 20,
                              ),
                              SizedBox(
                                width: 30,
                                child: Center(
                                  child: Text(
                                    '$_quantity',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    _quantity++;
                                  });
                                },
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                iconSize: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'ADD TO CART',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(
        context,
        currentIndex: 1,
      ),
    );
  }
}