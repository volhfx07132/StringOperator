pragma solidity >0.4.0 <0.9.0;

contract demo2 {
   bytes public data1 = "NALEHHJSGDSDGHJSDHSUHDJSHDJSHJSHJSHDSJDHJONGVO";
   bytes32 public data2 = "LEHONGVOwjnfvj3weh8vKJ";

   function getData(uint _offst, bytes memory _input) public view returns(uint) {
       return bytesToString(_offst, _input);
   }
   
    
    function bytesToString(uint _offst, bytes memory _input, bytes memory _output) internal pure {

        uint size = 32;
        assembly {
            
            let chunk_count
            
            size := mload(add(_input,_offst))
            chunk_count := add(div(size,32),1) // chunk_count = size/32 + 1
            
            if gt(mod(size,32),0) {
                chunk_count := add(chunk_count,1)  // chunk_count++
            }
               
            for { let index:= 0 }  lt(index , chunk_count) { index := add(index,1) } {
                mstore(add(_output,mul(index,32)),mload(add(_input,_offst)))
                _offst := sub(_offst,32)           // _offst -= 32
            }
        }
    }

        
}