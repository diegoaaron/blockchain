// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Register {
    // Visibilizador
    // No se hereda
    // Solo se usa dentro del contrato

    string private info;

    // entero / integer
    // uint - u unsigend, int integer
    // uint === uint256, rango [0, 2^256 -1]
    // uint128 = rango [0, 2^128 -1]
    // uint64 = rango [0, 2^64 -1]
    // uint32 = rango [0, 2^32 -1]
    // uint16 = rango [0, 2^16 -1]
    // uint8 = rango [0, 2^8 -1]
    // el consumo de memoria de cualquier uint es igual

    uint public countChanges; // = 0 (redundante ya que Solidity inicializa las variables)

    // int - sí incluye números negativos
    int256 withNegativeNumbers;

    // Se estila llamar al que despliega el contrato owner/admin
    address owner;

    // Constructor
    // Uno de sus propositos es inyectar info del mundo de afuera al SC
    // Inicializa variables
    // Se ejecuta una sola vez durante la vida del SC 
    constructor() {
        info = "Sol";
        // podemos capturar la billetera de quien publica el SC
        // msg.sender es la variable global de Solidity que puede usar el SC
        owner = msg.sender;
    }

    // getter
    function getInfo() public view returns(string memory) {
        return info;
    }

    // setter 
    // external 
    // - puede ser usado desde afuera 
    // - no se puede usar dentro del smart contract 
    function setInfo(string memory _info) external {
        // owner
        // forma ingenua de proteger el metodo:
        // if (owner != msg.sender) return;

        countChanges += 10;

        // Si un 'require' falla, todos los cambios se revierten 
        // Hay atomicidad en la TX
        // o todo se guarda o nada se guarda
        // o todo se ejecuta o nada se ejecuta
        // Los 'require' permiten hacer validaciones
        // Se cobran el gas hasta el punto donde se ejecuto

        // require(owner == msg.sender, "No eres el owner del SC");
        require(owner == msg.sender, "No eres el owner del SC");
        require(bytes(_info).length > 0, "La cadena esta vacia");

        info = _info;

        // countChanges = countChanges + 1;
        // countChanges +=  1;
        // ++countChanges; ==> esto genera menos costos
        countChanges++;
    }
}