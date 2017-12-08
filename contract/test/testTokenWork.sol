pragma solidity ^0.4.16;

/**
* Интерфейс позволяет нам получить нужную функцию у контракта, приведя адреса к интерфейсу
* 0xe79A0Bb6E5e2201610eB8A14e02a9023C7e420b6 - адрес контракта с токенами на vaio
*/
interface token {
    //mapping (address => uint256) public balanceOf;
    function balanceOf(address who) constant public returns (uint256);
    function transfer(address receiver, uint amount) public;
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
}

contract TokenRecipient{
    token tokenReward;

	function TokenRecipient(address addressOfToken) public {
		tokenReward = token(addressOfToken);
	}

	function receiveApproval(address _sender,
	                         uint256 _value,
	                         token _tokenContract,
	                         bytes _extraData) {
		require(_tokenContract == tokenReward);
		require(tokenContract.transferFrom(_sender, address(this), 1));
		uint256 payloadSize;
		uint256 payload;
		assembly {
			payloadSize := mload(_extraData)
			payload := mload(add(_extraData, 0x20))
		}
		payload = payload >> 8*(32 - payloadSize);
		info[sender] = payload;
	}
}

contract TestTokenWork is TokenRecipient{

	address public owner;
    //address public addressOfTokenUsedAsReward;
    //token tokenReward;

	//function TestTokenWork(address addressOfToken) public {
	function TestTokenWork() public {
		owner = msg.sender;
		//tokenReward = token(addressOfToken);
	}
	
	// function setTokenAddress(address addressOfToken) public{
	//     addressOfTokenUsedAsReward = addressOfToken;
	// }

	function setOrder(uint256 amount) public payable {
		tokenReward.transferFrom(msg.sender, this, amount);		
	}

	function getBalance(address addr) public constant returns (uint256){
		return tokenReward.balanceOf(addr);
	}

	function selfBalance() public constant returns (uint256){
		return this.balance;
	}

}