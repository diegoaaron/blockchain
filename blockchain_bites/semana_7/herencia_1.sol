// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

// C3 Linearization: algoritmo de herencia de métodos

// contrato más base (se encuentra arriba)

contract A {
    // Lo que se hereda (transmitodo por herencia)
    // - métodos
    // - variables de estado
    // - eventos
    // ¿qué no se hereda?
    // todo lo que se haya definido como 'private'
    // Los métodos external tambien se heredan

    function metodoExternal() external {} // Si se hereda

    function metodoPrivado() private {} // No se heredaría

}

// (En relación a A) B es el contrato derivado

contract B is A {

}

// La herencia se da desde el contrato más básico hasta el más derivado

contract C is A, B {

}

contract E {

}

contract F {

}

contract G is E, F {
    
}

