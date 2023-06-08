// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract TareaSemana3 {

    string private greeting;
    address owner;


    constructor() {
        greeting = "Hello Ethereum";
        owner = msg.sender;
    }

    modifier ValidaOwner {
        require(owner == msg.sender, "No eres el owner de SC");
        _;
    }

    modifier ValidaDireccion(address _owner) {
        require(_owner != address(0), "ERC20: transfer from the zero address");
        _;
    }

    function setGreeting(string memory _greeting) external ValidaOwner ValidaDireccion(msg.sender) {
        greeting = _greeting;
    }

    function changeOwner(address _owner) external ValidaOwner{
        owner = _owner;
    }



}

