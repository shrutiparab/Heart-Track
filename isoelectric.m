function iso=isoelectric(newpass,length2)
for fi2=1:length2
    isoslope=abs(newpass(fi2+20))-abs(newpass(fi2));
    if(isoslope>30)
       %flag=1;
       flagpos=fi2;
       h=newpass(flagpos);
        break;
    end
    
    if(isoslope<-30)
       %flag=2;
       flagpos=fi2;
       h=newpass(flagpos);
       break;
    end
end
iso=h;
     
       
       





