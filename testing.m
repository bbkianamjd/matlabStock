clc
clear

addpath(strcat(pwd,'\Classes\'));
%this.years = [2011,2012];
%date1 = '1/1/12';

test = CStockDta('aapl');
% x = test.getYear('2011');
% [x,test] = test.getYear('2008');
% x = test.getDay('1/4/2011');
% myData = CData(x);
% price = myData.getPrice('1/4/2011');

optHouse = CPortfolio('1/1/2011');
% opt = opt.addCash(200);
[newCash,optHouse] = optHouse.addCash(2000);
% myTicket = CTicket('aapl','market','buy');
myTicket = CTicket.createBuyMarketOrder('aapl');%buy order
myTicket2 = CTicket.createBuyLimitOrder('aapl',20);%limit order


[numberOfTickets,optHouse] = optHouse.createTicketOrder(myTicket);


% myTicket = CTicket('P');
% [numberOfTickets,opt] = opt.createTicket(myTicket);
% myTicket = CTicket('aapl');
% [numberOfTickets,opt] = opt.createTicket(myTicket);
% 
% 
% 






