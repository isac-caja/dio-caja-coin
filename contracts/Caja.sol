pragma solidity ^0.8.0;

interface IRCC20{
  function totalSupply() external view returns (uint256);

  function balanceOf(address account) external view returns (uint256);

  function allowance(address owner, address spender) external view returns (uint256);

  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

  function transfer(address receipt, uint256 amount) external returns (bool);

  function approve(address spender, uint256 amount) external returns (bool);

  event Transfer(address indexed from, address indexed to, uint256 value);

  event Approval(address indexed owner, address indexed spender, uint256 value);
}


contract CajaCoin is IRCC20 {
  string public constant name = "Caja Coin";

  string public constant symbol = "Caja";

  uint8 public constant decimals = 18;

  mapping (address => uint256) balances;

  mapping (address => mapping(address => uint256)) allowed;

  uint256 totalSupply_ = 10 ether;

  constructor(){
    balances[msg.sender] = totalSupply_;
  }
  function totalSupply() public view returns (uint256) {
    return totalSupply_;
  }

  function balanceOf(address tokenOwner) public override view returns (uint256) {
    return balances[tokenOwner];
  }

  function transfer(address receiver, uint256 numTokens) public override returns (bool) {
    require(numTokens <= balances[msg.sender]);
    balances[msg.sender] = balances[msg.sender] - numTokens;
    balances[receiver] = balances[receiver] + numTokens;
    emit Transfer(msg.sender, receiver, numTokens);
    return true;
  }

  function approve(address delegate, uint256 numTokens) public override returns (bool) {
    allowed[msg.sender][delegate] = numTokens;
    emit Approval(msg.sender, delegate, numTokens);
    return true;
  }

  function allowance(address owner, address deletage) public override view returns (uint) {
    return allowed[owner][deletage];
  }

  function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
    require(amount <= balances[sender]);
    require(amount <= allowed[sender][msg.sender]);
    balances[sender] = balances[sender] - amount;
    allowed[sender][msg.sender] = allowed[sender][msg.sender] - amount;
    balances[recipient] = balances[recipient] + amount;
    emit Transfer(sender, recipient, amount);
    return true;
  }

}
