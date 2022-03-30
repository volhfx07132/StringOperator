pragma solidity >0.4.0 <0.9.0;

contract demo2 {
   bytes public data1 = "NALEHONGVO";
   bytes public data2 = "LEHONGVOwjnfvj3weh8vhsadfjoif";

   function getData(bytes memory _preBytes,  uint _start) public view returns(uint16) {
       return toUint16(_preBytes, _start);
   }
    // Convert bytes to uint
   
    function toUint16(bytes memory _bytes, uint _start) internal  pure returns (uint16) {
        require(_bytes.length >= (_start + 2));
        uint16 tempUint;

        assembly {
            tempUint := mload(add(add(_bytes, 0x2), _start))
        }

        return tempUint;
    }

}   