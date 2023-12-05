// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

/**
 * Ejercicio Semana 4
 *
 * Vamos a crear un contrato que se comporte como un cajero automático o ATM.
 * Mediente este contrato, el usuario puede depositar y retirar fondos.
 * Así también el usuario puede transferir fondos a otro usuario.
 *
 * Tendrá las siguientes características:
 *  - Permite depositar fondos en el contrato mediante el método 'depositar'.
 *  - Permite retirar fondos del contrato mediante el método 'retirar'.
 *  - Permite transferir fondos a otro usuario mediante el método 'transferir'.
 *  - Permite consultar el saldo del usuario. Hacer la estructura de datos 'public'
 *  - Permite consultar el saldo del ATM. Hacer la variable 'public'
 *  - modifier de pausa: verifica si el boolean 'pausado' es true o false
 *  - modifier de admin: verifica que el msg.sender sea el admin
 *  - Permite cambiar el boolean 'pausado' mediante el método 'cambiarPausado' y verifica que solo es llamado por el admin
 *
 * Notas:
 *  - para guardar y actualizar los balances de un usuario, se utilizará un diccionario
 *  - el modifier protector usa un booleano para saber si está activo o no
 *  - este booleano solo puede ser modificado por una cuenta admin definida previamente
 *
 * Testing: Ejecutar el siguiente comando:
 * -  npx hardhat test test/EjercicioSemana4.js
 */

contract EjercicioSemana4 {
    // definir address 'admin' con valor de 0x08Fb288FcC281969A0BBE6773857F99360f2Ca06
    address public admin = 0x08Fb288FcC281969A0BBE6773857F99360f2Ca06;
    // definir boolean public 'pausado' con valor de false
    bool public pausado;

    // 7 - definición de modifier 'soloAdmin'
    // verificar que el msg.sender sea el admin
    // poner el comodín fusión al final del método
    modifier soloAdmin() {
        require(admin == msg.sender, "Solo el admin puede ejecutar esta funcion");
        _;
    }

    // 8 - definir modifier 'cuandoPausado'
    // modifier cuandoNoPausado
    // verificar que el boolean 'pausado' sea false
    modifier cuandoNoPausado() {
        require(pausado == false, "El contrato esta pausado");
        _;
    }

    // 1 - definición de variables locales
    // definir variable que almacena el balance total del cajero automático (e.g. balanceTotal)
    // definir mapping que almacena el balance de cada usuario (e.g. balances)
    uint256 public balanceTotal;
    mapping(address add_usuario => uint user_balance) public balances;

    // 2 - definición de eventos importantes
    // definir eventos 'Deposit', 'Transfer' y 'Withdraw'
    // - Deposit tiene dos parámetros: address y uint256 que son (from, value)
    event Deposit (address from, uint256 value);

    // - Transfer tiene tres parámetros: address, address y uint256 que son (from, to, value)
    event Transfer (address from, address to, uint256 value);

    // - Withdraw tiene dos parámetros: address y uint256 que son (to, value)
    event Withdraw (address to, uint256 value);

    // 5 - definición de error personalizado 'SaldoInsuficiente'
    modifier SaldoInsuficiente2(uint256 _cantidad) {
        require(_cantidad < balances[msg.sender], "Saldo insuficiente");
        _;
    }

    error SaldoInsuficiente();


    // 3 - definición de método 'depositar'
    // definir función 'depositar' que recibe un parámetro uint256 '_cantidad' y es 'public'
    // - aumentar el balance del usuario en '_cantidad'
    // - aumentar el balance total del cajero automático en '_cantidad'
    // - emitir evento 'Deposit'
    function depositar(uint256 _cantidad) public {
        balances[msg.sender] += _cantidad;
        balanceTotal += _cantidad;
        emit Deposit(msg.sender, _cantidad);
    }

    // 4 - definición de método 'retirar'
    // definir función 'retirar' que recibe un parámetro uint256 '_cantidad' y es 'public'
    // - verificar que el balance del usuario sea mayor o igual a '_cantidad'
    // - disminuir el balance del usuario en '_cantidad'
    // - disminuir el balance total del cajero automático en '_cantidad'
    // - emitir evento 'Withdraw'
    function retirar(uint256 _cantidad) public cuandoNoPausado {
        if (_cantidad >= balances[msg.sender]) {
            revert ("Saldo insuficiente");
        } else {
            balances[msg.sender] -= _cantidad;
            balanceTotal -= _cantidad;
            emit Withdraw(msg.sender, _cantidad);
        }
    }

    // 6 - definición de método 'transferir'
    // definir función 'transferir' que recibe dos parámetros: address '_destinatario' y uint256 '_cantidad' y es 'public'
    // - verificar que el balance del usuario sea mayor o igual a '_cantidad'. Si no lo es, disparar error 'SaldoInsuficiente'
    // - disminuir el balance del usuario en '_cantidad'
    // - aumentar el balance del destinatario en '_cantidad'
    // - emitir evento 'Transfer'
    function transferir(address _destinatario, uint256 _cantidad) public {
        if (_cantidad >= balances[msg.sender]) {
            revert SaldoInsuficiente();
        } else {
            balances[msg.sender] -= _cantidad;
            balances[_destinatario] += _cantidad;
            emit Transfer(msg.sender, _destinatario, _cantidad);
        }
    }

    // 8 - definición de método 'cambiarPausado'
    // definir función 'cambiarPausado' que es 'public' y solo puede ser llamada por el admin (usar modifier)
    // - cambiar el boolean 'pausado' a su valor contrario
    // - emitir
    function cambiarPausado() public soloAdmin {
        pausado = !pausado;
    }
}
