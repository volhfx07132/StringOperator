    pragma solidity >0.4.0 <0.9.0;
    pragma experimental ABIEncoderV2;

    contract demo2 {
        bytes public data1 = "NALEHHJSGDSDGHJSDHSUHDJSHDJSHJSHJSHDSJDHJONGVO";
        bytes public data3 = "sdfNAsdfsdfLEHHJSGDSHDJSHJSHJSHDSJDHJONGVO";
        bytes32 public data2 = "LEHONGVOwjnfvj3weh8vKJ";
        uint8 constant LIST_OFFSET = 0xc0;


        function getData(bool self) public view returns(bytes memory) {
            return encodeBool(self);
        }

        // Encode bool ; true => 0x01 : false => 0x00
        function encodeBool(bool self) internal pure returns (bytes memory) {
            bytes memory rs = new bytes(1);
            if (self) {
                rs[0] = bytes1(uint8(1));
            }
            return rs;
        }


        function encodeList(bytes[] memory self) internal pure returns (bytes memory) {
            if (self.length == 0) {
                return new bytes(0);
            }
            bytes memory payload = self[0];
            for (uint i = 1; i < self.length; i++) {
                payload = mergeBytes(payload, self[i]);
            }
            return mergeBytes(encodeLength(payload.length, LIST_OFFSET), payload);
        }


        function encodeLength(uint length, uint offset) internal pure returns (bytes memory) {
            require(length < 256**8, "input too long");
            bytes memory rs = new bytes(1);
            if (length <= 55) {
                rs[0] = byte(uint8(length + offset));
                return rs;
            }
            bytes memory bl = toBinary(length);
            rs[0] = byte(uint8(bl.length + offset + 55));
            return mergeBytes(rs, bl);
        }

        function mergeBytes(
            bytes memory _preBytes,
            bytes memory _postBytes
        )
        internal
        pure
        returns (bytes memory)
        {
            bytes memory tempBytes;

            assembly {
            // Get a location of some free memory and store it in tempBytes as
            // Solidity does for memory variables.
                tempBytes := mload(0x40)

            // Store the length of the first bytes array at the beginning of
            // the memory for tempBytes.
                let length := mload(_preBytes)
                mstore(tempBytes, length)

            // Maintain a memory counter for the current write location in the
            // temp bytes array by adding the 32 bytes for the array length to
            // the starting location.
                let mc := add(tempBytes, 0x20)
            // Stop copying when the memory counter reaches the length of the
            // first bytes array.
                let end := add(mc, length)

                for {
                // Initialize a copy counter to the start of the _preBytes data,
                // 32 bytes into its memory.
                    let cc := add(_preBytes, 0x20)
                } lt(mc, end) {
                // Increase both counters by 32 bytes each iteration.
                    mc := add(mc, 0x20)
                    cc := add(cc, 0x20)
                } {
                // Write the _preBytes data into the tempBytes memory 32 bytes
                // at a time.
                    mstore(mc, mload(cc))
                }

            // Add the length of _postBytes to the current length of tempBytes
            // and store it as the new length in the first 32 bytes of the
            // tempBytes memory.
                length := mload(_postBytes)
                mstore(tempBytes, add(length, mload(tempBytes)))

            // Move the memory counter back from a multiple of 0x20 to the
            // actual end of the _preBytes data.
                mc := end
            // Stop copying when the memory counter reaches the new combined
            // length of the arrays.
                end := add(mc, length)

                for {
                    let cc := add(_postBytes, 0x20)
                } lt(mc, end) {
                    mc := add(mc, 0x20)
                    cc := add(cc, 0x20)
                } {
                    mstore(mc, mload(cc))
                }

            // Update the free-memory pointer by padding our last write location
            // to 32 bytes: add 31 bytes to the end of tempBytes to move to the
            // next 32 byte block, then round down to the nearest multiple of
            // 32. If the sum of the length of the two arrays is zero then add
            // one before rounding down to leave a blank 32 bytes (the length block with 0).
                mstore(0x40, and(
                add(add(end, iszero(add(length, mload(_preBytes)))), 31),
                not(31) // Round down to the nearest 32 bytes.
                ))
            }

            return tempBytes;
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
            