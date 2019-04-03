clc;

xc=[0  0 1 -1 1  1 -1 -1];
yc=[1 -1 0  0 1 -1  1 -1];



%impixelinfo
jointX=[279 283 295 516 102 110 115 231 235 206 197 365 514 516 487 370 374 426 428 411 411 404 406];
jointY=[618 620 616 451 737 738 593 605 607 768 735 634 455 451 492 556 556 738 741 646 651 1195 1191];

img=imread('14_03_2019 20_00_08_PM_routeRecoverylatest.png');
redChannel = img(:,:,1); % Red channel
greenChannel = img(:,:,2); % Green channel
blueChannel = img(:,:,3); % Blue channel


for p=1:length(jointX)

xCntr=jointX(p);
yCntr=jointY(p);
radius=25;
[xx, yy] = getCirclePoints(xCntr, yCntr, radius);




len = length(xx);



cnt=0;
roadsX=[];
roadsY=[];
i=1;
while (i<=len)
        
        x=xx(i);
        y=yy(i);
        
        %circle er center er double element gulo ke soriye deyar kaj
        isDouble=0;
        for j=1:(i-1)
            if(x==xx(j)&&y==yy(j))
                isDouble=1;
                break;
            end
        end
        if(isDouble==1) 
            i=i+1;
            continue;
        end
                
        
        r=redChannel(x,y);
        g=greenChannel(x,y);
        b=blueChannel(x,y);
        
     if(r~=0 && g~=0 && b~=0)
         
        
       
         cnt = cnt+1;
         roadsX(cnt)=x;
         roadsY(cnt)=y;
         
     
        
        
        
        
        while ((r~=0 && g~=0 && b~=0)&&(i<=len))
            
            
             x=xx(i);
             y=yy(i);
             
              r=redChannel(x,y);
              g=greenChannel(x,y);
              b=blueChannel(x,y);
            
              i = i+1;
        end
        
     
     end
        
     i=i+1;
end


routeNo=0;

fileID = fopen('D:\4-2 4-2 4-2\Thesis Works\Route Data collection\dataPoints.txt','a');
fprintf(fileID,'Information of intersection (%d, %d):\r\n',xCntr, yCntr);
fclose(fileID);

for j=1:length(roadsX)
    

routeX=[];
routeY=[];
index=1;
routeX(index)=roadsX(j);
routeY(index)=roadsY(j);
    xnow=roadsX(j);
    ynow=roadsY(j);

gotCenter=0;

while 1
    min=999999999;
    distToCenter=(xnow-xCntr)*(xnow-xCntr)+(ynow-yCntr)*(ynow-yCntr);
   
    for i=1:8
        xn = xnow+xc(i);
        yn = ynow+yc(i);
        rr = (xn-xCntr)*(xn-xCntr)+(yn-yCntr)*(yn-yCntr);
        
        r=redChannel(xn,yn);
        g=greenChannel(xn,yn);
        b=blueChannel(xn,yn);
        
        if((rr<distToCenter && (r~=0 && g~=0 && b~=0) && rr<=min) ||(xn==xCntr && yn==yCntr))
            min = rr; 
            
            xTmp = xn;
            yTmp=yn;
            
            
            
        end
    
    end
    
    
    if(xTmp==xCntr && yTmp==yCntr)
        index=index+1;
        xnow=xTmp;
        ynow=yTmp;
        routeX(index)=xnow;
        routeY(index)=ynow;
        gotCenter = 1;
        break;
    elseif(min==999999999)
        break;
    else
        index=index+1;
        xnow=xTmp;
        ynow=yTmp;
        routeX(index)=xnow;
        routeY(index)=ynow;
    end
        

end





if(gotCenter==1)
    
    routeNo = routeNo+1;
    
    A = [routeX; routeY];


    fileID = fopen('D:\4-2 4-2 4-2\Thesis Works\Route Data collection\dataPoints.txt','a');
    
    fprintf(fileID,'Coordinates of route no %d:\r\n',routeNo);

    fprintf(fileID,'%6s %12s\r\n','X value','Y value');

    fprintf(fileID,'%6d %12d\r\n',A);

    fclose(fileID);
    
    for i=1: length(routeX)
        xn = routeX(i);
        yn = routeY(i);
        redChannel(xn,yn)=0;
        greenChannel(xn,yn)=0;
        blueChannel(xn,yn)=255;
    end
end


end

end



recombinedRGBImage = cat(3, redChannel, greenChannel, blueChannel);

%Creating a copy of output image, you need to change the path according to
%your workspace in you PC
imwrite(recombinedRGBImage,'D:\4-2 4-2 4-2\Thesis Works\Route Data collection\14_03_2019 20_00_08_PM_routeDataFor23points.png');

imshow(recombinedRGBImage);
impixelinfo




function [xx, yy] = getCirclePoints(x_centre, y_centre, r)
	x=0;
    y=r;
    pk=1-r;
    index=0;
    while x<=y
        index = index+1;
        xx(index)=x;
        yy(index)=y;
        xPrev=x;
        yPrev=y;
        x=x+1;
        
        if pk>=0
            
            y=y-1; 
            
        end
        
        pk=pk+2*(xPrev+1)+(y*y-yPrev*yPrev)-(y-yPrev)+1;
    end
    
    ultaX=yy;
    ultaY=xx;
    
    xx=[xx flip(ultaX)];
    yy=[yy flip(ultaY)];
    xx=[xx (-1).*xx (-1).*xx xx]+x_centre;
    yy=[yy yy (-1).*yy (-1).*yy]+y_centre;


end

