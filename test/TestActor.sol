pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Actor.sol";

contract TestActor {
    address accountAddress = 0x627306090abab3a6e1400e9345bc60c78a8bef57;
    bytes32 accountName = "sergio";
    uint256 accountRole = 1;
    Actor actor = new Actor(accountAddress, accountName, accountRole);
    
    // Testing the isThisActor() function
    function testIsThisActor() public {
        Assert.isTrue(actor.isThisActor(accountAddress), "The correct Address should return true");
        Assert.isFalse(actor.isThisActor(0x627306090abab3a6e1400e9345bc60c78a8bef00), "The incorrect Address should return false");
    }
    
    // Testing the getId() function
    function testGetId() public {
        Assert.equal(accountAddress, actor.getId(), "The correct Id should return true");
    }
    
    // Testing the getName() function
    function testGetName() public {
        Assert.equal(accountName, actor.getName(), "The correct Name should return true");
    }
    
    // Testing the getRole() function
    function testGetRole() public {
        Assert.equal(accountRole, actor.getRole(), "The correct Role should return true");
    }
}