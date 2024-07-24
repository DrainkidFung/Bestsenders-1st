class Order {
  final String orderNumber;
  final String originPort;
  final String destinationPort;
  final String cargoName;
  final String containerType;
  final int containerQuantity;
  final double weightPerContainer;
  final DateTime shippingDate;
  final DateTime loadingDate;
  final String vesselName;
  final String voyageNumber;
  final List<String> containerNumbers;
  final String status;
  final String originServiceMode;
  final String destinationServiceMode;
  final bool needTemperatureControl;
  final bool isDangerousGoods;
  final bool useOwnContainer;

  Order({
    required this.orderNumber,
    required this.originPort,
    required this.destinationPort,
    required this.cargoName,
    required this.containerType,
    required this.containerQuantity,
    required this.weightPerContainer,
    required this.shippingDate,
    required this.loadingDate,
    required this.vesselName,
    required this.voyageNumber,
    required this.containerNumbers,
    required this.status,
    required this.originServiceMode,
    required this.destinationServiceMode,
    required this.needTemperatureControl,
    required this.isDangerousGoods,
    required this.useOwnContainer,
  });

  // 添加一个空的订单构造函数
  Order.empty()
      : orderNumber = '',
        originPort = '',
        destinationPort = '',
        cargoName = '',
        containerType = '',
        containerQuantity = 0,
        weightPerContainer = 0.0,
        shippingDate = DateTime(1970),
        loadingDate = DateTime(1970),
        vesselName = '',
        voyageNumber = '',
        containerNumbers = [],
        status = '',
        originServiceMode = '',
        destinationServiceMode = '',
        needTemperatureControl = false,
        isDangerousGoods = false,
        useOwnContainer = false;
}
