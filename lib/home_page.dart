import 'package:flutter/material.dart';
import 'qa_page.dart';  // Import the Q&A page

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: Text(
          'BreakFree.',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            onPressed: () {
              // Navigate to Q&A Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QAPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Educational Material',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text('Learn more about domestic violence'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOptionButton(context, Icons.menu_book, 'Read', '/read'),
                  _buildOptionButton(context, Icons.security, 'Q&A', '/qa'), // Navigates to Q&A page
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Resources',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text('Get immediate help and support'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOptionButton(context, Icons.camera_alt, 'Capture', '/capture'),
                  _buildOptionButton(context, Icons.medical_services, 'Assistance', '/assistance'),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple[100],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black,
        onTap: (int index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/sos');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Text(
              'SOS',
              style: TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, IconData icon, String label, String route) {
    return Container(
      width: 130,
      height: 130,
      child: ElevatedButton(
        onPressed: () {
          if (route == '/qa') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => QAPage()));  // Navigate to Q&A page
          } else {
            Navigator.pushNamed(context, route);  // Navigate to other pages
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.purple,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.all(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.black,
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
