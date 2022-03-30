pragma solidity >0.4.0 <0.9.0;

contract demo2 {
   bytes public data1 = "NALEHONGVO";
   bytes public data2 = "LEHONGVOwjnfvj3weh8vhsadfjoif";

   function getData(bytes memory _preBytes,  uint _start) public view returns(address) {
       return toAddress(_preBytes, _start);
   }

    function toAddress(bytes memory _bytes, uint _start) internal  pure returns (address) {
        require(_bytes.length >= (_start + 20));
        address tempAddress;

        assembly {
            tempAddress := div(mload(add(add(_bytes, 0x20), _start)), 0x1000000000000000000000000)
        }

        return tempAddress;
    }

}