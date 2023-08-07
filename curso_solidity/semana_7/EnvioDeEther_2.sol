// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

// tries

// Dos maneras de enviar Ether (forzosa)
// 1 - usando selfdestruct
//     destruye un SC y envia el saldo de ether a un address
// 2 - validando
//     especificas un address para recibir el premio (pago)

contract EnviaEther {
    constructor() payable {}

    function withDrawEtherTransfer(address _account) public {
        // retirar el total de Ether del SC
        uint256 balanceContrato = address(this).balance;
        // transferir balanceContrato a _account
        // 'transfer' que es una propiedad del tipo de dato address 
        // 'address' tiene la propiedad o método llamado transfer

        // incorrecto: el address _account va a transferir la cantidad de balanceContrato

        // correcto: el ether del contrato va el valor de balanceContrato a _account
        payable(_account).transfer(balanceContrato);

        // con transfer, si la transferencia falla, el error se lanza y se interrumple la ejecución del método
        // no hay forma de controlar el error 

        
    }
}