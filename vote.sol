// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Vote {
    //Cast votes
    //Close vote after some period of time and display final result after
    //owner/admin can add new poll or vote

    uint public optA;
    uint public optB;
    uint public optC;
    uint256 public voteCount = 0;
    uint public pollEndTime;
    string public description;
    string public labelA;
    string public labelB;
    string public labelC;
    address public owner;

    enum Options {
        A,
        B,
        C
    }

    mapping(address => bool) public hasVoted;
    address[] public voters;

    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    event votedAlready(address, Options);

    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    /**
     * @dev Set contract deployer as owner
     */
    constructor() {
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        emit OwnerSet(address(0), owner);
    }

    function createPoll(
        string memory _question,
        string memory _a,
        string memory _b,
        string memory _c
    ) public {
        description = _question;
        labelA = _a;
        labelB = _b;
        labelC = _c;

        optA = 0;
        optB = 0;
        optC = 0;
        voteCount = 0;
        pollEndTime = block.timestamp + 3 days;
    }

    function cast(uint x) public {
        require(x <= uint(Options.C), "Invalid Option");
        require(!hasVoted[msg.sender], "You have already voted");

        Options choice = Options(x);

        hasVoted[msg.sender] = true;
        voteCount++;
        voters.push(msg.sender);

        if (choice == Options.A) {
            optA++;
        } else if (choice == Options.B) {
            optB++;
        } else if (choice == Options.C) {
            optC++;
        }

        emit votedAlready(msg.sender, Options(x));
    }

    function reset() public isOwner {
        require(block.timestamp >= pollEndTime, "Poll is still active!!!");
        // Reset integers
        optA = 0;
        optB = 0;
        optC = 0;
        voteCount = 0;

        //Reset Current poll data
        description = '';
        labelA = '';
        labelB = '';
        labelC = '';



        // Reset the hasVoted mapping for every voter in our array
        for (uint i = 0; i < voters.length; i++) {
            hasVoted[voters[i]] = false;
        }

        // Clear the voters array
        delete voters;
    }


}
