pragma solidity ^0.4.17;

import "./ActorRegistry.sol";

contract File {
    address private owner;
    
    ActorRegistry actorRegistry;
    
    mapping(address => bool) private actorsInvolved;
    uint256 countActorsInvolved;
    
    mapping(address => bool) private pendingRequests;
    uint256 countPendingRequests;

    struct FileState {
        string fileName;
        string fileHash;
        uint256 timestamp;
        address lastUpdatedBy;
    }
    
    FileState private currentState;
    mapping (uint256 => FileState) private changeLog;
    uint256 private countUpdates;
    
    event OnChange(string eventId, string eventDescriptor);
    
    function File(address registryAddress, string _fileName, string _fileHash) public {
        //"0xbfd5b36fa6f5de48d807397e9b68d0a0d694e38e", "file1", "docx", "hello world"
        actorRegistry = ActorRegistry(registryAddress);
        //require (actorRegistry.actorExists(msg.sender));
        
        owner = msg.sender;
        
        actorsInvolved[msg.sender] = true;
        countActorsInvolved = 1;
        countPendingRequests = 0;
        
        currentState.fileName = _fileName;
        currentState.fileHash = _fileHash;
        currentState.timestamp = 0;
        currentState.lastUpdatedBy = msg.sender;
        
        countUpdates = 0;
        changeLog[countUpdates++] = currentState;
    }
    
    function addActorInvolved(address actorAddress) public returns (bool) {
        require (owner == msg.sender);
        
        if (actorsInvolved[actorAddress] == false) {
            actorsInvolved[actorAddress] = true;
            countActorsInvolved++;
            return true;
        }
        else {
            return false;
        }
    }
    
    function removeActorInvolved(address actorAddress) public returns (bool) {
        //require (owner == msg.sender && actorRegistry.actorExists(actorAddress));
        
        if (actorsInvolved[actorAddress] == true) {
            actorsInvolved[actorAddress] = false;
            return true;
        }
        else {
            return false;
        }
    }
    
    function requestInvolvement(address actorAddress) public {
        //require (actorRegistry.actorExists(msg.sender));
        
        //pendingRequests[msg.sender] = true;
        pendingRequests[actorAddress] = true;
        countPendingRequests++;
    }
    
    function approveInvolvementRequest(address addressToApprove) public returns (bool) {
        //require (owner == msg.sender);
        
        if (pendingRequests[addressToApprove] == true) {
            actorsInvolved[addressToApprove] = true;
            pendingRequests[addressToApprove] = false;
            countPendingRequests--;
            return true;
        }
        else {
            return false;
        }
    }
    
    function updateFile(string newFileName, string newFileHash) public returns (bool) {
        //require(actorRegistry.actorExists(msg.sender));
        
        FileState newState;
        newState.fileName = newFileName;
        newState.fileHash = newFileHash;
        newState.timestamp = 0;
        newState.lastUpdatedBy = msg.sender;
        
        changeLog[countUpdates++] = newState;
        
        OnChange(newFileName, newFileHash);
    }
    
    function isActorOwner(address actorAddress) public returns (bool) {
        return owner == actorAddress;
    }
    
    function isActorInvolved(address actorAddress) public returns (bool) {
        return actorsInvolved[actorAddress] == true;
    }
    
    function howManyActorsInvolved() public returns (uint256) {
        return countActorsInvolved;
    }
    
    function isActorPendingApproval(address actorAddress) public returns (bool) {
        return pendingRequests[actorAddress] == true;
    }
    
    function howManyPendingRequests() public returns (uint256) {
        return countPendingRequests;
    }
    
    function howManyUpdates() public returns (uint256) {
        return countUpdates;
    }
    
    function getFileName() public returns (string) {
        return currentState.fileName;
    }
    
    function getFileHash() public returns (string) {
        return currentState.fileHash;
    }
    
    function getFileLastAuthor() public returns (address) {
        return currentState.lastUpdatedBy;
    }
}
