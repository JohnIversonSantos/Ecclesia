import 'package:flutter/material.dart';
import '../services/local_db_service.dart';
import '../models/diocese.dart';

class DioceseListScreen extends StatefulWidget {
  @override
  _DioceseListScreenState createState() => _DioceseListScreenState();
}

class _DioceseListScreenState extends State<DioceseListScreen> {
  List<Diocese> dioceses = [];

  @override
  void initState() {
    super.initState();
    loadDioceses();
  }

  void loadDioceses() async {
    final db = await LocalDbService().database;
    final data = await db.query('diocese');
    setState(() {
      dioceses = data.map((e) => Diocese.fromMap(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dioceses')),
      body: ListView.builder(
        itemCount: dioceses.length,
        itemBuilder: (context, index) {
          final diocese = dioceses[index];
          return ListTile(
            title: Text(diocese.name),
            subtitle: Text(diocese.region),
            onTap: () {
              // Navigate to VicariateListScreen
            },
          );
        },
      ),
    );
  }
}
