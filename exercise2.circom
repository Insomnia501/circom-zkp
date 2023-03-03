pragma circom 2.1.2;

include "circomlib/poseidon.circom";
// include "https://github.com/0xPARC/circom-secp256k1/blob/master/circuits/bigint.circom";

template Num2Bit (nBits) {
    signal input in;
    signal output b[nBits];
    
    for (var i = 0; i < nBits; i++){
        // "/" is integerdevide
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

template IsZero () {
    //Specification: If in is zero, out should be 1. If in is nonzero, out should be 0. This one is a little tricky!
    signal input in;
    signal output out;
    signal inv;
    //out <-- in!=0 ? 0 : 1;
    inv <-- in!=0 ? 1/in : 0;

    out <== -in*inv +1;
    in*out === 0;
}

template IsEqual () {
    //If in[0] is equal to in[1], out should be 1. Otherwise, out should be 0.
    signal input in[2];
    signal output out;
    component iz = IsZero();
    var tmp = (in[1] - in[0]);
    iz.in <== tmp;
    out <== iz.out;
    out * (out-1) === 0;
}

template Selector (nChoices) {
    //Specification: The output out should be equal to in[index]. 
    //If index is out of bounds (not in [0, nChoices)), out should be 0.
    signal input in[nChoices];
    signal input index;
    signal output out;
    component calcTotal = CalculateTotal(nChoices);
    component eqs[nChoices];

    // For each item, check whether its index equals the input index.
    for (var i = 0; i < nChoices; i ++) {
        eqs[i] = IsEqual();
        eqs[i].in[0] <== index;
        eqs[i].in[1] <== i;
        calcTotal.in[i] <== eqs[i].out * in[i];
    }
    out <== calcTotal.out;
}

template IsNegative () {
    //TODO
}

template LessThan () {
    //Specification: If in[0] is strictly less than in[1], out should be 1. Otherwise, out should be 0
    signal input in[2];
    signal output out;
    signal tmp;
    tmp <-- (in[1] - in[0]) / abs(in[1] - in[0]);//1 -> 1 -1 -> 0
    out <== (tmp+1) / 2;
    out * (out-1) === 0;
}

template IntegerDivide () {
    //TODO
}

//component main = Example(11);
