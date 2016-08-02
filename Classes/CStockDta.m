classdef CStockDta
   properties
      symbol;%in the constructor
      years;%in the text file
      path;
   end

   methods (Static)%has to be called with predicate r.
       %histDate histOpen histHigh histLow histClose histVol
       function histClose = getHistClose(symbl,myDate)
        r = CStockDta(symbl);
        [data] = r.getDay(myDate);
        histClose = data(5);
       end
       function histOpen = getHistOpen(symbl,myDate)
        r = CStockDta(symbl);
        [data] = r.getDay(myDate);
        histOpen = data(2);           
       end
       function histLow = getHistLow(symbl,myDate)
        r = CStockDta(symbl);
        [data] = r.getDay(myDate);
        histLow = data(4);             
       end
       function histHigh = getHistHigh(symbl,myDate)
        r = CStockDta(symbl);
        [data] = r.getDay(myDate);
        histHigh = data(3);         
       end
       function getLastHistClose(symbl,myDate)
           
       end
   end   
   
   methods %always going to pass this to function calls
       %and return this to function calls
    function r = CStockDta(symbl)%consturctor
        r.symbol = symbl;
        r = loadProperties(r);
    end   
    
    
    function this = loadProperties(this)
        str1 = 'C:\Users\Bobby\Desktop\stock market\database\stocks\';
        this.path = strcat(str1,this.symbol);
        filePath = strcat(this.path,'\properties.txt');
        try
            num = csvread(filePath);
        catch%create folder
            mkdir(this.path)
            year = [0];
            csvwrite(filePath,year);
            num = csvread(filePath);
        end
        this.years = num;
    end
    
    %you can call these method without explicitly stating this
    %this has to be returned always if chanegd
    function [data,this] = getDay(this,date1)
        data = NaN;
        str = strcat(this.path,'\',num2str(year(date1)),'.txt');
        %checkDate
        if(this.checkDate(date1)==0)            
        %read xlsx file
            try
               downloadYear(year(date1),str,this.symbol);
               this.years = [this.years;year(date1)];
               this.updateProperites();
            catch
                return;
            end
        end
        A = csvread(str);
        indx = find(datenum(date1)==A(:,1));
        %extract value
        if isempty(indx)
            return
        end
            data = A(indx,:);
    end
    
    function [data,this] = getYear(this,myYear)
       data = NaN;
       str = strcat(this.path,'\',myYear,'.txt');
       if(this.checkDate(strcat('1/1/',myYear))==0)
           try
               downloadYear(myYear,str,this.symbol);
               this.years = [this.years;str2num(myYear)];
               this.updateProperites();
            catch
                return;
           end
       end
       data = csvread(str);
    end
    
    function updateProperites(this)
        filePath = strcat(this.path,'\properties.txt');
        x = this.years;
        csvwrite(filePath,x);
    end
    
    function val = checkDate(this,myDate)
        indx = find(this.years==year(myDate));
        if(isempty(indx))
            val = 0;
        else
            val = 1;
        end
    end
    


    
   end
         

   
end



