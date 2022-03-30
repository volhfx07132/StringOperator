pragma solidity >0.4.0 <0.9.0;

contract demo2 {
   bytes public data1 = "NALEHHJSGDSDGHJSDHSUHDJSHDJSHJSHJSHDSJDHJONGVO";
   bytes32 public data2 = "LEHONGVOwjnfvj3weh8vKJ";

   function getData(bytes memory _preBytes,  uint _start) public view returns(bytes32) {
       return toBytes32(_preBytes, _start);
   }
    // Convert bytes to uint
   
    function toBytes32(bytes memory _bytes, uint _start) internal  pure returns (bytes32) {
        require(_bytes.length >= (_start + 32));
        bytes32 tempBytes32;

        assembly {
            tempBytes32 := mload(add(add(_bytes, 0x20), _start))
        }

        return tempBytes32;
    }
}