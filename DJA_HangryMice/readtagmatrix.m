function tagmatrix = readtagmatrix(strings,tag)
    attackstartindex = find(strings==tag)
    attacks = [];
    notatendofattacks = true;
    attackindex = attackstartindex+2;
    while notatendofattacks
        if strings(attackindex)~=""
            attacks = [attacks;split(strings(attackindex))];
            attackindex = attackindex + 1;
        else
            notatendofattacks = false;
        end
    end
    tagmatrix = reshape(str2double(attacks),3,[])';
end