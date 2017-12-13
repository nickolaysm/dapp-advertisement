pragma solidity ^0.4.18;

contract SimpleStorage {
  uint storedData;
  string str;

  function SimpleStorage(string _str) public{
  	str = _str;
  }

  function set(uint x) public {
    storedData = x;
  }

  function get() public view returns (uint) {
    return storedData;
  }

  function getStr() public view returns (string) {
    return str;
  }

}
