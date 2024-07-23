# EventOrganization
This is simple event organization contract
This Solidity code represents an Event Organization contract that facilitates the creation and management of events. :

1. `struct Event`: This defines the structure for an event with several properties including organizer address, name, date, ticket price, total tickets, and remaining tickets.

2. `mapping(uint256 => Event) public events;`: This is a mapping from unique event IDs to their respective Event structs. The owner of the contract can access all the information related to an event using its ID.

3. `mapping(address => mapping(uint256 => uint256)) public event_tickets;`: This is a nested mapping where each key represents an address (the buyer) and for each address, there's another mapping from event IDs to the number of tickets they own.

4. `createEvent` function: This allows an account to create a new event with details such as name, date, price per ticket, and total tickets. It checks that the event is being organized in the future (date > current timestamp) and that there are enough tickets for sale. 

5. `buyTicket` function: This allows accounts to buy certain tickets for an event. The transaction value must match the price times quantity, and not all tickets may be available if they have been sold out. 

6. `transfer ticket` function: This allows one account to transfer a certain quantity of their tickets to another account. It first checks that the sender has enough tickets and the event hasn't happened yet. If both conditions are met, it decreases the number of sender's tickets by the given amount and increases the recipient's ticket count.

The contract uses the `require` function for input validation ensuring that only valid transactions can be processed. The use of `external` keyword in function declarations indicates that these functions can be called directly from outside this contract, making them "public".
