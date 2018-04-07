pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/ActorRegistry.sol";

contract TestActorRegistry {
    ActorRegistry actorRegistry = new ActorRegistry();
    
    // Testing registerActor() function
    function testRegisterActor() public {
        Assert.equal(actorRegistry.howManyActors(), 0, "The correct number of Actors is zero befor any insertion");
        
        actorRegistry.registerActor(0x627306090abab3a6e1400e9345bc60c78a8bef57, "sergio", 1);
        actorRegistry.registerActor(0xf17f52151ebef6c7334fad080c5704d77216b732, "eduardo", 1);
        actorRegistry.registerActor(0xc5fdf4076b8f3a5357c5e395ab970b5b54098fef, "alberto", 1);
        actorRegistry.registerActor(0x821aea9a577a9b44299b9c15c88cf3087f3b5544, "junior", 1);
        actorRegistry.registerActor(0x0d1d4e623d10f9fba5db95830f7d3839406c6af2, "bas", 1);
        
        Assert.equal(actorRegistry.howManyActors(), 5, "The correct number of Actors is zero befor any insertion");
    }
    
    // Testing actorExists() function
    function testActorExists() public {
        Assert.isTrue(actorRegistry.actorExists(0x627306090abab3a6e1400e9345bc60c78a8bef57), "An existing actor should return true");
        Assert.isFalse(actorRegistry.actorExists(0x627306090abab3a6e1400e9345bc60c78a8bef00), "A non existing actor should return false");
    }
}