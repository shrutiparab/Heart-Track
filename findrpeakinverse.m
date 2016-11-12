function r=findrpeakinverse(ecg,fin)
%a=ecg(fin);
ecg=-1*ecg;
%plot(ecg);
%r=-1;
%fmax=174.7370;
fmax=max(ecg(fin));
flength=10000;
for fi=1:flength
    if(ecg(fi)==fmax)
        fn=fi;
        break;
    end
end
 
dummy=1;
%r=1;
fnnext=fn;
while(dummy<=100)
    %hold on;
       %plot(fn,fmax,'*');
    %fn
    [slopeleft,sloperight]=findslope2(fn,ecg);
    %slopeleft;
    %sloperight;
    if(slopeleft>0)&&(sloperight>0) 
        if(slopeleft>=3) && (sloperight>=3)
            r=fn;
            break;
        end
    end
    fnnext=fnnext+10;
    fnnext2=fnnext+20;
    if(fnnext>=flength)
        fnnext=flength;
    end
    if(fnnext2>=flength)
        fnnext2=flength;
    end
    findex=fnnext:fnnext2;
    fmax=max(ecg(findex));
    for fi=fnnext:fnnext2
        if(ecg(fi)==fmax)
            fn=fi;
            break;
        end
    end
    %originalmax=fmax2
    %plottedmax=a(fn)
    dummy=dummy+1;
end
%if dummy==100 && r==-1
    %r=findrpeakinverse(ecg,fin);
%end
%slopeleft
%sloperight
%return sig;
end
