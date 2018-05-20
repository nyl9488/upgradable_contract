pragma solidity ^0.4.18;


contract MetaCoin {
	MetaCoinStorage metaCoinStorage;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	function MetaCoin(address metaCoinStorageAddress) {
		metaCoinStorage = MetaCoinStorage(metaCoinStorageAddress);
	}

	function sendCoin(address receiver, uint amount) returns(bool sufficient) {
		if (metaCoinStorage.getBalance(msg.sender) < amount) return false;
		metaCoinStorage.setBalance(msg.sender, metaCoinStorage.getBalance(msg.sender) - amount);
		metaCoinStorage.setBalance(receiver, metaCoinStorage.getBalance(receiver) + amount);
		Transfer(msg.sender, receiver, amount);
		return true;
	}

	function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) public view returns(uint) {
		return metaCoinStorage.getBalance(addr)+1;
	}
}

interface MetaCoinStorage {
    function getBalance(address _address) public view returns(uint);
    function setBalance(address _address, uint _balance) public;
}

library ConvertLib{
    function convert(uint amount,uint conversionRate) public pure returns (uint convertedAmount)
    {
        return amount * conversionRate;
    }
}
