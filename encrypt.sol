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
