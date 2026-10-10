// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
 
contract StudentFeedback {
    address public owner;
    bool public submissionsPaused;
 
    struct Feedback {
        address student;
        uint8 rating;
        string comment;
        uint256 timestamp;
    }
 
    Feedback[] private feedbackList;
    mapping(address => bool) public hasSubmitted;
 
    event FeedbackSubmitted(
        address indexed student,
        uint8 rating,
        uint256 timestamp
    );
    event SubmissionStatusChanged(bool paused, address indexed changedBy);
 
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }
 
    constructor() {
        owner = msg.sender;
    }
 
    function submitFeedback(
        uint8 rating,
        string calldata comment
    ) external {
        require(!submissionsPaused, "Submissions are paused");
        require(!hasSubmitted[msg.sender], "Already submitted");
        require(rating >= 1 && rating <= 5, "Rating must be 1-5");
        require(bytes(comment).length > 0, "Comment cannot be empty");
        require(bytes(comment).length <= 500, "Comment too long");
 
        hasSubmitted[msg.sender] = true;
        feedbackList.push(Feedback({
            student: msg.sender,
            rating: rating,
            comment: comment,
            timestamp: block.timestamp
        }));
 
        emit FeedbackSubmitted(msg.sender, rating, block.timestamp);
    }
