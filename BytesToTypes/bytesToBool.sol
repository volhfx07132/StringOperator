pragma solidity >0.4.0 <0.9.0;

contract demo2 {
   bytes public data1 = "NALEHHJSGDSDGHJSDHSUHDJSHDJSHJSHJSHDSJDHJONGVO";
   bytes32 public data2 = "LEHONGVOwjnfvj3weh8vKJ";

   function getData(uint _offst, bytes memory _input) public view returns(bool) {
       return bytesToBool(_offst, _input);
   }
     //Check address id address exists return true else return false;
    function bytesToBool(uint _offst, bytes memory _input) internal pure returns (bool _output) {
        
        uint8 x;
        assembly {
            x := mload(add(_input, _offst))
        }
        x==0 ? _output = false : _output = true;
    }   
        
}