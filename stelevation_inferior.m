function st=stelevation_inferior(rpeakx,rpeaky,signal,isoline)

temp=signal(rpeakx:rpeakx+120);
a=min(temp);
for j=rpeakx:rpeakx+200;
    if signal(j)==a;
        x=j;
        break
    end
end
%hold on;
%plot(x,a,'*');
%st=1;
q=min(signal(1:rpeakx));
if a<0
    st=1;
    for i=x:rpeakx+120;
        if signal(i)>0;
            st=0;
            break;
        end 
    end
    if st==1;
        dummy=x;
        for i=x:rpeakx+200;
            dummy=dummy+1;
            if signal(i+5)-signal(i)<3;
                l=i;
                %hold on;
                %plot(l,signal(i),'*');
                break;
            end
        end
        if dummy==rpeakx+200;
            st=0;
        else
            maximum=max(signal(l:651));
            minimumt=min(signal(l:651));
            if maximum<0 && minimumt<=q
                st=1;
            else
                st=0;
            end
        end
    end
    
else
    st=1;
    for i = 1:120;
        if temp(i)<70;
            st=0;
            break;
        end
    end     
end
end



