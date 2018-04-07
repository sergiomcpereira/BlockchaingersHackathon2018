pragma solidity ^0.4.17;

contract Actor {
    address private id;
    bytes32 private name;
    uint256 private role;
    
    function Actor(address _id, bytes32 _name, uint256 _role) public {
        id = _id;
        name = _name;
        role = _role;
    }
    
    function isThisActor(address idToCompare) public returns (bool) {
        return id == idToCompare;
    }
    
    function hasThisRole(uint256 roleToCompare) public returns (bool) {
        return role == roleToCompare;
    }
    
    function getId() public returns (address) {
        return id;
    }
    
    function getName() public returns (bytes32) {
        return name;
    }
    
    function getRole() public returns (uint256) {
        return role;
    }
}