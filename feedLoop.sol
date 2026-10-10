function getFeedback(uint256 index)
        external
        view
        returns (
            address student,
            uint8 rating,
            string memory comment,
            uint256 timestamp
        )
    {
        require(index < feedbackList.length, "Invalid index");
        Feedback storage item = feedbackList[index];
        return (
            item.student,
            item.rating,
            item.comment,
            item.timestamp
        );
    }
