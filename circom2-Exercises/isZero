pragma circom 2.1.2;

include "circomlib/poseidon.circom";
// include "https://github.com/0xPARC/circom-secp256k1/blob/master/circuits/bigint.circom";

template Example () {
    //Specification: If in is zero, out should be 1. If in is nonzero, out should be 0. This one is a little tricky!
    signal input in;
    signal output out;
    signal inv;
    //out <-- in!=0 ? 0 : 1;
    inv <-- in!=0 ? 1/in : 0;

    out <== -in*inv +1;
    in*out === 0;
}

component main { public [ in ] } = Example();

/* INPUT = {
    "in": "0"
} */
