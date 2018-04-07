pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/File.sol";

contract TestFile {

    address actorRegistryAddress = 0x345ca3e014aaf5dca488057592ee47305d9b3e10;//got it from ActorRegsitry.json
    
    address actor1 = 0x627306090abab3a6e1400e9345bc60c78a8bef57;
    address actor2 = 0xf17f52151ebef6c7334fad080c5704d77216b732;
    address actor3 = 0xc5fdf4076b8f3a5357c5e395ab970b5b54098fef;
    
    string fileName = "file1";
    string fileHash = "uedbgiwgirfiefi";

    File file;
    
    // Testing the constructor function
    function testConstructor() public {
        /*ActorRegistry.deployed().then(
            instance => actorRegistryAddress = instance.address
        );
        Assert.isNotZero(actorRegistryAddress, "If actorAddress instanciation went right, it shouldn't be zero");*/
        
        file = new File(actorRegistryAddress, fileName, fileHash);
        //Assert.notEqual(file.getFileName(), "", "If the file is created correctly, the fileName should not be zero.");
    }
    
    /*// Testing isActorOwner() function
    function testIsActorOwner() public {
        bool isOwner = file.isActorOwner(msg.sender);
        Assert.isTrue(isOwner, "This account is the owner of the contract.");
    }*/
    
    // Testing addActorInvolved() function
    function testAddActorInvolved() public {
        Assert.equal(file.howManyActorsInvolved(), 1, "1 actor involved");
        Assert.isFalse(file.isActorInvolved(actor1), "Actor2 was not involved");
        file.addActorInvolved(actor1);
        Assert.equal(file.howManyActorsInvolved(), 2, "2 actor involved");
        Assert.isTrue(file.isActorInvolved(actor1), "Actor1 is now involved");
        Assert.isFalse(file.isActorInvolved(actor2), "Actor2 is not yet involved");
        file.addActorInvolved(actor2);
        Assert.isTrue(file.isActorInvolved(actor2), "Actor2 is now involved");
        Assert.equal(file.howManyActorsInvolved(), 3, "3 actor involved");
    }
    
    // Testing removeActorInvolved() function
    function testRemoveActorInvolved() public {
        Assert.isTrue(file.isActorInvolved(actor2), "Actor2 is still involved");
        file.removeActorInvolved(actor2);
        Assert.isFalse(file.isActorInvolved(actor2), "Actor2 is not involved anymore");
    }
    
    // Testing requestInvolvement() function
    function testRequestInvolvement() public {
        Assert.isFalse(file.isActorPendingApproval(actor3), "Actor3 is not pending approval");
        file.requestInvolvement(actor3);
        Assert.isTrue(file.isActorPendingApproval(actor3), "Actor3 is now pending approval");
    }
    
    // Testing approveInvolvementRequest() function
    function testApproveInvolvementRequest() public {
        Assert.isTrue(file.isActorPendingApproval(actor3), "Actor3 is still pending approval");
        file.approveInvolvementRequest(actor3);
        Assert.isFalse(file.isActorPendingApproval(actor3), "Actor3 is now pending approval");
    }
}