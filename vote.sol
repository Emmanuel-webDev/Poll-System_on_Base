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
    address public  owner;

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
            optB++;
        }

        emit votedAlready(msg.sender, Options(x));
    }

    
}
