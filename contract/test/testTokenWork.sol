pragma solidity ^0.4.16;

/**
* Интерфейс позволяет нам получить нужную функцию у контракта, приведя адреса к интерфейсу
* 0xe79A0Bb6E5e2201610eB8A14e02a9023C7e420b6 - адрес контракта с токенами на vaio
*/
interface token {
    //mapping (address => uint256) public balanceOf;
    function balanceOf(address who) constant public returns (uint256);
    function transfer(address receiver, uint amount) public;
}

contract TestTokenWork {

	address public owner;
    address public addressOfTokenUsedAsReward;
    token tokenReward;

	function TestTokenWork(address addressOfToken) public {
		owner = msg.sender;
		tokenReward = token(addressOfToken);
	}
	
	function setTokenAddress(address addressOfToken) public{
	    addressOfTokenUsedAsReward = addressOfToken;
	}

	function getBalance(address addr) public constant returns (uint256){
		return tokenReward.balanceOf(addr);
	}

}