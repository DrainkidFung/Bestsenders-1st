import 'package:flutter/material.dart';
import 'package:bestsender/models/order_model.dart';
import 'package:bestsender/services/order_service.dart';
import 'package:intl/intl.dart';
import 'order_tracking_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();

  // 定义表单字段的控制器
  final TextEditingController _originPortController = TextEditingController();
  final TextEditingController _destinationPortController = TextEditingController();
  final TextEditingController _cargoNameController = TextEditingController();
  final TextEditingController _containerQuantityController = TextEditingController();
  final TextEditingController _weightPerContainerController = TextEditingController();

  String? _originServiceMode;
  String? _destinationServiceMode;
  String? _containerType;
  bool _needTemperatureControl = false;
  bool _isDangerousGoods = false;
  DateTime? _shippingDate;
  DateTime? _loadingDate;
  bool _useOwnContainer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自助下单'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildSectionTitle('地点详情'),
              _buildPortInput('发件地址（城市，国家/地区）', _originPortController),
              _buildPortInput('收件地址（城市，国家/地区）', _destinationPortController),
              _buildServiceModeSelection('服务模式（始发地）', true),
              _buildServiceModeSelection('服务模式（目的地）', false),

              _buildSectionTitle('货物信息'),
              _buildTextInput('您希望运输什么货物？', _cargoNameController),
              _buildCheckboxListTile('此货物需要温控', _needTemperatureControl),
              _buildCheckboxListTile('此货物被视为危险货物', _isDangerousGoods),

              _buildSectionTitle('运输方式'),
              _buildContainerTypeDropdown(),
              _buildTextInput('集装箱数量', _containerQuantityController),
              _buildTextInput('每个集装箱的重量 (kg)', _weightPerContainerController),
              _buildCheckboxListTile('我希望使用托运人自己的集装箱', _useOwnContainer),

              _buildDatePicker('起运日期', _shippingDate, (date) => setState(() => _shippingDate = date)),
              _buildDatePicker('装柜日期', _loadingDate, (date) => setState(() => _loadingDate = date)),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitOrder,
                child: const Text('继续订舱'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  Widget _buildPortInput(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.location_on),
      ),
      validator: (value) => value?.isEmpty ?? true ? '请输入$label' : null,
    );
  }

  Widget _buildServiceModeSelection(String title, bool isOrigin) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        RadioListTile<String>(
          title: const Text('我将安排运达集装箱至海港/内陆地点'),
          value: 'CY',
          groupValue: isOrigin ? _originServiceMode : _destinationServiceMode,
          onChanged: (value) => setState(() {
            if (isOrigin) {
              _originServiceMode = value;
            } else {
              _destinationServiceMode = value;
            }
          }),
        ),
        RadioListTile<String>(
          title: const Text('我希望到我的工厂提取/交付集装箱'),
          value: 'SD',
          groupValue: isOrigin ? _originServiceMode : _destinationServiceMode,
          onChanged: (value) => setState(() {
            if (isOrigin) {
              _originServiceMode = value;
            } else {
              _destinationServiceMode = value;
            }
          }),
        ),
      ],
    );
  }

  Widget _buildTextInput(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) => value?.isEmpty ?? true ? '请输入$label' : null,
    );
  }

  Widget _buildCheckboxListTile(String title, bool value) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: (bool? newValue) {
        setState(() {
          if (title.contains('温控')) {
            _needTemperatureControl = newValue ?? false;
          } else if (title.contains('危险货物')) {
            _isDangerousGoods = newValue ?? false;
          } else if (title.contains('自己的集装箱')) {
            _useOwnContainer = newValue ?? false;
          }
        });
      },
    );
  }

  Widget _buildContainerTypeDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(labelText: '集装箱类型和尺寸'),
      value: _containerType,
      items: <String>['20尺标准', '40尺标准', '40尺高柜'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _containerType = newValue;
        });
      },
      validator: (value) => value == null ? '请选择集装箱类型' : null,
    );
  }

  Widget _buildDatePicker(String label, DateTime? selectedDate, Function(DateTime) onDateSelected) {
    return ListTile(
      title: Text(label),
      subtitle: Text(selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate) : '请选择日期'),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked != null && picked != selectedDate) {
          onDateSelected(picked);
        }
      },
    );
  }

  void _submitOrder() async {
    if (_formKey.currentState!.validate()) {
      final orderNumber = 'ORD${DateTime.now().millisecondsSinceEpoch}';
      final order = Order(
        orderNumber: orderNumber,
        originPort: _originPortController.text,
        destinationPort: _destinationPortController.text,
        cargoName: _cargoNameController.text,
        containerType: _containerType ?? '',
        containerQuantity: int.parse(_containerQuantityController.text),
        weightPerContainer: double.parse(_weightPerContainerController.text),
        shippingDate: _shippingDate!,
        loadingDate: _loadingDate!,
        vesselName: 'TBD', // 这些信息可以后续更新
        voyageNumber: 'TBD',
        containerNumbers: List.generate(int.parse(_containerQuantityController.text), (index) => 'CONT${index + 1}'),
        status: '订单已创建',
        originServiceMode: _originServiceMode ?? '',
        destinationServiceMode: _destinationServiceMode ?? '',
        needTemperatureControl: _needTemperatureControl,
        isDangerousGoods: _isDangerousGoods,
        useOwnContainer: _useOwnContainer,
      );

      final orderService = OrderService();
      await orderService.submitOrder(order);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('订单提交成功，订单号: $orderNumber')),
        );

        // 导航到订单跟踪页面
        Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderTrackingScreen()));
      }
    }
  }
}
