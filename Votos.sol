// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract VotingSystem {

    //Una propuesta consta de un nombre (nombre de la propuesta) y un contador de votos (que ha recibido la propuesta).

    struct Propuesta {
        string nombre;
        uint votos;
    }
    
    //lista de propuesta
    Propuesta[] public propuestas;

    //direccion Ethereum del administrador
    address public admin;
    
    //almacenar direcciones de votantes habilitados y de quienes han votado
    mapping(address => bool) public whitelist;
    mapping(address => bool) public hasVoted;

    uint public endVoteTime;

    constructor() {
        admin = msg.sender;
        endVoteTime = block.timestamp + 3 days;
    }

    function agregarPropuesta (string memory nombrePropuesta) public {
        require(msg.sender == admin, "No tienes permiso para hacer esto");
        propuestas.push(Propuesta(nombrePropuesta, 0));
    }
}


