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

        // El presupuesto de gas  a gastar es 2300
        // lo cual alcanza para:
        // - lanzar un evento
        // - actualizar una variable
    }

    function withDrawEtherSend(address _account) public {
        uint256 balanceContrato = address(this).balance;
        bool success = payable(_account).send(balanceContrato);
        // success: indica si la transferencia fue exitosa 
        // si no fue exitosa success = false;
        // si fue exitosa success = true;
        // con send, si la transferencia falla no se interrumpe el método
        // Puedes continuar con otra lógica si falla la transferencia
        // El presupuesto de gas a gastar es 2300
        require(success, "La transferencia fallo");
    }

    // Puedes manejar la cantidad de gas a gastar en el contrato donde se ejecuta "receive/fallback"
    function withDrawEtherCall(address _account) public {
        uint256 balanceContrato = address(this).balance;
        (bool success,) = payable(_account).call{
            value: balanceContrato,
            gas: 500000
        }(abi.encodeWithSignature("metodoRecibeEther"));
        require(success, "La transferencia fallo");
    }
}

// 0x406AB5033423Dcb6391Ac9eEEad73294FA82Cfbc

