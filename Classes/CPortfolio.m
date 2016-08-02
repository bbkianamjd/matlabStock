classdef CPortfolio
    properties
      priceOfTicket = 4.5;
      cash;
      activeTickets;
      pendingTickets;
      todaysDate;
    end  
    
methods   
    function r = CPortfolio(myDate)%consturctor
        r.cash = 0;
        r.activeTickets = 0;
        r.pendingTickets = 0;
        r.todaysDate = myDate;
    end
    %you always need to return the object explicitly
    function [newCash,this] = addCash(this,moreCash)
        this.cash = moreCash;
        newCash = this.cash;
    end
    
    function [this] = changeDate(this,myDate)
       %should check if valid stock date and prevent any dates
        this.todaysDate = myDate;
    end
    
    function [numPendingTickets,this] = createTicketOrder(this,myTicket)
       %need to subtract cash from price of stock
       numPendingTickets = NaN;

       %if a market order - use hist open
       if myTicket.type == 0 %0 for market
           stockPrice = CStockDta.getHistOpen(myTicket.symbol,this.todaysDate);
           
       else if myTicket.type == 1 %1 for limit
       %if a limit order - calculate ticket price
           stockPrice = myTicket.limitPrice;
           end
       end
       
       totalTicketCost = this.priceOfTicket + stockPrice;
       if this.cash<totalTicketCost
           return;
       end
       if myTicket.isValid() ~= 1
           return;
       end
       myTicket.cashReserve = stockPrice;
       myTicket.ticketPrice = this.priceOfTicket;
       
       this.pendingTickets = [this.pendingTickets ; myTicket];
       numPendingTickets = length(this.pendingTickets);
       this.cash = this.cash - totalTicketCost;
    end
    
    function [numPendingTickets,this] = destroyPendingTicket(this,ticketNumber)
        this.pendingTickets(ticketNumber) = []; 
        numPendingTickets = length(this.pendingTickets);
    end
    
    function [numActiveTickets,this] = sellActiveTicket(this,activeTicketNumber)
        histClose = CStockDta.getHistClose(symbl);
        this.cash = this.cash + histClose;
        numActiveTickets = destroyActiveTicket(activeTicketNumber);
    end
    
    function [numActiveTickets,this] = destroyActiveTicket(this,ticketNumber)
        this.activeTickets(ticketNumber) = []; 
        numActiveTickets = length(this.activeTickets);
    end
   
    function [this] = activateTicket(this,pendingTicketNumber,stockPrice)
        myTicket = this.pendingTickets(pendingTicketNumber);
        this.destroyPendingTicket(pendingTicketNumber);
        
        this.cash = this.cash + myTicket.cashReserve;
        this.cash = this.cash - stockPrice*myTicket.quantity;
        
        if this.cash < 0
            this.cash = this.cash + stockPrice*myTicket.quantity;
            return;
        end
        
        %update analytics
        myTicket.buyDate = this.todaysDate;
        myTicket.cashReserve = 0;
        myTicket.basePrice = stockPrice;
        
        this.activeTickets = [this.activeTickets ; myTicket];
    end
    
    function [this] = updateTicketOrders(this)
        indx = 1;
        while indx<length(this.pendingTickets) 
            myTicket = this.pendingTickets(indx);
            
            %check conditions
            switch myTicket.type 
                case 0 %market order
                    this.activateTicket(indx,CStockDta.getHistOpen(myTicket.symbol,this.todaysDate));
                    indx = indx -1;
                case 1 %limit order
                    lowerBound = CStockDta.getHistLow(myTicket.symbol,this.todaysDate);
                    if myTicket.limitPrice > lowerBound 
                        this.activateTicket(indx,myTicket.limitPrice);
                        indx = indx -1;
                    end
            end
            indx=indx+1;
        end
    end
    
    function [totalValue,this] = getAssets(this)
        totalValue = 0;
        for i = 0: length(this.activeTickets)
            symbl = this.activeTickets(i).symbol;
            %TO DO: determine NAN
            totalValue = totalValue + CStockDta.getHistClose(symbl);            
        end
        totalValue = totalValue + this.cash;
    end
    
    
end
    
    
end








