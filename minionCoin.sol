pragma solidity ^0.4.16;

contract minionCoin {
    
    mapping(address => uint256) public balanceOf;
    address public minter;
    event Transfer(address _from, address _to, uint256 _value);
    
    /* constructor function invoked once when the contract is deployed. */
    function minionCoin(uint256 initialSupply) public {
        balanceOf[msg.sender] = initialSupply;
        minter = msg.sender;
    }
    
    function _transferCoins(address _from, address _to, uint256 _amount) internal {
        /* check for overflow and underflow */
        require(balanceOf[_from] > _amount && balanceOf[_to] + _amount >= balanceOf[_to]);
        balanceOf[_from] -= _amount;
        balanceOf[_to] += _amount;
        /* generate event for client listeners. */
        Transfer(_from, _to, _amount);
    }
    
    function transfer(address _to, uint256 _amount) public {
        _transferCoins(msg.sender, _to, _amount);
    }
    
    function transferFrom(address _from, address _to, uint256 _amount) public {
        _transferCoins(_from, _to, _amount);
    }
    
    function mint(address _from, uint256 amount) public {
        if(_from != minter) return;
        balanceOf[_from] += amount;
    }
}