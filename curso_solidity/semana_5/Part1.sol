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

     
}