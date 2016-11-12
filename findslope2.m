function [sl,sr] = findslope2(fs2n,fs2a)    
fs2length=length(fs2a);
fs2nleft=fs2n-5;
fs2nright=fs2n+5;
if(fs2nleft<=1)
    fs2nleft=1;
end
if(fs2nright>=fs2length)
    fs2nright=fs2length;
end 
if(fs2a(fs2n)>0) && (fs2a(fs2nleft)<0)
    fs2nleft=findzeron(fs2a,fs2nleft,fs2n);
end
if(fs2a(fs2n)>0) && (fs2a(fs2nright)<0)
    fs2nleft=findzeron(fs2a,fs2n,fs2nright);
end
%fs2max
%point=fs2a(fs2n)
%pointleft=fs2a(fs2nleft)
%pontright=fs2a(fs2nright)

if(fs2a(fs2nleft)<fs2a(fs2n))&&(fs2a(fs2nright)<fs2a(fs2n))

    sl=abs((fs2a(fs2nleft)-fs2a(fs2n))/(fs2nleft-fs2n));
    sr=abs((fs2a(fs2nright)-fs2a(fs2n))/(fs2nright-fs2n));
    
    
else
    sl=-100;
    sr=-100;
end
end