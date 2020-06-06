import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.place),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 3.0,
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        color: Colors.blue,
        child: SizedBox(height: 50.0,),
      ),
    );
  }
}
