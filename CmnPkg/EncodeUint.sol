    pragma solidity >0.4.0 <0.9.0;

contract demo2 {
    bytes public data1 = "NALEHHJSGDSDGHJSDHSUHDJSHDJSHJSHJSHDSJDHJONGVO";
    bytes32 public data2 = "LEHONGVOwjnfvj3weh8vKJ";

    function getData(uint _offst) public view returns(bytes memory) {
        return toBinary(_offst);
    }
    
    function toBinary(uint x) internal pure returns (bytes memory) {
        bytes memory b = new bytes(32);
        assembly {
            mstore(add(b, 32), x)
        }
        uint i;
        if (x & 0xffffffffffffffffffffffffffffffffffffffffffffffff0000000000000000 == 0) {
            i = 24;
        } else if (x & 0xffffffffffffffffffffffffffffffff00000000000000000000000000000000 == 0) {
            i = 16;
        } else {
            i = 0;
        }
        for (; i < 32; i++) {
            if (b[i] != 0) {
                break;
            }
        }
        uint length = 32 - i;
        bytes memory rs = new bytes(length);
        assembly {
            mstore(add(rs, length), x)
            mstore(rs, length)
        }
        return rs;
    }    
} 
        