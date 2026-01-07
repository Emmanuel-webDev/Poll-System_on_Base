// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Vote{
    //Cast votes 
    //Close vote after some period of time and display final result after
    //owner/admin can add new poll or vote

    mapping(address => bool) public  hasVoted;
    address[] public voters;
    uint256 public voteCount;

    struct Voter{
        address user;
    }

   
    function cast public (){

    }


}