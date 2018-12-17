pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players;
    
    function Lottery() public {
        manager = msg.sender;
    }
    
    function enter() public payable {
        require(msg.value > .01 ether);
        
        players.push(msg.sender);
    }
    
    function random() private view returns (uint) {
        return uint(keccak256(block.difficulty, now, players));
    }
    
    function pickWinner() public restricted {
        uint index = random() % players.length;
        players[index].transfer(this.balance); //send all money to the winner address (ex).x1019212basd128905
        players = new address[](0); //resets the players dynamic array to size 0 and thus resets the contract
    }
    
    modifier restricted() {
        require(msg.sender == manager);
        _; //syntax target for the function code
    }
    
    function getPlayers() public view returns (address[]) {
        return players;
    }
}