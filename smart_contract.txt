// SPDX-License-Identifier: MIT
pragma solidity ^0.5.8;

contract AccidentResponsibility {
    mapping(uint => uint) public votesForVehicles; // Vehicle ID -> Vote Count
    mapping(uint => string) public speakerIDs; // Vehicle ID -> Speaker ID

    // Event declarations
    event VoteRecorded(uint vehicleID);
    event SpeakerIDRecorded(uint vehicleID, string speakerID);
    event VotesReset();

    // Record a vote for a specific vehicle
    function recordVote(uint vehicleID) public {
        votesForVehicles[vehicleID]++;
        emit VoteRecorded(vehicleID);
    }

    // Record a speaker ID for a specific vehicle
    function recordSpeakerID(uint vehicleID, string memory speakerID) public {
        speakerIDs[vehicleID] = speakerID;
        emit SpeakerIDRecorded(vehicleID, speakerID);
    }

    // Determine which vehicle has the majority of votes
    function getVehicleWithMostVotes() public view returns (uint vehicleID, uint voteCount) {
        uint leadingVehicleID;
        uint leadingVoteCount;
        
        for (uint i = 1; i <= 10; i++) {
            if (votesForVehicles[i] > leadingVoteCount) {
                leadingVehicleID = i;
                leadingVoteCount = votesForVehicles[i];
            }
        }

        return (leadingVehicleID, leadingVoteCount);
    }

    // Reset all votes
    function resetVotes() public {
        for (uint i = 1; i <= 10; i++) {
            votesForVehicles[i] = 0;
        }
        emit VotesReset();
    }
}
