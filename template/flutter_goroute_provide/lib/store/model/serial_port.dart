import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'dart:collection';
import '../../device/sport_protcol.dart';

class SerialDevice with ChangeNotifier {

  List<String> portslist = SerialPort.availablePorts;  

  SerialPort? port;
  String? name;
  int readTime = 10;

  int sendTime = 10;
  int sendTimeout = DateTime.now().millisecondsSinceEpoch;
  StringBuffer buffer = StringBuffer();
  ListQueue qbuffer = ListQueue<String>();
 

  SportProtocol sportProtocol = SportProtocol();


  String get data => qbuffer.join('\n').toString();
  get ports => portslist;

  SerialDevice();


  void init()
  {
     portslist = SerialPort.availablePorts;  
  }

  open(String portName)
  {
     name  = portName;
        
     port = SerialPort(portName);   
     if(port == null) print('open port fail!');    
    
     port?.config.baudRate = 57600;
     port?.config.bits = 8;
     port?.config.parity = 0;
     port?.config.stopBits = 1;
  }

  @override
  void dispose()
  {
    port?.dispose();
  }

  void readData() async {
  // 读数据
  final reader = SerialPortReader(port!, timeout: 10);
  List<String> list = [];
 
  if (!port!.openReadWrite()) {
    print(SerialPort.lastError);
    return;
  }
  //StringBuffer buffer = StringBuffer();
  int timeout = DateTime.now().millisecondsSinceEpoch;
  Timer.periodic(Duration(milliseconds: 5), (timer) {
    if (list.isNotEmpty) {
      int lastTime = DateTime.now().millisecondsSinceEpoch - timeout;
      if (lastTime > readTime) {
        for (var d in list) {
          buffer.write(d.toString());
          if(qbuffer.length > 100) qbuffer.removeFirst();
          qbuffer.add(d.toString());
       //   sportProtocol.inputData(d);
        }
      
        print("接收数据xxx:\d\n${buffer.toString()}");
        notifyListeners();
        buffer.clear();
        list.clear();
        
      }
    }
  });
  reader.stream.listen((data) {
    print('received: $data');
    print('receivedString: ${utf8.decode(data)}'); // 转换为字符串
    String hexString = data.map((byte) => byte.toRadixString(16)).join();
    //String hexString = data.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
    print('receivedHex: ${hexString.toUpperCase()}'); // 转换为16进制
    list.add(hexString);
    sportProtocol.inputData(Uint8List.fromList(data));
    timeout = DateTime.now().millisecondsSinceEpoch;
  });
  //执行接下来的操作
}


void senData(String sendData) async {
  if (sendData.isEmpty) {
    return;
  }
  int lastSendTimeout=DateTime.now().millisecondsSinceEpoch-sendTimeout;
  print(lastSendTimeout);
  if(lastSendTimeout>sendTime){
    List<int> dataList = [];
    int len = sendData.length ~/ 2;
    for (int i = 0; i < len; i++) {
      String data = sendData.trim().substring(2 * i, 2 * (i + 1));
      int? d = _hexToInt2(data);
      dataList.add(d!);
    }
    print('发送数据$sendData');
    print('发送数据${dataList.toString()}');
    //[0xAB, 0xCD, 0xEF]
    var bytes = Uint8List.fromList(dataList);
    port!.write(bytes);
    sendTimeout = DateTime.now().millisecondsSinceEpoch;
  }
}

  int? _hexToInt2(String data) {
    return int.parse(data,radix:16);
  }



}

