// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Clase4{
    string private info;
    uint public countChanges;
    int256 withNegativeNumbers;
    address owner;

    string[] private infos;

    // block.timestamp: cantidad de segundos pasados desde 1970
    uint256 tiempoDePublicacion = block.timestamp;

    // Arrays fijos
    // Sintaxis: T[k]   T: tipo de dato | k: cantidad de elementos

    // Array de 10 elementos booleanos, Solidity inicializa en false todas 
    // las posiciones del array.
    bool[10] _listaBools;

    // Array de 50 enteros (inicializados en 0 por defecto)
    uint256[50] _listaEnteros;

    // Array de 100 direcciones (inicializadas en 0x0 por defecto)
    address[100] _listaAddresses;

    // address[2] _arrayAddresses;
    //_arrayAddresses[1] = myAddress;
    // EVM
    //[0x00, myAddress] > una escritura

    // address[] _arrayAddresses;
    // EVM
    // [0X00] > primera escritura por defecto por parte de Solidity
    // _arrayAddresses.push(myAddress);
    // [myAddress] > segunda escritura 

    function guadarBools() public {
        // Si el array es fijo solo puedo guadar información
        _listaBools[0] = true;
        _listaBools[1] = true;
        _listaBools[2] = true;

        _listaBools[0] = false;

        // remover un elemento solo hara que Solidity ponga un valor por defecto
        delete _listaBools[1];
        // listaBools[1] ahora sera FALSE
    }

    // Arrays dinamicos
    // Sintaxis T[]  T: tipo de dato
    
    // Array dinamico del tipo de dato address 
    address[] _arrayDinAddresses;

    // Array dinamico del tipo de dato entero
    uint256[] _arrayDinEnteros;

    function guardarInfoArrayDinamico() public {

        // Se puede usar .push y el .pop
        // .push: añade un elemento al final de la lista
        // .pop: retira un elemento del final de la lista
        // .slice y .splice no existe en Solidity

        // []
        _arrayDinAddresses.push(msg.sender);
        // [msg.sender]
        _arrayDinAddresses.push(msg.sender);
        // [msg.sender1, msg.sender2]
        _arrayDinAddresses.push(msg.sender);
        // [msg.sender1, msg.sender2, msg.sender3]

        _arrayDinAddresses.pop();
        // [msg.sender1, msg.sender2]
        _arrayDinAddresses.pop();
        // [msg.sender]
        _arrayDinAddresses.pop();
        // []
    }

    function getInfo() public view returns (string memory) {
        return info;
    }

    modifier ValidarQueNoEsElOwner {
        require(owner == msg.sender, "No eres el owner del SC");
        _;
    }

    modifier ValidarSiCadenaEstaVacia(string memory _info) {
        require(bytes(_info).length > 0, "La cadena esta vacia");
        _;
    }

    event InfoChange(string oldInfo, string newInfo);

    function addInfo(string memory _info) external {
        // Guardar nuevo elemento (al final)
        infos.push(_info);
    }

    function setInfo(uint256 _index, string memory _info) external ValidarQueNoEsElOwner 
    ValidarSiCadenaEstaVacia(_info) {
        emit  InfoChange(info, _info);
        info = _info;
        ++countChanges;

        // Actualizando un index existente
        require(_index < infos.length, "Out of bounds");
        infos[_index] = _info;
    }

    // Tipos de memmoria
    // storage: información que se guarda de forma permanente

    // memory: existe mientras se ejecuta el método
    // caldata

    // recuperanda parte de un array en otro  (Recuperar informacion desde ixA hasta ixB)
    // ix   :       0           1       2           3
    // infos: ["string1", "string2", "string3", "string4", ...]

    function recuperarInfo(uint256 ixStart, uint256 ixEnd) 
    public view returns (string[] memory _infosAux) {
        require(ixEnd > ixStart);
        require(ixEnd < infos.length);

        uint256 _lonArrRecuperar = ixEnd - ixStart + 1;
        // Para crear un array es un metodo(temporal), especificamos "lon"
        // memory _infosAux: _infosAux se guardara en memoria temporal
        // new string[](_lonArrRecuperar): array de strings de longitud _lonArrRecuperar

        // Dentro de un metodo no se puede crear arrays de tipo storages
        // tampoco se pueden crear arrays dinamicos

        _infosAux = new string[](_lonArrRecuperar);
        // string[10] memory _infosAux2;  > esto tambien es posible pero hardcodea el tamaño del array

        for (uint256 i = ixStart; i <= ixEnd; i++){

            _infosAux[i - ixStart] = infos[i];
        }

        return _infosAux;

    }
 
    constructor() {
        info = "Sol";
        owner = msg.sender;
        infos.push("Sol");
    }
}