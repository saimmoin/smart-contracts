//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Verify {
    function verifySignature(address _from, address _to, uint _value, bytes memory _signature, address _signer) external pure returns(bool) {
        bytes32  hashedMessage = keccak256(abi.encodePacked(_from, _to, _value));
        bytes32  ethSignedMessage =  keccak256( abi.encodePacked("\x19Ethereum Signed Message:\n32",  hashedMessage));

        return recoverSigner(ethSignedMessage, _signature) == _signer;

    } 
    function recoverSigner(bytes32 _ethSignedMessageHash, bytes memory signature) internal pure returns(address) {
        require(signature.length == 65, "invalid signature length");
        bytes32 r;
        bytes32 s; 
        uint8 v;
        assembly {
            /*
            First 32 bytes stores the length of the signature

            add(sig, 32) = pointer of sig + 32
            effectively, skips first 32 bytes of signature

            mload(p) loads next 32 bytes starting at the memory address p into memory
            */

            // first 32 bytes, after the length prefix
            r := mload(add(signature, 32))
            // second 32 bytes
            s := mload(add(signature, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(signature, 96)))
        }
        // I M P O R T A N T 
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

}