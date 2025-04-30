import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'detailItem.dart';
import '../components/navbar.dart';

void main() {
  runApp(const AllItemList());
}

class AllItemList extends StatelessWidget {
  const AllItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFA0B25E),
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
      ),
      home: ItemCategory(),
    );
  }
}

class ItemCategory extends StatelessWidget {
  ItemCategory({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> trendingItems = [
    {
      "name": "Tenda Camping",
      "price": 300000,
      "image": "images/assets_ItemDetails/tenda_bg1.png",
      "rating": 4.5
    },
    {
      "name": "Kompor Portable",
      "price": 150000,
      "image": "images/assets_ItemDetails/tenda_bg2.png",
      "rating": 4.3
    },
    {
      "name": "Sepatu Gunung",
      "price": 250000,
      "image": "images/assets_ItemDetails/tenda_bg3.png",
      "rating": 4.7
    },
    {
      "name": "Tas Gunung",
      "price": 350000,
      "image": "images/assets_ItemDetails/tenda_bg4.png",
      "rating": 4.0
    },
    {
      "name": "Senter LED",
      "price": 120000,
      "image": "images/assets_ItemDetails/tenda_bg5.png",
      "rating": 4.8
    },
    {
      "name": "Jaket Gunung",
      "price": 400000,
      "image": "images/assets_ItemDetails/tenda_bg6.png",
      "rating": 4.2
    },
  ];

  final List<String> categories = [
    "All",
    "Tenda",
    "Alat Masak",
    "Sepatu",
    "Tas",
    "Aksesoris",
    "Pakaian"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          
          // Judul halaman + Search bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jelajahi Katalog Barang',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search here',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),



          SliverToBoxAdapter(
            child: SizedBox(height: 8),
          ),

          // Kategori dan tombol
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Bubble kategori scrollable
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: index == 0
                                ? const Color(0xFFA0B25E)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: const Color(0xFFA0B25E)),
                          ),
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: index == 0
                                  ? Colors.white
                                  : const Color(0xFFA0B25E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Tombol Sort
                  GestureDetector(
                    onTap: () {
                      // TODO: Implementasi aksi sort
                      _showFilterBottomSheet(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFA0B25E)),
                      ),
                      child: const Icon(Icons.sort,
                          size: 18, color: Color(0xFFA0B25E)),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Tombol Filter
                  GestureDetector(
                    onTap: () {
                      _showFilterBottomSheet(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFA0B25E)),
                      ),
                      child: const Icon(FontAwesomeIcons.filter,
                          size: 18, color: Color(0xFFA0B25E)),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Grid produk
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildTrendingItem(trendingItems[index], context);
                },
                childCount: trendingItems.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavBar(context, currentIndex: 1),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return FilterBottomSheet(
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }

  Widget _buildTrendingItem(Map<String, dynamic> item, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DetailItem()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(item['image']),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: 10,
              right: 10,
              child: Icon(
                Icons.favorite,
                color: Colors.white,
                size: 28,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rp${item['price']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${item['rating']}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Filter Bottom Sheet class to be added to your file
class FilterBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const FilterBottomSheet({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // Selected filter states
  String? selectedCategory;
  RangeValues priceRange = const RangeValues(0, 1000000);
  int? selectedRating;
  String? selectedLocation;
  String? selectedBrand;

  // Filter options based on the image
  final List<String> categories = ['Tenda', 'Sleeping Bag', 'Alat Masak', 'Kompor Portable'];
  final List<int> ratings = [5, 4, 3];
  final List<String> locations = ['Terdekat dari saya', '5km', '10km', '20km'];
  final List<String> brands = ['Consina', 'Eiger', 'Rei Adventure', 'Avtech'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ListView(
        controller: widget.scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // Filter title
          const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Filter',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Category section
          _buildSectionTitle('Kategori Barang', showViewAll: true),
          const SizedBox(height: 12),
          _buildCategoryFilter(),
          const SizedBox(height: 24),

          // Price section
          _buildSectionTitle('Harga'),
          const SizedBox(height: 12),
          _buildPriceFilter(),
          const SizedBox(height: 24),

          // Rating section
          _buildSectionTitle('Rating'),
          const SizedBox(height: 12),
          _buildRatingFilter(),
          const SizedBox(height: 24),

          // Location section
          _buildSectionTitle('Lokasi'),
          const SizedBox(height: 12),
          _buildLocationFilter(),
          const SizedBox(height: 24),

          // Brand section
          _buildSectionTitle('Brand', showViewAll: true),
          const SizedBox(height: 12),
          _buildBrandFilter(),
          const SizedBox(height: 32),

          // Apply button
          ElevatedButton(
            onPressed: () {
              // Apply the filters and close the bottom sheet
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA0B25E),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Terapkan Filter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool showViewAll = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (showViewAll)
          TextButton(
            onPressed: () {},
            child: const Text(
              'Lihat Semua',
              style: TextStyle(
                color: Color(0xFFA0B25E),
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        final isSelected = selectedCategory == category;
        return FilterChip(
          label: Text(category),
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 14,
          ),
          backgroundColor: isSelected ? const Color(0xFFA0B25E) : const Color(0xFFE0E0E0),
          selectedColor: const Color(0xFFA0B25E),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              selectedCategory = selected ? category : null;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        );
      }).toList(),
    );
  }

  Widget _buildPriceFilter() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              hintText: 'Rp. Terendah',
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              hintText: 'Rp. Tertinggi',
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildRatingChip('Bintang 5', 5),
        _buildRatingChip('Bintang 4 ke atas', 4),
        _buildRatingChip('Bintang 3 ke atas', 3),
      ],
    );
  }

  Widget _buildRatingChip(String label, int value) {
    final isSelected = selectedRating == value;
    return FilterChip(
      label: Text(label),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontSize: 14,
      ),
      backgroundColor: isSelected ? const Color(0xFFA0B25E) : const Color(0xFFE0E0E0),
      selectedColor: const Color(0xFFA0B25E),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          selectedRating = selected ? value : null;
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    );
  }

  Widget _buildLocationFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: locations.map((location) {
        final isSelected = selectedLocation == location;
        return FilterChip(
          label: Text(location),
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 14,
          ),
          backgroundColor: isSelected ? const Color(0xFFA0B25E) : const Color(0xFFE0E0E0),
          selectedColor: const Color(0xFFA0B25E),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              selectedLocation = selected ? location : null;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        );
      }).toList(),
    );
  }

  Widget _buildBrandFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: brands.map((brand) {
        final isSelected = selectedBrand == brand;
        return FilterChip(
          label: Text(brand),
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 14,
          ),
          backgroundColor: isSelected ? const Color(0xFFA0B25E) : const Color(0xFFE0E0E0),
          selectedColor: const Color(0xFFA0B25E),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              selectedBrand = selected ? brand : null;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        );
      }).toList(),
    );
  }
}