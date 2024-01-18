import 'dart:typed_data';

abstract class Protocol {
  
  bool inputData(Uint8List data);
  bool protocolFsm(Uint8List data);    

  List<List<int>> packets = [];
}