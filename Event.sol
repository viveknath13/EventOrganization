// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract EventOrganization {
    struct Event {
        address organizer; //address of eventOrganizer who conduct the event
        string name; //name of the event
        uint256 date; // the date when event was conduct
        uint256 ticket_price; //price of the ticket
        uint256 ticket; // how much ticket are avaliable
        uint256 ticket_remain; //after selling ticket how much ticket are remaining
    }
    mapping(uint256 => Event) public events;
    mapping(address => mapping(uint256 => uint256)) public event_tickets;
    uint256 public nextEventId;

    function createEvent(
        string memory name,
        uint256 date,
        uint256 price,
        uint256 ticket
    ) external {
        require(date > block.timestamp, "You can organize event for futrure");
        require(
            ticket > 0,
            "i hope your organization  have ticket more then 0..."
        );
        events[nextEventId] = Event(
            msg.sender,
            name,
            date,
            price,
            ticket,
            ticket
        );
        nextEventId++;
    }

    function buyTicket(uint256 id, uint256 quantity) external payable {
        require(events[id].date != 0, "This event does't exist");
        require(events[id].date > block.timestamp, "Event has already occured");

        Event storage _event = events[id];
        require(
            msg.value == (_event.ticket_price * quantity),
            "what you don't pay enogh ETH,please pay enough ETH"
        );
        require(_event.ticket_remain >= quantity, "Sorry we sold all tickets ");
        _event.ticket_remain -= quantity;
        event_tickets[msg.sender][id] += quantity;
    }

    function transferTicket(
        uint256 id,
        uint256 quantity,
        address person
    ) external {
        require(events[id].date != 0, "This event does't exist");
        require(events[id].date > block.timestamp, "Event has already occured");
        require(
            event_tickets[msg.sender][id] >= quantity,
            "Hey, you do not have enough ticket"
        );
        event_tickets[msg.sender][id] -= quantity;
        event_tickets[person][id] += quantity;
    }
}

