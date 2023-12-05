// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

import {ContractAImportar} from "./herencia_4.sol";

contract Humano is ContractAImportar{
    string saludo;
    uint256 year;

    constructor (string memory _saludo, uint256 _year) {
        saludo = _saludo;
        year = _year;
    }
}

contract Hombre is Humano {
    uint256 altura;

    constructor (uint256 _altura, string memory _saludo, uint256 _year) Humano(_saludo, _year) {
        altura = _altura;
    }
}

contract Marcos is Humano, Hombre {
    constructor() Hombre(200, "Hola, soy marcos", 2023) {}
}

contract A {
    uint256 a;

    constructor (uint256 _a) {
        a = _a;
    }
}

contract B {
    uint256 b;

    constructor (uint256 _b) {
        b = _b;
    }
}

contract C is A, B {
    constructor() A(3) B(3) {}
}

