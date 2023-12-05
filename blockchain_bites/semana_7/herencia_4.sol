// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract Humano {
    string saludo;
    uint256 year;

    constructor (string memory _saludo, uint256 _year) {
        year = _year;
        saludo = _saludo;
    }
}

// Literal
// Sabes los valores a usar en el constructor a priori

contract Hombre is Humano("Hola, soy humano", 2023){

}

// Tipo Modifier 
// Sabes los valores a usar en el constructor a priori
contract Hombre2 is Humano {
    constructor(string memory _saludo, uint256 _year) Humano(_saludo, _year) {}

    modifier modifierConArgs (uint256 a, uint256 b) {
        _;
    }

    function suma(uint256 a, uint256 b, uint256 c, uint256 d) public modifierConArgs(c, d) {
        // a, b, c y d están disponibles en el cuerpo
        // a, b, c y d están disponibles para los modifiers del método
    }
}

contract ContractAImportar {}