// SPDX-License-Identifier: MIT
pragma solidity >=0.4.2 <0.8.0;

contract Election {    
    // Read/write candidate    
    string public candidate;    
    // Constructor    
    constructor () public {        
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");  
    }

    event votedEvent (
        uint indexed _candidateId
    );

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;
    uint public candidatesCount;

    function addCandidate (string memory _name) private {        
        candidatesCount++;        
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);    
    }

    function vote(uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);
        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        // record that voter has voted
        voters[msg.sender] = true;
        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        emit votedEvent(_candidateId);
    }
}