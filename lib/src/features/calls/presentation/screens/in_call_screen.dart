import 'package:flutter/material.dart';

class InCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('In Call Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/sarah.png'),
                ),
                SizedBox(width: 16),
                Column(
                  children: [
                    Text(
                      'Sarah',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.grey),
                        SizedBox(width: 4),
                        Text('3.75'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 32),
            Text(
              'Time remaining: 2:30:45',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {},
                  color: Colors.green,
                  iconSize: 32,
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {},
                  color: Colors.red,
                  iconSize: 32,
                ),
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {},
                  color: Colors.blue,
                  iconSize: 32,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Saving...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '3 mistakes',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}