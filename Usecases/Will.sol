pragma solidity >=0.4.22 <0.6.0;

contract Will {
    
    address owner;
    uint fortune;
    bool isDecesed;
    
    constructor() public payable {
        owner = msg.sender;
        fortune = msg.value;
        isDecesed = false;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the Owner of the contract.");
        _;
    }
    
    modifier mustBeDecesed() {
        require(isDecesed == true, "Not decesed. So, not allowed to payout.");
        _;
    }
    
    address payable[] familyWallets;
    
    mapping (address => uint) inheritance;
    
    function setInheritance(address payable wallet, uint inheritAmount) public onlyOwner {
        familyWallets.push(wallet);
        inheritance[wallet] = inheritAmount;
    }
    
    function payment() private mustBeDecesed {
        for (uint i = 0; i<familyWallets.length; i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }
    
    function decesed() public onlyOwner {
        isDecesed = true;
        payment();
    }
    
}
