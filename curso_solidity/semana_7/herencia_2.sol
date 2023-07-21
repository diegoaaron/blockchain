// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract Humano {
    function saludoHumano() public pure returns (string memory) {
        return "Hola, soy humano";
    }
}

// 'super':
// con super accedemos a un método del padre directamente
// contrastar cuando hacemos sobreescritura de un método 

contract Hombre is Humano {
    function bienvenidaDeHumano() public pure returns (string memory) {
        return super.saludoHumano();
    }
}

// Herencia multiple

// el super en herencia multiple comienza del contrato derivado hacia el contrato base

contract Marcos is Humano, Hombre {
    
}