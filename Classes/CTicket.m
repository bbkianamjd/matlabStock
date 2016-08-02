%should have everything needed to calculate the percentage gain
%from an analysis class
classdef CTicket
   properties
      symbol;
      quantity;

      %conditions
      type;%i.e market 0 | limit 1 | 
      limitPrice;%limit order
      sellCondition;
      stopCondition;%
      buyCondition;%
      
      %logistics
      cashReserve;%the cash reserved during pending
      ticketPrice;%the money charged by the broker to create the ticket order
      
      %analytics
      basePrice;%the price at buying
      ticketDate;%the date at making the ticket
      buyDate;%the date when the conditions were triggered
      
      sellPrice;
      sellDate;
   end
   
methods (Static)
    function r = createBuyMarketOrder(symbl)
       r = CTicket(symbl);
       r.type = 0;
    end
    function r = createBuyLimitOrder(symbl,myLimit)
       r = CTicket(symbl);
       r.type = 1;
       r.limitPrice = myLimit;
    end
    
end
   
methods
    function r = CTicket(symbl)
        r.symbol = symbl;
        r.basePrice = NaN;
        r.ticketDate = NaN;
        r.sellCondition = NaN;
        r.stopCondition = NaN;
        r.buyCondition = NaN;
        r.type = NaN;
    end
    
    function val = isValidTicket(this)
        %check symbol
        %check if has at least a few things
        val = 1;
    end
    
    
end
end