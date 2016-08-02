classdef CData
   properties
      histDate;
      histOpen;
      histHigh;
      histLow;
      histClose;
      histVol;
   end
methods   
    function r = CData(data)%consturctor
        r.histDate = data(:,1);
        r.histOpen = data(:,2);
        r.histHigh = data(:,3);
        r.histLow = data(:,4);
        r.histClose = data(:,5);
        r.histVol = data(:,6);        
    end
    
    function priceStruct = getPrice(this,myDateStr)
        priceStruct = NaN;
        indx = find(this.histDate==datenum(myDateStr));
        if(indx>0)
            priceStruct.histDate = this.histDate(indx);
            priceStruct.histOpen = this.histOpen(indx);
            priceStruct.histHigh = this.histHigh(indx);
            priceStruct.histLow = this.histLow(indx);
            priceStruct.histClose = this.histClose(indx);
            priceStruct.histVol = this.histVol(indx);
        end
    end
    
end

end