pragma solidity ^0.4.17;

import "./Actor.sol";

contract ActorRegistry {
    mapping (address => bool) private actorsExist;
    mapping (address => Actor) private actors;
    uint256 private countActors;
    
    function ActorRegistry() public payable {
        countActors = 0;
        
        //baseline data
        /*registerActor(0xca35b7d915458ef540ade6068dfe2f44e8fa733c, "sergio", 1);
        registerActor(0x14723a09acff6d2a60dcdf7aa4aff308fddc160c, "eduardo", 1);
        registerActor(0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db, "alberto", 1);
        registerActor(0x583031d1113ad414f02576bd6afabfb302140225, "junior", 1);
        registerActor(0xdd870fa1b7c4700f2bd7f44238821c26f7392148, "bas", 1);*/
    }
    
    function registerActor(address actorAddress, bytes32 actorName, uint256 actorRole) public returns (bool) {
        if (!actorExists(actorAddress)) {
            actors[actorAddress] = new Actor(actorAddress, actorName, actorRole);
            actorsExist[actorAddress] = true;
            countActors++;
            return true;
        }
        else {
            return false;
        }
    }
    
    function getActor(address actorAddress) public returns (Actor) {
        return actors[actorAddress];
    }
    
    function actorExists(address actorAddress) public returns (bool) {
        return actorsExist[actorAddress] == true;
    }
    
    function howManyActors() public returns (uint256) {
        return countActors;
    }
}
