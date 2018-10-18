pragma solidity 0.4.24;

import "zos-lib/contracts/migrations/Migratable.sol";

contract Messenger is Migratable {

  mapping(address => uint) numMessages;
  mapping(address => mapping(uint => uint)) indexMessages;
  mapping(address => mapping(uint => uint)) timestamps;
  mapping(address => mapping(uint => string)) messages;

  event NewMessage(address, uint, string);
  event UpdateMessage(address, uint);
  event RemoveMessage(address, uint);

  function initialize() isInitializer("Messenger", "0") public {
  }

  function setMessage(uint _timestamp, string _msg) public {
    numMessages[msg.sender]++;

    indexMessages[msg.sender][numMessages[msg.sender]] = _timestamp;
    messages[msg.sender][numMessages[msg.sender]] = _msg;
    timestamps[msg.sender][_timestamp] = numMessages[msg.sender];

    emit NewMessage(msg.sender, _timestamp, _msg);
  }

  function getMessageByTimestamp(address _addr, uint _timestamp) view public returns (uint, string) {
    return (_timestamp, messages[_addr][timestamps[_addr][_timestamp]]);
  }

  function getMessageByIndex(address _addr, uint _index) view public returns (uint, string) {
    return (indexMessages[msg.sender][_index], messages[msg.sender][_index]);
  }

  function getCountMessages(address _addr) view public returns (uint) {
    return numMessages[_addr];
  }

  function updateMessage(uint _index, string _msg) public {
    messages[msg.sender][_index] = _msg;
    emit UpdateMessage(msg.sender, _index);
  }

  function removeMessage(uint _index) public {
    messages[msg.sender][_index] = "";
    emit RemoveMessage(msg.sender, _index);
  }
}
