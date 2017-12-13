pragma solidity ^0.4.16;

interface token {
    //mapping (address => uint256) public balanceOf;
    function balanceOf(address who) constant public returns (uint256);
    function transfer(address receiver, uint amount) public;
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
}

/**
* Контракт для: 
* заказа рекламы, 
* регистрации нового устройства отображения рекламы, 
* контроля выдачи рекламы устройствам на основании данных заказа,
*
* Заказ рекламы производиться за собственную крипто-валют ADVT
* констракт с токеном на работе 0x24a6dCB5E3b3DfD29999904eDA20FE7a4D6EBAE9
*/

contract ADV_Automatization {

	address public tokenContract;
	address public owner;

	event SetNewAdv(address _from, string _adv_text);

	/**
	* Информация об устройстве умеющем показывать рекламу
	* (будет расширяться)
	*/
	struct DeviceInfo {
		// Только авторизованные устройства получают заказы 
		// проставляется специальным человеком, или же на основании проверки подписи программного пакета
        bool isAuthorized;
        // Регион - информация о месте положения устройства
        string region;
	}

	struct AdvInfo {
		//Адрес с которого пришла оплата за рекламу
		address addr;
		//Текст рекламы для текстовых блоков
		string adv_text;
		//Ссылка на внешний урл с рекламным роликом
		string adv_url;
		//Один из возможных типов контракта 
		uint adv_contract_type;
	}
	

	/**
	* Маппинг устройств и флага авторизованно ли устройство
	* Каждое устройство имеет свой адрес в сети, 
	* на который будут перечисляться деньги за показ.
	*/
	mapping (address => DeviceInfo) public devices;

	/**
	* Массив рекламных блоков
	*/
	AdvInfo[] public advertisement;


	/**
	* Возможность принятия эфира
	*/
	function() payable public { }

	function ADV_Automatization(address _token) public {
		tokenContract = _token;
		owner = msg.sender;
	}

	/**
	* Функция заказа рекламы, оплачиваемая
	*/
    function receiveAdvApproval(address _from, uint256 _value, address _token,      
        //Текст рекламы для текстовых блоков
        string _adv_text,
        //Ссылка на внешний урл с рекламным роликом/картинкой
        string _adv_url,
        //Один из возможных типов контракта 
        uint _adv_contract_type) public{

		require(_token == tokenContract);
		require(token(tokenContract).transferFrom(_from, address(this), _value));

		advertisement.push(AdvInfo(_from, _adv_text, _adv_url, _adv_contract_type));	
		SetNewAdv(_from, _adv_text);
    }

    function getAdvertisement(uint index) public view returns (address, string, string, uint){
    	return (advertisement[index].addr, advertisement[index].adv_text, advertisement[index].adv_url, advertisement[index].adv_contract_type);
    }

    // function getAdvText(uint index) public returns (string){
    // 	return advertisement[index].adv_text;
    // }

}