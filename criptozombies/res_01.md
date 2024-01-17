### Contratos

Un contrato es la principal construcción de una aplicacion en Eth
La sentencia pragma indica la versión del compiliador que se utilizara 

```solidity
pragma solidity >=0.5.0 <0.6.0;

contract HelloWorld{

}
```

Las "variables de estado" se almacenan de forma permanente en el contrato, es como
si estuvieron guardadas en una base de datos. 

```solidity
contract Example {
    uint myUnsignedIntenger = 100; // variable guardada permanentemente en la blockchain
}
```

Los datos "uint" son enteros sin signo, por lo cual siempre seran positivos.
Tambien existen datos de tipo "int" que si soportan signos.
En Eth por defecto "uint = uint256" pero existen tambien con menos bits como uint16, uint32, etc.

```solidity
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    //start here
    uint dnaDigits = 16;
}
```

En Solidity se pueden realizar las operaciones aritmeticas comunes:
suma (+)
resta (-) 
multiplicacion (x)
division (/)
residuo (%)
potencia (**)

```solidity
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    //start here
    uint dnaModulus = 10 ** dnaDigits;

}
```

A diferencia de otros lenguajes Solidity soporta otras estructuras de datos como
"structs" que permite manejar datos más complejos 

```solidity
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // start here
    struct Zombie {
        string name;
        uint dna;
    }

}
```

Para armar colecciones existen 2 tipos de array. arrays fijos y dinámicos. 
Tambien hay soporte para array de structs. Ya que la blockchain almacena permanentemente
los arrays dinamicos son una forma de almacenar información como si fuera una base de datos.

Las variables en solidity tambien pueden ser declaradas como públicas o privadas.
Al declarar una array como público, Solidity creara un método getter para este

```solidity
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    // start here
    Zombie[] public zombies;
}

```

Al declarar una funcion en solidity indicamos su visibilidad "public" asi como
para los parametros de que sean de tipo arrays, structs, mappings, y strings debemos
indicar la palabra "memory" despues del tipo de dato. 

Al momento de pasar argumentos a una funcion en solidity, tenemos 2 formas: 
* Por valor, lo que significa que el compilador de Solidity crea una nueva copia 
del valor del parámetro y lo pasa a su función. Esto permite que su función modifique 
el valor sin preocuparse de que cambie el valor del parámetro inicial.
* Por referencia, lo que significa que su función se llama con una ... 
referencia a la variable original. Por lo tanto, si su función cambia el valor de 
la variable que recibe, el valor de la variable original cambia.

Es una buena práctica nombrar a los parametros de una funcion con un "_" al inicio para 
defirenciarlo de de las variables globales. 

```solidity
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    // start here
    function createZombie(string memory _name, uint _dna) public {

    }
}

```

Agregando valores a un array de structs, utilizamos el metodo push(), el cual
agrega el elemento al final

```solidity
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function createZombie (string memory _name, uint _dna) public {
        // start here
        zombies.push(Zombie(_name, _dna));        
        // segunda forma 
        // Zombie nuevoZombie = Zombie(_name, _dna);
        // zombies.push(nuevoZombie);
    }

}
```

ya que por defecto solidity mantiene publica las funciones por defecto 
podemos utilizar la palabra "private" para que solo otras funciones dentro
del contrato puedan hacer uso de la funcion privada.

Por buena practica cuando una funcion es declarada como privada debe de 
nombrarse iniciando con un "_"

```solidity
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

}
```

Si deseamos retornar un valor en de una funcion utilizamos la palabra "return"
en Solidity se debe de definir al inicio el tipo de dato del return 

Cuando una funcion no cambia ningun estado en solidity se puede cambiar su 
visibilidad a "view" lo que indica que solo sirve para ver una variable

Solidity también contiene funciones puras "pure" , lo que significa que ni siquiera 
accedes a ningún dato de la aplicación.

```solidity
string greeting = "What's up dog";

function sayHello() public view returns (string memory) {  
    return greeting;
}

function _multiply(uint a, uint b) private pure returns (uint) {
  return a * b;
}

```

```solidity
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

    // start here
    function _generateRandomDna(string memory _str) private view returns (uint) {
        
    }
}
```

Ethereum tiene la funcion integrada keccak256 que es una version de SHA3. Una función 
hash básicamente asigna una entrada a un número hexadecimal aleatorio de 256 bits. 
Un ligero cambio en la entrada provocará un gran cambio en el hash.
Tiene multiples como por ejemplo generar un numero randon 

También es importante que keccak256 espere un único parámetro de tipo bytes. 
Esto significa que tenemos que "empaquetar" cualquier parámetro antes de llamar a keccak256:

typecasting: es una forma de convertir un tipo de dato a otro para poder operar
dos o más variables

```solidity
uint8 a = 5;
uint b = 6;
// throws an error because a * b returns a uint, not uint8:
uint8 c = a * b;
// we have to typecast b as a uint8 to make it work:
uint8 c = a * uint8(b);
```

```solidity
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        // start here
        uint rand = uint(keccak256(abi.encodePacked(_str)));

        return rand % dnaModulus;

    }
}
```


```solidity
pragma solidity  >=0.5.0 <0.6.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    // start here
    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
```

Los eventos son una forma en la que un SC comunica algo sucedió en la blockchain
con el front-end de su aplicación, que puede estar "escuchando" ciertos eventos 
y tomar medidas cuando suceden.

```solidity
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    // declare our event here
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // and fire it here
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
```
