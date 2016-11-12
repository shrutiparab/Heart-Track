function fzn = findzeron(fza,fzl,fzr)
fzn=1;
for fzi=fzl:fzr
    if(fza(fzi)==0)
        fzn=fzi;
        break;
    end
end