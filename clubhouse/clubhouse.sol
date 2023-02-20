// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ClubhouseClone {

    struct Room {
        string name;
        address host;
        uint256 startTime;
        uint256 endTime;
        uint256 capacity;
        address[] speakers;
        address[] listeners;
    }

    mapping(address => Room[]) private rooms;

    function createRoom(string memory _name, uint256 _startTime, uint256 _endTime, uint256 _capacity) public {
        require(_endTime > _startTime, "Invalid time range");
        rooms[msg.sender].push(Room(_name, msg.sender, _startTime, _endTime, _capacity, new address[](0), new address[](0)));
    }

    function getRooms(address _host) public view returns (Room[] memory) {
        return rooms[_host];
    }

    function joinAsSpeaker(address _host, uint256 _roomId) public {
        Room storage room = rooms[_host][_roomId];
        require(room.host == _host, "Invalid host");
        require(room.startTime <= block.timestamp && block.timestamp <= room.endTime, "Room is closed");
        require(room.capacity > room.speakers.length, "Room is full");

        room.speakers.push(msg.sender);
    }

    function joinAsListener(address _host, uint256 _roomId) public {
        Room storage room = rooms[_host][_roomId];
        require(room.host == _host, "Invalid host");
        require(room.startTime <= block.timestamp && block.timestamp <= room.endTime, "Room is closed");
        require(room.capacity > room.listeners.length, "Room is full");

        room.listeners.push(msg.sender);
    }

    function leaveRoom(address _host, uint256 _roomId) public {
        Room storage room = rooms[_host][_roomId];
        require(room.host == _host, "Invalid host");

        for (uint256 i = 0; i < room.speakers.length; i++) {
            if (room.speakers[i] == msg.sender) {
                for (uint256 j = i; j < room.speakers.length - 1; j++) {
                    room.speakers[j] = room.speakers[j + 1];
                }
                room.speakers.pop();
                return;
            }
        }

        for (uint256 i = 0; i < room.listeners.length; i++) {
            if (room.listeners[i] == msg.sender) {
                for (uint256 j = i; j < room.listeners.length - 1; j++) {
                    room.listeners[j] = room.listeners[j + 1];
                }
                room.listeners.pop();
                return;
            }
        }
    }
}
