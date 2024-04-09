// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract VotingSystem {

    //Una propuesta consta de un nombre (nombre de la propuesta) y un contador de votos (que ha recibido la propuesta).

    struct Proposal {
        string name;
        uint voteCount;
    }
    
    //lista de propuesta
    Proposal[] public proposals;

    //direccion Ethereum del administrador
    address public admin;
    
    //almacenar direcciones de votantes habilitados y de quienes han votado
    mapping(address => bool) public whitelist;
    mapping(address => bool) public hasVoted;

    uint public endVoteTime;

    modifier isAdmin {
        require(msg.sender == admin, "No tienes permiso para hacer esto"); //validar permisos
        _;
    }

    constructor() {
        admin = msg.sender;
        endVoteTime = block.timestamp + 3 days;
    }

    function addProposal (string memory proposalName) public isAdmin {
        proposals.push(Proposal(proposalName, 0));
    }

    function whitelistUpdate (address _address) public isAdmin {
        whitelist[_address] = true;
    }

    function vote(uint proposalId) public {
        require(whitelist[msg.sender], "no estas en la whiteliste" );
        require(!hasVoted[msg.sender], "ya has votado");
        require(block.timestamp <= endVoteTime, "se ha agotado el tiempo para las votaciones");

        hasVoted[msg.sender] = true;
        proposals[proposalId].voteCount += 1;
    }
    
}


