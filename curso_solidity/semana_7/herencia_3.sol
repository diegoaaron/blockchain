// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

/**
 * Sobreescritura de métodos heredados (virtual y override)
 * virtual: marca un método para sobreescribir
 * override: marca un método que sobreescribe a un método virtual
 */

contract Humano {
    function saludo() public pure virtual returns (string memory) {
        return "Hola, saludo desde humano";
    }
}

contract Hombre is Humano {
    function saludo() public pure virtual override returns (string memory) {
        return "Hola, saludo desde Hombre";
    }

    function metodoPapa() public pure returns (string memory) {
        return super.saludo();
    }
}

contract Marcos is Humano, Hombre {
    function saludo() public pure override(Humano, Hombre) returns (string memory) {
        return "Hola, saludo desde Marco";
    }
}

