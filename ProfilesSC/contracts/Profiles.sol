pragma solidity ^0.4.24;

import "zos-lib/contracts/migrations/Migratable.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract Profiles is Ownable, Migratable {
    string public constant name = "Profiles";

    struct User {
        string nickname;
        string avatar;
        string payload;
        bool isEntity;
    }

    mapping(address => User) private users;
    mapping(bytes32 => address) private addresses;

    function initialize() isInitializer("Profiles", "0") public {
    }

    function newUserFrom(address _addr, string _nickname, string _avatar, string _payload) public onlyOwner {
        require(nicknameIsFree(_nickname));

        if (!users[_addr].isEntity) {
            users[_addr] = User(_nickname, _avatar, _payload, true);
            addresses[keccak256(_nickname)] = _addr;
        }
    }

    function newUser(string _nickname, string _avatar, string _payload) public {
        require(nicknameIsFree(_nickname));

        if (!users[msg.sender].isEntity) {
            users[msg.sender] = User(_nickname, _avatar, _payload, true);
            addresses[keccak256(_nickname)] = msg.sender;
        }
    }

    function getNicknameByAddress(address _addr) public constant returns(string) {
        return users[_addr].nickname;
    }

    function setNickname(string _newNickname) public {
        require(nicknameIsFree(_newNickname));

        delete addresses[keccak256(getNicknameByAddress(msg.sender))];

        addresses[keccak256(_newNickname)] = msg.sender;
        users[msg.sender].nickname = _newNickname;
    }

    function getAddressByNickname(string _nickname) public constant returns(address) {
        return addresses[keccak256(_nickname)];
    }

    function getAvatarByAddress(address _addr) public constant returns(string) {
        return users[_addr].avatar;
    }

    function getAvatarByNickname(string _nickname) public constant returns(string) {
        return getAvatarByAddress(getAddressByNickname(_nickname));
    }

    function setAvatar(string _avatar) public {
        users[msg.sender].avatar = _avatar;
    }

    function setAvatarFrom(address _addr, string _avatar) public onlyOwner {
        users[_addr].avatar = _avatar;
    }

    function setPayloadFrom(address _addr, string _payload) public onlyOwner {
        users[_addr].payload = _payload;
    }

    function setPayload(string _payload) public {
        users[msg.sender].payload = _payload;
    }

    function getPayloadFrom(address _addr) public constant returns(string) {
        return users[_addr].payload;
    }

    function nicknameIsFree(string _nickname) public constant returns(bool) {
        var _addr = getAddressByNickname(_nickname);
        return !(users[_addr].isEntity);
    }

    function removeUser(address _addr) public onlyOwner {
        delete addresses[keccak256(getNicknameByAddress(_addr))];
        delete users[_addr];
    }
}