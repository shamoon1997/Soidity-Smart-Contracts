// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;


contract simpleAuction{
    bool AuctionClosed=false;
    address payable auctionOwner;
    uint256 topBidAmount=0;
    uint256 auctionStartPrice;
    uint256 auctionTime;
    address public topBidder;
    uint256 public topBid;

    mapping( address => uint256) pendingReturns;

    event auctionStarted(address auctionOwner, uint256 startPrice);
    event bidPlaced(address bidder, uint256 bidAmount);
    event auctionClosed(address topBider, uint256 topBid);


    function startAuction(uint256 _auctionStartPrice, uint256 _auctionTime) public {
        auctionOwner= payable(msg.sender);
        AuctionClosed=false;
        auctionStartPrice=_auctionStartPrice;
        auctionTime=block.timestamp+_auctionTime;
        emit auctionStarted(auctionOwner,auctionStartPrice);
    } 

    function placeBid() public payable{
        require(msg.value > topBidAmount,"You have placed low bid than top bidder");
        require(auctionTime > block.timestamp,"Auction time ended");
        if(topBid !=0 ){
            pendingReturns[topBidder]=topBid;
        }
        topBidder=msg.sender;
        topBid=msg.value;
        emit bidPlaced(msg.sender,msg.value);
    }

    function cancelAuction() public {
        require(msg.sender == auctionOwner, 'Auction owner can cancel the auction');
        require(block.timestamp <= auctionTime, 'Auction is still in progress so cannot be cancelled');
        AuctionClosed=true;
        emit auctionClosed(topBidder,topBid);
        auctionOwner.transfer(topBid);
    }
    function withDrawBid() public returns(bool){
        require(block.timestamp>=auctionTime);
        uint256 withDrawAmount= pendingReturns[msg.sender];
        if(withDrawAmount>0){
            payable(msg.sender).transfer(withDrawAmount);
            pendingReturns[msg.sender]=0;
            return true;
        }
        return false;
    }

}