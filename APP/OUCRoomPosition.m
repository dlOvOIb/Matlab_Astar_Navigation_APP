function position=OUCRoomPosition(Room)
%坐标转换函数，将输入内容转化为对应坐标
area=floor(Room/1000);
room=mod(Room,100);
%此处坐标对应的是数组中的行列坐标，而不是坐标系中的XY

switch area
    case 8
        row=4;col=13;
    case 7
        if room>10
           row=7;col=15;
        else 
           row=8;col=10;
        end
    case 6
         if room>10
            row=13;col=15;
         else
            row=15;col=8;
         end

    case 5
        if  room>6
            row=20;col=10;
        else
            row=22;col=6;
        end

    case 4
        if room<=2
            row=29;col=34;
        else
            row=28;col=24;
        end
    case 3
        if room<8
            row=35;col=28;
        else
            row=36;col=19;
        end
    case 0
        if room==0
            row=37;col=37;
        elseif room==1
            row=32;col=5;
        end
    otherwise
        position=NaN;
        return;
end
position=[row,col];

