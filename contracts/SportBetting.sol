pragma solidity ^0.4.24;


contract SportsBetFactory{

   struct contractSummary{
    address contractAddress; uint bidAmount; uint teamPick; uint day; uint month; uint year; string homeTeam; string awayTeam; uint handicap;
     }

    contractSummary[] public deployedContracts;

    function createContract( uint bidAmount, uint teamPick,uint day,uint month, uint year, string homeTeam,string awayTeam, uint handicap)public payable{
        require(msg.value >0);
        address newBetContract = new BetContract(msg.sender,bidAmount, teamPick, day, month, year, homeTeam, awayTeam,handicap);

        contractSummary memory newSummary = contractSummary({
        contractAddress:newBetContract,
        bidAmount:bidAmount,
        teamPick:teamPick,
        day : day,
        month: month,
        year: year,
        homeTeam: homeTeam,
        awayTeam : awayTeam,
        handicap: handicap
        });

        deployedContracts.push(newSummary);
        }
        function getDeployedContractsLength() public view returns(uint){
          return deployedContracts.length;
        }
}

contract BetContract {

    struct Bid{
    address owner; uint bidAmount; uint handicap; uint teamPick;
     }

    Bid [] public allBids;

    address public manager;
    string private creatorsContactInfo;
    string public briefDescription;
    string public fullDescription;
    string public teamPick;
    uint public day;
    uint public month;
    uint public year;
    string public homeTeam;
    string public awayTeam;
    uint public bidAmount;
    uint public handicap;
    Bid[] public homeBids ;
    uint homeBidTotal;
    Bid[] public awayBids;
    uint public awayBidTotal;

    uint public timeStamp;

    constructor(address sender, uint bidAmount1, uint teamPick1,uint day1,uint month1, uint year1, string homeTeam1,string awayTeam1, uint handicap1

    ) public payable {


        manager = sender;
        homeTeam = homeTeam1;
        awayTeam = awayTeam1;
        day = day1;
        month = month1;
        year = year;
        teamPick = teamPick;
        bidAmount = msg.value;
        timeStamp = now;
        handicap = handicap1;
        }


//this function takes into account all the neccessary actions that need to take place when an addition bid is placed on a created contract
//first a new bid struct is created and then the struct is stores in the appropriate bid array
// the total home/away bids are also calculated and stored
     function bidOnGame(uint teamPick, uint handicap1) public payable{
        require(msg.value >0);

        Bid memory newBid = Bid({
        owner:msg.sender,
        handicap:handicap1,
        teamPick : teamPick,
        bidAmount:msg.value
        });

        if (teamPick == 0){
           homeBidTotal += bidAmount;
           homeBids.push(newBid); 
        }else{
           awayBidTotal += bidAmount;
           awayBids.push(newBid);
        }
    }

//function to retrieve the total number of bids placed
    function getNumberOfBids(uint teamPick) public view returns(uint){
        require(teamPick == 0 || teamPick == 1);
        if (teamPick ==0){
            return homeBids.length; 
        }else if (teamPick ==1){
            return awayBids.length;
        }
    }



//function to calculate a distribute funds based on input from oracle
    function calculateResults(uint winner) public {
        require(winner == 0 || winner == 1);

        if (winner ==0){
            for (uint i=0 ; i < awayBids.length; i++){
                homeBids[i].owner.transfer((homeBids[i].bidAmount/homeBidTotal)* awayBidTotal);
            }
            }else if(winner ==1){
            for (uint h=0 ; h < homeBids.length; h++){
            awayBids[h].owner.transfer((awayBids[h].bidAmount/awayBidTotal)* homeBidTotal);
            }
        }
    }
    

    function getSummary() public view returns(
       address
       ){
       return(
        manager

         );
     }
}
