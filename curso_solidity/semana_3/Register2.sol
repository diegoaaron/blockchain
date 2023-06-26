// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Register2 {

    string private info;
    uint public countChanges;
    int256 withNegativeNumbers;
    address owner;

    constructor() {
        info = "Sol";
        owner = msg.sender;
    }

    function getInfo() public view returns(string memory) {
        return info;
    }

    // MODIFIER
    // Sirve para extender la funcionalidad de un metodo
    // Se pueden hacer validaciones (multiples) antes de que se ejecute el metodo 
    // El modifier tiene el control de dictar la ejecucion del cuerpo del metodo
    // El modifier tiende a ser atomico en la validacion (checkings)
    modifier ValidarQueNoEsElOwner {
        // Require
        require(owner == msg.sender, "No eres el owner del contrato");

        // Revert
        // if (owner != msg.sender) revert("No eres el owner del contrato");
        // Revert con error personalizado, es menos costoso
        // if (owner != msg.sender) revert NoEsElOwner();

        //_; => wildcard fusion (comodín fusion), sede la ejecucion al metodo
        _;
    }

    // error NoEsElOwner(); 
    // Este error se dispara en revert NoEsElOwner();

    modifier ValidarSiCadenaEstaVacia(string memory _info) {
        require(bytes(_info).length > 0, "La cadena esta vacia");
        _;
    }

    // Eventos
    // - Es una forma de propagar información del SC hacia afuera
    // - Otros agentes (backend o frontend) pueden suscribirse para escuchar eventos
    // - Todos los eventos se guardan en el blockchain
    // - Se usa como storage barato para guardar informacion
    // - Usando JS pueden hacer queries (como si fuera SQL) a los eventos pasados
    // - Otros contratos inteligentes no pueden escuchar eventos
    event InfoChange(string oldInfo, string newInfo);

    function setInfo(string memory _info) external ValidarQueNoEsElOwner ValidarSiCadenaEstaVacia(_info) {
        emit InfoChange(info, _info);
        info = _info;
        countChanges++;
    }

}