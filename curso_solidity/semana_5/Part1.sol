// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

// one info per address = mapping of string
// you can only modify your info, no whitelist
// countChanges per address

contract Register11 {
    address public owner;

    mapping(address => string) public infos;
    mapping(address => uint256) public countChanges;

    // mappings y arrays
    // key => value
    // tipo de dato value podria ser array? no
    // como definimos un array de string de tamaño dinámico?
    // String[]

    mapping(address => string[]) public infoArray;

    /** mappping
            key         |           value
            0x01        |          [string1, string2, string3]
            0x02        |          [string1, string2, string3]
            ...
     */

     // whiteList
     // - contrato de airdrops
     // - otorga privilegios de acceso, de uso
     // - Es una manera de restringir 
     // - Pone las address que tendran un privilegio en específico
     // - Sirve para hacer validaciones

     constructor() {
        owner = msg.sender;
        infos[msg.sender] = "Sol";
     }

     event InfoChange(address account, string oldInfo, string newInfo);

     function getInfo() public view returns (string memory) {
        return infos[msg.sender];
     }

     modifier onlyOwner() {
        require(msg.sender == owner, "No eres el owner");
        _;
     }

    mapping(address billetera => bool acceso) _whitelist;

    modifier onlyWhitelist() {
        require(_whitelist[msg.sender], "No esta whitelist");
        _; 
    }

    function setInfo(string memory _info) external onlyWhitelist {
        emit InfoChange(msg.sender, infos[msg.sender], _info);
        infos[msg.sender] = _info;
        countChanges[msg.sender]++;
    }
     
    // setter de _whitelist
    function guardarEnWhitelist(address _whitelistMember) public onlyOwner {
        _whitelist[_whitelistMember] = true;
    }

    function removerDeWhitelist(address _whitelistMember) public onlyOwner {
        _whitelist[_whitelistMember] = false;
    }

    function modificarWhitelist(
        address _member,
        bool _acceso
    ) public onlyOwner {
        _whitelist[_member] = _acceso;
    }

    // Merke Tree
    // Si tenemos mil address > hash (guardamo el hash en SC)
    // creamos una funcion que valida que la address es parte del hash

    // En Solidity a todo tipo de datos dinamico se debe especificcar su nivel de memoria
    // string, arrays, bytes son tipos de dato dinámico
    // los tipos de memoria son: memory, storage y calldata
    // memory:
    // - es temporal, mientra se ejecuta el método
    // - se puede modificar la variable dentro del método
    // - se asignan mas opcodes para que dicha variable se pueda modificar
    
    // calldata:
    // - temporal, mientras se ejecuta el método
    // - no se puede modificar la variable dentro del método
    // - calldata es  más económico
    // - se podría pensar que la variable se comporta como una constante

    // setter de mapping (address billetera => string[]) public infoArray;
    // string[] es de tipo array dinámico: si tiene push
    // string[3] es de tipo array fijo: no tiene push
    function setInfoArray(address _account, string memory _cadena) public {
        infoArray[_account].push(_cadena);
        countChanges[msg.sender]++;
    }

    // getter
    // mapping(address billetera => string[])
    // quiero retornar todo lo que esta en value
    function leerInfoArray(address _account) public view returns (string[] memory) {
        return infoArray[_account];
    }

    function leerTuInfo() public view returns (string[] memory) {
        return infoArray[msg.sender];
    }

}