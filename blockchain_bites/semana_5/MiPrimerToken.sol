// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MiPrimerToken is ERC20, ERC20Burnable, Pausable, Ownable {
    constructor() ERC20("Mi Primer Token", "MPTK") {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}

// Direccion de despliegue: 0xAa827D2793D0ff58F47Bb11f59b36bD9C72e8A97

// Interfaces: forma de obliguar a un contrato a respetar ciertos metodos o eventos previamente definidos
// las interfaces solo tienen la firma de los metodos. la implementación siempre lo realizara el contrato 

/**
1. Consulta el método name. Copia aquí el valor de retorno aquí: Mi Primer Token

2. Consulta el método symbol. Copia aquí el valor de retorno aquí: MPTK

3. Consulta el método decimals. Este valor representa la unidad mínima divisible del token que acabas de crear. Copia aquí el valor de retorno aquí: 18

4. Consulta el método totalSupply. Este cambia con el tiempo y representa la cantidad de tokens acuñados hasta el momento. Los métodos mint y burn alteran este valor. Copia aquí el valor de retorno aquí: 100 000 000 000 000 000 000 000

5. Consulta los balances de Address1 y Address2 usando balanceOf(Address1) y balanceOf(Address2). El argumento de este método es cualquier address. Este método devuelve el total de tokens acuñados a favor de una address. Copia los valores aquí:

addr1 0x990ceDaE234b4254c26daedf763567840a2d5fd2 100000000000000000000000

addr2 0x8c8FA8f84710cBc64099d2463b573Cd87ccA0373 0

6 Realiza una transferencia usando el método tansfer(to, cantidad). Este método transfiere una cantidad de tokens a otra address debitando al address (msg.sender) que llama a este método. Utiliza los siguientes valores en Remix: to: Address2, amount: 10000000000000000000000. Se está transfiriendo 10,000 tokens. Recuerda que tu token tiene 18 decimales y por ello se agregan 18 ceros extras. Realiza otra vez el punto 5 y consulta los balances. Copia los valores aquí:

addr1 0x990ceDaE234b4254c26daedf763567840a2d5fd2 90000000000000000000000

addr2 0x8c8FA8f84710cBc64099d2463b573Cd87ccA0373 10000000000000000000000

7 Acuña tokens a la Address1 usando el método mint. Internamente mint agrega un saldo a favor de un address un en mapping de balances. En el método mint en Remix utiliza los siguientes valores: to: Address1, amount: 5000000000000000000000. Vuelve a realizar el punto 5 una vez que la transacción finaliza. Copia los valores aquí:

addr1 0x990ceDaE234b4254c26daedf763567840a2d5fd2 95000000000000000000000

addr2 0x8c8FA8f84710cBc64099d2463b573Cd87ccA0373 10000000000000000000000

8 Vamos a quemar todos los tokens del Address1. Para ello puedes averiguar el total de balance de tokens que tiene esta address. Se queman los tokenes usando el método burn. Utiliza este valor en Remix para ejecutar mint: amount: 45000000000000000000000. Realizar el paso 5 otra vez. Así también realiza el paso 4. Nota como los balances y el total supply cambian. Copia los valores aquí:

addr1 0x990ceDaE234b4254c26daedf763567840a2d5fd2 45000000000000000000000

addr2 0x8c8FA8f84710cBc64099d2463b573Cd87ccA0373 10000000000000000000000

9 Según el estandar ERC20, un Address A puede dar permiso a un Address B para que Address B maneje los tokens de Address A en su representación. Address B se convierte en un gestor de los activos del Address A y Address B puede transferir o quemar los tokens del Address A. Lograr esto en el estándar se hace a través de approve. Vamos a lograr que Address2 le de permiso a Address1 de manejar sus tokens. Primero vamos a ir a Metamask y vamos a seleccionar el Address2. Para ello hacer clic en la extensión de Metamask. Cuando se abra hacer clic en la circunferencia. Seleccionar el Address2. Ello se reflejará automáticamente en Remix:

10 Para indagar el permiso que un Address A le dio a otro Address B, hacemos uso del método allowance. En la terminología del ERC20, owner hace referencia al dueño de los tokens; mientras que spender hace denota al address que recibió el permiso de manejar los tokens. En el método allowance en Remix usamos los siguientes valores: owner: Address2, spender: Address1. Esto devolverá el permiso que tiene Address1 para manejar los tokens de Address2. Copia ese valor aquí:

addr1 0x990ceDaE234b4254c26daedf763567840a2d5fd2 tiene permiso sobre 10000 000000000000000000 tokens

addr2 0x8c8FA8f84710cBc64099d2463b573Cd87ccA0373 es propietario de los 10000 000000000000000000 tokens

11 Ahora abrimos Metamask para volver a cambiar de cuenta. Regresamos al Address1.
En mi caso, 0xCA420CC41ccF5499c05AB3C0B771CE780198555e, representa el Address1.
Dado que el Address1 ahora tiene el poder de manejar los activos del Address2, vamos a lograr que Address1 se transfiera los tokens de Address2 a sí mismo. Usaremos el método "transferFrom" que nos permite definir un address de origen, un address de destino y la cantidad a transferir. Usar los siguientes valores en Remix: from: Address2, to: Address1 y amount: 10000000000000000000000. Nota: from hace referencia al dueño de los tokens, a quien se le quitará amount tokens; to es cualquier address que el gestor de los activos escoja. Firmar la transacción. Repetir el punto 5 y anotar los valores aquí:

addr1 0x990ceDaE234b4254c26daedf763567840a2d5fd2 55000000000000000000000

addr2 0x8c8FA8f84710cBc64099d2463b573Cd87ccA0373 0

12 Repite el número 10. Nota que el permiso que Address2 le había dado a Address1 ha cambiado. Copia el valor aquí:

addr2 0x8c8FA8f84710cBc64099d2463b573Cd87ccA0373 ha sedido 0 tokens a addr1

13 Indaga qué hacen los siguientes métodos: increaseAllowance, decreaseAllowance.

increaseAllowance -- permite aumentar el permiso sobre los fondos de un address A hacia un address B

addr1 0x990ceDaE234b4254c26daedf763567840a2d5fd2 aumento permiso a addr 2 de 25k a 28k 

decreaseAllowance -- reducen el permiso de los fondos 

addr1 0x990ceDaE234b4254c26daedf763567840a2d5fd2 aumento permiso a addr 2 de 25k a 15k 


 */