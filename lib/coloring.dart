import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk DateFormat

class ColoringPage extends StatefulWidget {
  final Function(Map<String, String>) onAddToCart;

  ColoringPage({required this.onAddToCart});

  @override
  _ColoringPageState createState() => _ColoringPageState();
}

class _ColoringPageState extends State<ColoringPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00148D),
        toolbarHeight: 80.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'img/logo.jpg',
              height: 50,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFCBCB),
              Color(0xFFFFEAE3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Image and Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 16),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('img/coloring0.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Coloring",
                          style: TextStyle(
                            fontFamily: 'Dancing Script',
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.pinkAccent,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black45,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Image Grid
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(4, (index) {
                    List<String> imageList = [
                      'img/coloring3.jpg',
                      'img/coloring1.jpg',
                      'img/coloring2.jpg',
                      'img/coloring0.jpg',
                    ];
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imageList[index]), // Periksa path file gambar
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20),

                // Price, Date, and Time
                Center(
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.attach_money, color: Colors.pinkAccent),
                        SizedBox(width: 8),
                        Text(
                          "Harga: Rp 250.000",
                          style: TextStyle(
                            fontFamily: 'EB Garamond',
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Select Date with Icon
                ListTile(
                  title: Text(
                    'Tanggal: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'EB Garamond',
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.calendar_today, color: Colors.black),
                  onTap: () => _selectDate(context),
                ),
                SizedBox(height: 20),

                // Select Time with Icon
                ListTile(
                  title: Text(
                    'Waktu: ${selectedTime.format(context)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'EB Garamond',
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.access_time, color: Colors.black),
                  onTap: () => _selectTime(context),
                ),
                SizedBox(height: 20),

                // Add to Cart Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Map<String, String> serviceDetails = {
                        'service': 'Coloring',
                        'time': '${selectedTime.format(context)} on ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                        'price': '250000'
                      };
                      widget.onAddToCart(serviceDetails);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Coloring added to cart for ${selectedTime.format(context)} on ${DateFormat('dd/MM/yyyy').format(selectedDate)}')),
                      );
                    },
                    icon: Icon(Icons.shopping_cart),
                    label: Text("Add to Cart"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 10,
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
