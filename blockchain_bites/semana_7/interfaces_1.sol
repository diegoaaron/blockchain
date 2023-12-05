// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

/**
 * Interfaces
 * 1
 * Obligar a que el contrato implemente ciertas funciones
 * Autoaplica un estándar
 * Reglas autoaplicables
 * solo se define las firmas de los métodos 
 * 2
 * Llamadas intercontratos
 */

// definir una interface con un método suma
// function suma(a, b) {return a + b}
// todo método en una interface lleva el visualizador external

interface ISuma {
    function suma (uint256 a, uint256 b) external returns (uint256);
}

contract Operaciones is ISuma {
    function suma(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }
}

