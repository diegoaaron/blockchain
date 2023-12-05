// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// El nombre del archivo no tiene que coincidir con el nombre del contrato
// ES buena práctica hacer que coincida (legibilidad)
contract MiPrimerContrato2 {

    // uint: unsigned integer (entero sin signo)
    // rango de uint 256: [0 - 2^256 -1]
    // Todos los uintX ocupan el mismo espacio en memoria en el SC
    uint256 edad = 34;

    // cuando una variable es pública, Solidity crea el getter de forma automatica
    uint256 public year = 2023;

    // Valores por defecto
    // Solidity define valores por defecto para todas las variables declaradas
    // No existe UNDEFINED o NULL
    bool public esDeNoche = true;
    uint256 public cantidadSinIniciar;

    // getter 
    // metodo de lectura (read-only)
    // visibilidad del metodo con "view"
    // se usa solo para los metodos de lectura
    // public: define que el metodo sera utilizado por usuarios externos
    function obtenerEdad() public view returns (uint256) {
        return edad;
    }

    // setter
    // metodo que escribe, guarda información
    function cambiarEdad(uint256 _nuevaEdad) public {
        edad = _nuevaEdad;
    }
}