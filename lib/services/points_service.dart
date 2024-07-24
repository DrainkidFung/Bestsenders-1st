import 'package:bestsender/models/points_model.dart';

class PointsService {
  Future<List<Points>> getPoints() async {
    // 模拟获取会员积分
    await Future.delayed(const Duration(seconds: 2));
    return [
      Points(
        memberId: 'MEM123456',
        points: 100,
      ),
      // 可以添加更多会员积分
    ];
  }

  Future<void> updatePoints(Points points) async {
    // 模拟更新会员积分
    await Future.delayed(const Duration(seconds: 2));
    // 这里可以添加实际的更新积分逻辑，比如调用API
  }
}
