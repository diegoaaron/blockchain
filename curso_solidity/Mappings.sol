// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.18;

contract Mappings {
    /**
     * Digamos que deseo guardar en una tabla
     * el saludo de cada persona que me visite.
     *
     * La tabla luce como la siguiente:
     *
    *       Nombre (llave/key)      |    Saludo (valor/value)
     * -----------------------------|---------------------------
     * 1. Juan                      | Hola, soy Juan
     * 2. Maria                     | Hola, soy Maria
     * 3. Jose                      | Hola, soy Jose
     * 4. Carlos                    | Hola, soy Carlos
     * 5. Alicia                    | Hola, soy Alicia
     */

     // Javascript
     // var obj = {} es como una tabla
     // obj["Juan"] = "Hola soy juan";   primera fila
     // obj["Maria"] = "Hola soy maria"; segunda fila
     // obj[llave|key] = valor asociado 

     // si quiero leer la información, le paso el key
     // obj["Carlos"] 

     // Solidity
     // mapping(string => string) _listaDeSaludosPorNombre
     mapping (string nombre => string saludo) public _listaDeSaludosPorNombre;

     function guardarInfoTable(string memory _name, string memory _greeting) public {
         // _name: key
         // _greeting: value
         _listaDeSaludosPorNombre[_name] = _greeting;
     }

     function leerInfoTable(string memory _name) public view returns (string memory) {
         return _listaDeSaludosPorNombre[_name];
     }

     // Tipos de dato a usar
     // En las llaves hay restricciones (no se usa struct, mapping, enums)
     // En los valores no hay restricciones (todo tipo de dato)
     mapping (string => bool) _deStringABoolean;
     mapping (address => uint256) _deAddressAEntero;
     mapping (address => mapping (address => string)) _deAddressAMappingDeAddressAString;

     // No se puede iterar un mapping porque Solidity no sabe el nombre de las 
     // llaves inicializadas
     // address[] _keys;
    // mapping(address _key => uint256 _indiceEnKeysArray) _indices;
    // _keys.push(msg.sender)
}