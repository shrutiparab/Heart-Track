function st=stelevation_anterior(rpeakx,rpeaky,signal,isoline)

temp=signal(rpeakx:rpeakx+120);
stminimum=min(temp);
for sti=rpeakx:651
    if(signal(sti)==stminimum)
        stx=sti;
        break;
    end
end


xintersect=0;
if(stminimum<isoline)
    for stj=stx:rpeakx+120
        if(signal(stj)<0 && signal(stj+1)>=0)
            if(abs(signal(stj))<abs(signal(stj+1)))
            xintersect=stj;
            else
            xintersect=stj+1;
            end
             %xintersect
             %plot(xintersect,isoline,'*');
             break;
        end;
        end;
             %h=signal(xintersect);
        %h
        %flag=0;
       
            if(signal(xintersect+30)>220)
             %flag=signal(xintersect+30);
             st=1;
             %flag
             %hold on;
             %plot((xintersect+30),flag,'*');
            else st=0;
             
            end;
           
        
           
        %end
       
       % 
        %hold on;
        %plot(xintersect,isoline,'*');
    %end
   if(xintersect==0)
       st=0;
    
  end


else
    st=1;
    for i = 1:120;
        if temp(i)<70;
            st=0;
            break;
        end
    end
% st=1;   
end  
end



