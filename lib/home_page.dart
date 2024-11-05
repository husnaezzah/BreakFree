import 'package:flutter/material.dart';
import 'qa_page.dart'; // Import the Q&A page
import 'assistance_page.dart'; // Import the Assistance page

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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Report Section
              Text(
                'Report',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text('File evidence to support your report'),
              SizedBox(height: 20),

              // Larger Capture Button
              Container(
                width: 320, // Increased width
                height: 250, // Increased height
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/capture');
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
                        Icons.camera_alt,
                        size: 50, // Larger icon
                        color: Colors.black,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Capture',
                        style: TextStyle(
                          fontSize: 18, // Larger text
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Resources Section
              Text(
                'Resources',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Text('Get immediate help and support'),
              SizedBox(height: 20),

              // Row for Q&A and Assistance Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOptionButton(
                    context,
                    Icons.security,
                    'Q&A',
                    '/qa',
                  ),
                  _buildOptionButton(
                    context,
                    Icons.medical_services,
                    'Assistance',
                    '/assistance', // Ensure this is the correct route
                  ),
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
      width: 150, // Standard width
      height: 150, // Standard height
      child: ElevatedButton(
        onPressed: () {
          if (route == '/qa') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QAPage()), // Navigate to Q&A page
            );
          } else if (route == '/assistance') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AssistancePage()), // Navigate to Assistance page
            );
          } else {
            Navigator.pushNamed(context, route); // Navigate to other pages
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
