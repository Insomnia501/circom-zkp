pragma circom 2.1.2;

include "circomlib/poseidon.circom";
// include "https://github.com/0xPARC/circom-secp256k1/blob/master/circuits/bigint.circom";

template Example (nBits) {
    signal input in;
    signal output b[nBits];
    
    for (var i = 0; i < nBits; i++){
        // "/" is zhengshuchufa
        b[i] <-- (in \ 2 ** i) % 2;
    }
    var sum = 0;
    for (var j = 0; j < nBits; j++){
        sum += (2 ** j) * b[j];
    }
    in === sum;
    for (var i = 0; i < nBits; i++){
        0 === b[i] * (b[i] - 1);
    }
}

component main = Example(11);

/* INPUT = {
    "in": "11"
} */
