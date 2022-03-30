pragma solidity >0.4.0 <0.9.0;

contract demo2 {
   bytes public data1 = "NALEHONGVO";
   bytes public data2 = "LEHONGVOwjnfvj3weh8vhsadfjoif";

   function getData(bytes memory _preBytes,  uint _start) public view returns(uint8) {
       return toUint8(_preBytes, _start);
   }
    // Convert bytes to uint
     function toUint(bytes memory _bytes, uint _start) internal  pure returns (uint256) {
        require(_bytes.length >= (_start + 32));
        uint256 tempUint;

        assembly {
            tempUint := mload(add(add(_bytes, 0x20), _start))
        }

        return tempUint;
    }

}