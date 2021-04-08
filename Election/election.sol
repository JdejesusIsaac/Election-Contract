pragma

contract Election {

    struct Candidate {
        string name;
        uint voteCount;

    }

    struct Voter {
        bool voted;
        uint vote;
        uint weight;

    }
    address public owner;
    sring public name;
    mapping(address => Voter) public voters;
    Candidate[] public candidates;

    event ElectionResult(string _name, string candidate1, string candidate2) public {
        owner = msg.sender;

        
    }

    function Election(string _name, string candidate1, string candidate2) public {
        owner = msg.sender;

        name = _name;
        // initialize lists of candidates to vote for
        candidates.push(Candidate(candidate1, 0));
        candidates.push(Candidate(candidate2, 1)); 


    }
    function authorize(address voter) public {
        //make sure only owner can authorize voting rights
        require(msg.sender == owner);
        // make sure voter has not already voted
        require(!voters[voter].voted);

        //assign voting rights
        voters[voter].weight = 1;
    }

    function vote(uint voteIndex) public {
        //make sure voter has not already voted
        require(!voters[msg.sender].voted);

        //record vote
        voters[msg.sender].vote = voteIndex;
        voters[msg.sender].voted = true;

        //increase candidate vote count by voter weight
        candidates[viteIndex].voteCount += voters[msg.sender].weight;
    }

    function end() public {
        //make sure ownly owner can end voting
        require(msg.sender == owner);

        //announce each candidates results
        for(uint i=0; i < candidates.length; i++){
            ElectionResult(candidates[i].name, candidates[i].voteCount);

            //destroy the contract
            selfdestruct(owner);
        }
    }
}