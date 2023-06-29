// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract Register11 {

    address public owner;
    mapping(address => string) public infos;
    mapping(address => uint256) public countChanges;
    mapping(address => string[]) public infoArray;

    // Structs
    // - Es una manera de agrupar diferentes tipos de variables en una sola
    // - Recuperar (leer) información de un struct es mas económico que 
    // leer infomración de variables por separado
    // - El usuario es capaz de crear datos complejos (definidos por el propio usuario)
    // - Cuando se inicializa un struct, se tiene que definir todos sus integrantes
    struct InfoCambios {
        address account;
        string info;
        uint256 cantidadDeCambios;
    }

    mapping(address => InfoCambios) _infoMappings;

    InfoCambios[] _infoStructs; // este array dinámico puede usar .push

    /** formato de la inicialización del mapping "_infoMappings"
                    (key)           |             (value)
                    address         |           InfoCambios
                    0x001           |           {account, info, qDeCambios}
                    0x002           |           {account, info, qDeCambios}
                    ...
                    0x100           |           {account, info, qDeCambios}
    */

    mapping(bool => InfoCambios) _boolInfoCambios;
    
    /**
        Mapping de dos filas
                key                 |             (value)
                bool                |           InfoCambios
                true                |           {account, info, qDeCambios}
                false               |           {account, info, qDeCambios}
    */

    mapping(string => InfoCambios) public _cadenaToStruct;

    // Hash table: key - value
    // ¿Como se encuentra la posicion del key en la tabla?
    // Hago un hash del key=> posicion en la table (entero)
    // hash(key) = 5
    // hash("un string X") => 6
    //  pos 1      |           |                     |
    //  pos 2      |           |                     |
    //  pos 3      |           |                     |
    //  pos 4      |           |                     |
    //  pos 5      |  key      |  value              |
    //  pos 6      |           | InfoCambios en Zero |

    mapping(address billetera => bool acceso) _whitelist;

    constructor() {
        owner = msg.sender;
        infos[msg.sender] = "Sol";

        // Definiendo un struct
        _infoStructs.push(InfoCambios(msg.sender, "Soy el owner", 1));
        InfoCambios memory _infoCambios = InfoCambios(msg.sender, "Soy el owner", 1);
        _infoCambios.cantidadDeCambios = 2; // esto hace que el struct pase de ser guardado en memory
        // a guardarse en storage

        _infoStructs.push(_infoCambios); // más legible

        _infoStructs.push(InfoCambios({
            info: "SOY EL OWNER",
            account: msg.sender,
            cantidadDeCambios: 1
        }));

    }

    event InfoChange(address account, string oldInfo, string newInfo);

    function getInfo() public view returns (string memory) {
        return infos[msg.sender];
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "No eres el owner");
        _;
    }

    modifier onlyWhitelist() {
        require(_whitelist[msg.sender], "No estas en el whitelist");
        _;
    }

    function setInfo(string memory _info) external onlyWhitelist {
        emit InfoChange(msg.sender, infos[msg.sender], _info);
        infos[msg.sender] = _info;
        countChanges[msg.sender]++;
    }

    function guardarEnWhitelist(address _whitelistMember) public onlyOwner {
        _whitelist[_whitelistMember] = true;
    }

    function removerDeWhitelist(address _whitelistMember) public onlyOwner {
        _whitelist[_whitelistMember] = false;
    }

    function modificarWhitelist(address _member, bool _acceso) public onlyOwner {
        _whitelist[_member] = _acceso;
    }

    function setInfoArray(address _account, string memory _cadena) public {
        infoArray[_account].push(_cadena);
        countChanges[msg.sender]++;
    }

    function leerInfoArray(address _account) public view returns (string[] memory) {
        return infoArray[_account];
    }

    function leerTuInfo() public view returns (string[] memory) {
        return infoArray[msg.sender];
    }
}
