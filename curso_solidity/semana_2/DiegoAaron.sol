// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

// El nombre del archivo se sugiere que lleve el mismo nombre que el contrato x legibilidad 
contract DiegoAaron {
    // Solidity designa valores x DEFAULT de manera automatica a todoas las variables
    // El valor x DEFAULT depende del tipo de dato que estás usando:
    // uint256 > x defecto es 0
    // string > x defecto es ""
    // bool > x defecto es false
    // En Solidity no existe UNDEFINED o NULL (como si existe en JS)

    // 'private':
    // - significa que la variable solo puede ser usada dentro del SC
    // - es una variable que no se podra heredar y no puede ser usada por ningun otro SC

    // cuando no se define la visibilidad, se considera 'internal'
    // 'internal':
    // - la variable puede ser usada dentro de este SC 
    // - la variable puede ser heredada y usada en otro SC

    // 'public'
    // - la variable puede ser usada dentro de este SC 
    // - puede ser heredado y usado por otros SC
    // - expone a la variable/metodo para ser usado por usuarios externos
    // - si se trata de una variable, crea automaticamente un getter para esa variable
    
    string private fullName;

    // el tipo de dato 'address' se utiliza para guadar direccion de billeteras 
    address public owner;

    // 'CONSTRUCTOR'
    // Inicializar variables
    // Sirve para inyecar información al SC (desde afuera)
    // Se ejecuta una sola vez (cuando el SC se publica)
    // Tambien se ejecuta cuando se crea una instancia de otro SC desde un SC
    // Dentro del constructor se puede identificar a la billetera que esta publicando el contrato
    // Para identificar a quien publica el contrato utilizamos la variable global 'msg.sender'
    // 'msg.sender' es una variable global porque SOLIDITY la define

    constructor(string memory _lastName) {
        fullName = string.concat("Diego", " ", _lastName);

        // Guardando la direccion de la billetera que publica el SC en la variable 'owner'
        owner = msg.sender;
    }

    // Definiendo un getter  para leer la variable fullname:
    // 'memory' > acompaña los tipos de datos dinamico en Solidity como:
    // arrays, string, bytes.
    // 'memory' se especifica unicamente en los parametros RETURN e implementacion del metodo
    // 'memory' instruye para que se guarde la informacion de manera temporal

    function getName() public view returns(string memory) {
        return fullName;
    }
}