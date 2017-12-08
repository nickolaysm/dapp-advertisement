pragma solidity ^0.4.16;


contract CreateString{
    string public str;

	function CreateString(string value) public {
		str = value;
	}

}

contract CreateOwner is CreateString {
	address public owner;
	address public token;

	function CreateOwner(address _token) public{
		owner = msg.sender;
		token = _token;
	}

}