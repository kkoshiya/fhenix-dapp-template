// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@fhenixprotocol/contracts/FHE.sol";
import "@fhenixprotocol/contracts/access/Permissioned.sol";

contract Conditional is Permissioned {
    
    euint8 public _largestNumber = FHE.asEuint8(1);
    euint8 public _cipherText = FHE.asEuint8(0); 

    function setCipherText(inEuint8 calldata _encryptedNumber) public  {
        // convert inEuint8 type structure to euint8 
        _cipherText = FHE.asEuint8(_encryptedNumber);
    }

    function addCipherText(inEuint8 calldata _encryptedNumber) public {
        // simple addition operation
        _cipherText = _cipherText.add(FHE.asEuint8(_encryptedNumber));
    }

    // function BADaddCipherText(inEuint16 calldata _encryptedNumber) public {
    //     // simple addition operation
    //     _cipherText = _cipherText.add(FHE.asEuint16(_encryptedNumber));
    // }

    function setHighestNumber(inEuint8 calldata _encryptedNumber) public {
        euint8 _number = FHE.asEuint8(_encryptedNumber);
        //ebool is set depending on which number is greater
        ebool _greater = _number.gt(_largestNumber);
        euint8 _updated = FHE.select(_greater, _number, _largestNumber);
        _largestNumber = _updated;
    }

    function getSealedOutput(Permission memory signature) public view returns (string memory) {
        // Seal the output for a specific publicKey
        return FHE.sealoutput(_largestNumber, signature.publicKey);
    }

}
