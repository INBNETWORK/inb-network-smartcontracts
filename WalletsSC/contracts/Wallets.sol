pragma solidity 0.4.24;

import "zos-lib/contracts/migrations/Migratable.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "./IERC20.sol";

contract Wallets is Ownable, Migratable {
    string public constant name = "Wallets";

    mapping(address => mapping(address => uint)) public wallets;
    mapping(address => mapping(uint => address)) public reverseWallets;
    mapping(address => uint) public numWallets;
    mapping(address => bool) public originalTokens;
    
    event AddWallet(address _account, address _addressToken);
    event RemoveWallet(address _account, address _addressToken);
    
    modifier validAddress(address _address) {
        require(_address != address(0));
        _;
    }
    
    modifier notExists(address _account, address _addressToken) {
        require(wallets[_account][_addressToken] == 0);
        _;
    }
    
    modifier exists(address _account, address _addressToken) {
        require(wallets[_account][_addressToken] != 0);
        _;
    }
    
    modifier onlyERC20(address _addressToken) {
        IERC20 token = IERC20(_addressToken);
        token.name();
        token.symbol();
        token.decimals();
        token.balanceOf(_addressToken);
        _;
    }

    function initialize() isInitializer("Wallets", "0") public {
    }
    
    function addOriginalToken(address _addressToken) external onlyOwner onlyERC20(_addressToken) {
        originalTokens[_addressToken] = true;
    }
    
    function removeOriginalToken(address _addressToken) external onlyOwner {
        originalTokens[_addressToken] = false;
    }
    
    function addWallet(address _addressToken) external {
        _addWallet(msg.sender, _addressToken);
    }
    
    function addWalletFrom(address _account, address _addressToken) external onlyOwner {
        _addWallet(_account, _addressToken);
    }
    
    function removeWallet(address _addressToken) external {
        _removeWalletByAddress(msg.sender, _addressToken);
    }
    
    function removeWalletFrom(address _account, address _addressToken) external onlyOwner {
        _removeWalletByAddress(_account, _addressToken);
    }
    
    function getWalletsAddress(address _account) view public returns(address[]) {
        address[] memory addresses = new address[](numWallets[_account]);
        for (uint i = 1; i <= numWallets[_account]; i++) {
            addresses[i-1] = reverseWallets[_account][i];
        }
        
        return addresses;
    }
    
    function getWalletByAddressContract(address _account, address _addressToken) view public returns (string, string, uint8, uint, bool) {
        IERC20 t = IERC20(_addressToken);
        
        return(
            t.name(),
            t.symbol(),
            t.decimals(),
            t.balanceOf(_account),
            originalTokens[_addressToken]
        );
    }
    
    function getWalletByIndex(address _account, uint _index) view public returns (string, string, uint8, uint, bool) {
        IERC20 t = IERC20(reverseWallets[_account][_index]);
        
        return(
            t.name(),
            t.symbol(),
            t.decimals(),
            t.balanceOf(_account),
            originalTokens[reverseWallets[_account][_index]]
        );
    }
    
    function isOriginal(address _addressToken) view public returns (bool) {
        return originalTokens[_addressToken];
    }
    
    function _addWallet(address _account, address _addressToken)
        internal
        validAddress(_addressToken)
        validAddress(_account)
        notExists(_account, _addressToken)
        onlyERC20(_addressToken)
    {
        numWallets[_account]++;
        wallets[_account][_addressToken] = numWallets[_account];
        reverseWallets[_account][numWallets[_account]] = _addressToken;
        
        emit AddWallet(_account, _addressToken);
    }
    
    function _removeWalletByAddress(address _account, address _addressToken)
        internal
        validAddress(_addressToken)
        validAddress(_account)
        exists(_account, _addressToken)
        onlyERC20(_addressToken)
    {
        uint a = wallets[_account][_addressToken];
        address l = reverseWallets[_account][numWallets[_account]];
        
        wallets[_account][l] = a;
        reverseWallets[_account][a] = l;
        
        numWallets[_account]--;
        
        emit RemoveWallet(_account, _addressToken);
    }
}