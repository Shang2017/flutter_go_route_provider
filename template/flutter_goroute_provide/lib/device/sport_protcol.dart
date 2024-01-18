import 'dart:typed_data';
import 'protocol.dart';

enum ProtocolState {
  WAITHEAD,
  WAITPHYSICID,
  WAITAPPID,
  WAITPRIM,
  WAITPACKET,
  WAITCRC,
}

class PacketInfo{
  int physicID=0;
  int prim=0;
  int appID=0;
  List<int> packet=[];

}


class SportProtocol extends Protocol{

  ProtocolState state = ProtocolState.WAITHEAD;
  ProtocolState inputState = ProtocolState.WAITHEAD;
  static const  List<int> primList = [0x10,0x20,0x21,0x30,0x31,0x32];

  int? physicID;
  int? prim;
  int? appID;
  int crcShort = 0;
  List<int> packet=[];
  List<int> _fullPacket = [];
  PacketInfo pkt = PacketInfo();

 
  
  static bool b7d = false;


  SportProtocol();
  
  void nextState()
  {
    switch(state) 
    {
      case ProtocolState.WAITHEAD:
           state = ProtocolState.WAITPHYSICID;
           break;
      
      case ProtocolState.WAITPHYSICID:
            state = ProtocolState.WAITPRIM;
           break;

      case ProtocolState.WAITPRIM:
            state = ProtocolState.WAITAPPID;
           break;

      case ProtocolState.WAITAPPID:
            state = ProtocolState.WAITPACKET;
           break;

      case ProtocolState.WAITPACKET:
            state = ProtocolState.WAITCRC;
           break;
      case ProtocolState.WAITCRC:
            state = ProtocolState.WAITHEAD;
           break;
      default:
            state = ProtocolState.WAITHEAD;
           break;
    }
   
  }

  void beginState()
  {
    state = ProtocolState.WAITHEAD;
  }

  @override
  bool inputData(Uint8List data)
  {
    while(data.isNotEmpty)
    {
    switch(inputState) 
    {
      case ProtocolState.WAITHEAD:
           if(data[0] == 0x7e) {
            inputState = ProtocolState.WAITPHYSICID;
            _fullPacket = [data[0],];
            b7d = false;
           }
           data = data.sublist(1);
           break;            
      default:
           if(data[0] == 0x7e) {
              inputState = ProtocolState.WAITPHYSICID;
           }
           else if(b7d) {
             if((data[0] == 0x5e) || (data[0] == 0x5d))
             {
                _fullPacket.add(data[0] | 0x70);
                data = data.sublist(1);
             } 
             else {
                inputState = ProtocolState.WAITHEAD;
             }
             b7d = false;
           }
           else{
               if(data[0] == 0x7d) {
                  b7d = true;
               }
               else {
                 _fullPacket.add(data[0]);
               }
               data = data.sublist(1);
               if(_fullPacket.length == 10) {
                  inputState = ProtocolState.WAITHEAD;
                  packets.add(_fullPacket);
               }
           }           
           break;
    }
    }
    return true;
  }


 
  bool tmpProtocolFsm(Uint8List data) {

    while(data.isNotEmpty)
    {
    switch(state) 
    {
      case ProtocolState.WAITHEAD:
           data = handleHead(data);
           break;
      
      case ProtocolState.WAITPHYSICID:
           data =  handlePhysicID(data);
           break;

      case ProtocolState.WAITPRIM:
           data =  handlePrim(data);
           break;

      case ProtocolState.WAITAPPID:
           data =  handleAppID(data);
           break;

      case ProtocolState.WAITPACKET:
           data =  handlePacket(data);
           break;
      case ProtocolState.WAITCRC:
           data =  handleCrc(data);
           break;
      default:
           state = ProtocolState.WAITHEAD;
           break;
    }
    }
    return true;
  }

  

 @override
  bool protocolFsm(Uint8List data)  {

    //start
    if(data[0] != 0x7e) return false;
    int u = data[0];
    if( false == ((u&0x20) == ((u&1) ^ (u&2) ^ (u&4))) &&
        ((u&0x40) == ((u&2) ^ (u&4) ^ (u&8))) &&
        ((u&0x80) == ((u&1) ^ (u&4) ^ (u&0x10)))
    ) return false;
    if(!primList.contains(data[2])) return false;
    if(0xff != crc(data.sublist(2))) return false;
    pkt.physicID = data[1] & 0x1f;
    pkt.prim = data[2];
    pkt.appID = data[3] + data[4]*256;
    pkt.packet = [];
    data.sublist(5,9).map((t){pkt.packet.add(t);});  
    return true;
  }

  Uint8List handleHead(Uint8List data) {
  
    data = data.sublist(0);
    nextState();
    return data;
  }

  ///bit5 = bit0^bit1^bit2
  ///bit6 = bit2^bit3^bit4
  ///bit7 = bit0^bit2^bit4

  Uint8List handlePhysicID(data) {
    int u = data[0];
    if( ((u&0x20) == ((u&1) ^ (u&2) ^ (u&4))) &&
        ((u&0x40) == ((u&2) ^ (u&4) ^ (u&8))) &&
        ((u&0x80) == ((u&1) ^ (u&4) ^ (u&0x10)))
    ){
          data = data.sublist(1);
          physicID = u & 0x1f;
          nextState();
    }else{
      beginState();
    }

    return data;
  }


  Uint8List handlePrim(data) {
    int u = data[0];
    if(primList.contains(u)) {
      prim = u;
      crcShort = u;
      crcAdd(u);
      nextState();
      data = data.sublist[1];
    }
    else {
      beginState();
    }
    return data;
  }

  Uint8List handleAppID(data) {
    int u;
    if(data.length >1){
      appID = data[0] + data[1] * 256;
      u = data[0];
      crcAdd(u);
      u=data[1];
      crcAdd(u);

      data = data.sublist(2);
      nextState();
    }
    return data;
  }



  Uint8List handlePacket(data) {
    int u;
    for(int i=0;i<4;i++) {
      u = data[i];
      packet.add(u);
      crcAdd(u);
    }
    data = data.sublist(4);
    return data;
  }

  Uint8List handleCrc(data) {
    return data;
  }

  crcAdd(int u) {
        crcShort += u; //0-1FE
        crcShort += crcShort >>8;//0-0FF
        crcShort &= 0xFF;
  }

  crc(Uint8List data) {
    crcShort = 0;
    for(int i=0;i<7;i++) {
      crcAdd(data[i]);
    }
    return (crcShort+data[7])&0xff;
  }

  bool crcCheck(int u) {
    if( 0xff == (u + crcShort) & 0xff) {
      return true;
    }
    return false;
  }

 
static const List<int> IDTable =
[
    0x00, 0xA1, 0x22, 0x83, 0xE4, 0x45, 0xC6, 0x67, 
    0x48, 0xE9, 0x6A, 0xCB, 0xAC, 0x0D, 0x8E, 0x2F,
    0xD0, 0x71, 0xF2, 0x53, 0x34, 0x95, 0x16, 0xB7,
    0x98, 0x39, 0xBA, 0x1B, 0x7C, 0xDD, 0x5E, 0xFF
];

}