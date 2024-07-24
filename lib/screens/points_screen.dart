import 'package:flutter/material.dart';
import 'package:bestsender/models/points_model.dart';
import 'package:bestsender/services/points_service.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  _PointsScreenState createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  List<Points> _pointsList = [];

  @override
  void initState() {
    super.initState();
    _loadPoints();
  }

  void _loadPoints() async {
    final pointsService = PointsService();
    final pointsList = await pointsService.getPoints();
    if (mounted) {
      setState(() {
        _pointsList = pointsList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('会员积分管理'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _pointsList.length,
          itemBuilder: (context, index) {
            final points = _pointsList[index];
            return ListTile(
              title: Text('会员ID: ${points.memberId}'),
              subtitle: Text('积分: ${points.points}'),
            );
          },
        ),
      ),
    );
  }
}
