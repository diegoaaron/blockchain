// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract MiPrimerContranto {
    string saludo = "Hola desde la UNI";


    // Getter
    // metodo de lectura -a read-only
    function leerSaludo() public view returns(string memory){
        return saludo;
    }

    // Setter
    function guardarSaludo(string memory nuevoSaludo) public {
        saludo = nuevoSaludo;
    }


}