pragma solidity >0.4.0 <0.9.0;

contract demo2 {
   bytes public data1 = "NALEHHJSGDSDGHJSDHSUHDJSHDJSHJSHJSHDSJDHJONGVO";
   bytes32 public data2 = "LEHONGVOwjnfvj3weh8vKJ";

   function getData(uint _start, bytes memory _postBytes) public view returns(address) {
       return bytesToAddress(_start, _postBytes);
   }
    // Convert bytes to uint
    function bytesToAddress(uint _offst, bytes memory _postBytes) internal pure returns (address _output) {
        assembly {
            _output := mload(add(_postBytes, _offst))
        }
    } 
}