clc
% Read in original RGB image.
rgbImage = imread('14_03_2019 20_00_08_PM.png');
% Extract color channels.
redChannel = rgbImage(:,:,1); % Red channel
greenChannel = rgbImage(:,:,2); % Green channel
blueChannel = rgbImage(:,:,3); % Blue channel

xc=[0  0 1 -1 1  1 -1 -1];
yc=[1 -1 0  0 1 -1  1 -1];



% Get Size of the image
[ht,wd]=size(rgbImage);
visited=zeros(1366);
%{
for i=1:ht
    for j=1:1366
        r=redChannel(i,j);
        g=greenChannel(i,j);
        b=blueChannel(i,j);
        if(r==255 && g==255 && b==255)
            
            for k=1:8
                xx = i+xc(k);
                yy = j+yc(k);
                
                if(xx>0 &&xx<=613 && yy>0 && yy<=1366)
                    rr=redChannel(xx,yy);
                    gg=greenChannel(xx,yy);
                    bb=blueChannel(xx,yy);
                    
                    if(rr==16&&gg==187 && bb==255 && visited(xx,yy)==0)
                        redChannel(i,j)=16;
                        greenChannel(i,j)=187;
                        blueChannel(i,j)=255;
                        visited(i,j)=1;
                        break;
                    end
                    
                end
                
            end
            
        end
    end
end

%}



for i=1:ht
    for j=1:1366
        r=redChannel(i,j);
        g=greenChannel(i,j);
        b=blueChannel(i,j);
        
        
        
        %checking range of rgb of bus-stop signs , light green routes,
        %light orange routes, light gray routes, redish text on the routes,
        %bold text on the routes
        if(((r>=16 && r<=155) && (g>=187 && g<=217) && (b==255))  ||  ((r>=162 && r<=187) && (g>=120 && g<=223) && (b>=133  &&  b<=190))  ||  ((r==255) && (g>=236 && g<=240) && (b>=212 && b<=220))  ||  ((r>=182 && r<=192) && (g>=125 && g<=143) && (b>=125  &&  b<=143))  ||  ((r>=120 && r<=144) && (g>=61 && g<=105) && (b>=6  &&  b<=58))  ||  ((r>=130 && r<=137) && (g>=120 && g<=162) && (b>=130 && b<=165)))
            frq = [0 0 0 0];
            for p=1:2
                
                %right pixel
                if(j+p<=1366)
                    rr=redChannel(i,j+p);
                    gg=greenChannel(i,j+p);
                    bb=blueChannel(i,j+p);
                    
                    if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                        frq(1) = frq(1)+1;
                        
                    elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                        frq(2) = frq(2)+1;
                        
                        
                    elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                        frq(3) = frq(3)+1;
                        
                    elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                        frq(4) = frq(4)+1;
                    end
                end
                %left pixel
                if(j-p>=0)
                    rr=redChannel(i,j-p);
                    gg=greenChannel(i,j-p);
                    bb=blueChannel(i,j-p);
                    
                    if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                        frq(1)=frq(1)+1;
                        
                    elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                        frq(2) = frq(2)+1;
                        
                        
                    elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                        frq(3) = frq(3)+1;
                        
                    elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                        frq(4) = frq(4)+1;
                    end
                end
                
                %upper pixel
                if(i+p<=613)
                    rr=redChannel(i+p,j);
                    gg=greenChannel(i+p,j);
                    bb=blueChannel(i+p,j);
                    
                    if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                        frq(1) = frq(1)+1;
                        
                    elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                        frq(2) = frq(2)+1;
                        
                        
                    elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                        frq(3) = frq(3)+1;
                        
                    elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                        frq(4) = frq(4)+1;
                    end
                end
                
                %lower pixel
                if(i-p>0)
                    rr=redChannel(i-p,j);
                    gg=greenChannel(i-p,j);
                    bb=blueChannel(i-p,j);
                    
                    if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                        frq(1) = frq(1)+1;
                        
                    elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                        frq(2) = frq(2)+1;
                        
                        
                    elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                        frq(3) = frq(3)+1;
                        
                    elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                        frq(4) = frq(4)+1;
                    end
                end
                
                
                %upper right corner
                if(i+p<=613 && j+p<=1366)
                    rr=redChannel(i+p,j+p);
                    gg=greenChannel(i+p,j+p);
                    bb=blueChannel(i+p,j+p);
                    
                    if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                        frq(1) = frq(1)+1;
                        
                    elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                        frq(2) = frq(2)+1;
                        
                        
                    elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                        frq(3) = frq(3)+1;
                        
                    elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                        frq(4) = frq(4)+1;
                    end
                end
                
                
                %upper left corner
                if(i+p<=613 && j-p>=0)
                    rr=redChannel(i+p,j-p);
                    gg=greenChannel(i+p,j-p);
                    bb=blueChannel(i+p,j-p);
                    
                    if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                        frq(1) = frq(1)+1;
                        
                    elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                        frq(2) = frq(2)+1;
                        
                        
                    elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                        frq(3) = frq(3)+1;
                        
                    elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                        frq(4) = frq(4)+1;
                    end
                end
                
                %lower right corner
                if(i-p>0 && j+p<=1366)
                    rr=redChannel(i-p,j+p);
                    gg=greenChannel(i-p,j+p);
                    bb=blueChannel(i-p,j+p);
                    
                    if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                        frq(1) = frq(1)+1;
                        
                    elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                        frq(2) = frq(2)+1;
                        
                        
                    elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                        frq(3) = frq(3)+1;
                        
                    elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                        frq(4) = frq(4)+1;
                    end
                end
                
                %lower left corner
                if(i-p>0 && j-p>0)
                    rr=redChannel(i-p,j-p);
                    gg=greenChannel(i-p,j-p);
                    bb=blueChannel(i-p,j-p);
                    
                    if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                        frq(1) = frq(1)+1;
                        
                    elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                        frq(2) = frq(2)+1;
                        
                        
                    elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                        frq(3) = frq(3)+1;
                        
                    elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                        frq(4) = frq(4)+1;
                    end
                end
                
                
            end
            
            
            %Now checking extra pixels
            
            %Extra pixel 1
            if(i+2<=613 && j+1<=1366)
                rr=redChannel(i+2,j+1);
                gg=greenChannel(i+2,j+1);
                bb=blueChannel(i+2,j+1);
                
                if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                    frq(1) = frq(1)+1;
                    
                elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                    frq(2) = frq(2)+1;
                    
                    
                elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                    frq(3) = frq(3)+1;
                    
                elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                    frq(4) = frq(4)+1;
                end
            end
            
            %Extra pixel 2
            if(i+2<=613 && j-1>0)
                rr=redChannel(i+2,j-1);
                gg=greenChannel(i+2,j-1);
                bb=blueChannel(i+2,j-1);
                
                if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                    frq(1) = frq(1)+1;
                    
                elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                    frq(2) = frq(2)+1;
                    
                    
                elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                    frq(3) = frq(3)+1;
                    
                elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                    frq(4) = frq(4)+1;
                end
            end
            
            
            
            %Extra pixel 3
            if(i-2>0 && j+1<=1366)
                rr=redChannel(i-2,j+1);
                gg=greenChannel(i-2,j+1);
                bb=blueChannel(i-2,j+1);
                
                if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                    frq(1) = frq(1)+1;
                    
                elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                    frq(2) = frq(2)+1;
                    
                    
                elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                    frq(3) = frq(3)+1;
                    
                elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                    frq(4) = frq(4)+1;
                end
            end
            
            
            %Extra pixel 4
            if(i-2>0 && j-1<=1366)
                rr=redChannel(i-2,j-1);
                gg=greenChannel(i-2,j-1);
                bb=blueChannel(i-2,j-1);
                
                if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                    frq(1) = frq(1)+1;
                    
                elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                    frq(2) = frq(2)+1;
                    
                    
                elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                    frq(3) = frq(3)+1;
                    
                elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                    frq(4) = frq(4)+1;
                end
            end
            
            
            %Extra pixel 5
            if(i+1<=613 && j+2<=1366)
                rr=redChannel(i+1,j+2);
                gg=greenChannel(i+1,j+2);
                bb=blueChannel(i+1,j+2);
                
                if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                    frq(1) = frq(1)+1;
                    
                elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                    frq(2) = frq(2)+1;
                    
                    
                elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                    frq(3) = frq(3)+1;
                    
                elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                    frq(4) = frq(4)+1;
                end
            end
            
            %Extra pixel 6
            if(i+1<=613 && j-2>0)
                rr=redChannel(i+1,j-2);
                gg=greenChannel(i+1,j-2);
                bb=blueChannel(i+1,j-2);
                
                if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                    frq(1) = frq(1)+1;
                    
                elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                    frq(2) = frq(2)+1;
                    
                    
                elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                    frq(3) = frq(3)+1;
                    
                elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                    frq(4) = frq(4)+1;
                end
            end
            
            
            
            %Extra pixel 7
            if(i-1>0 && j+2<=1366)
                rr=redChannel(i-1,j+2);
                gg=greenChannel(i-1,j+2);
                bb=blueChannel(i-1,j+2);
                
                if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                    frq(1) = frq(1)+1;
                    
                elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                    frq(2) = frq(2)+1;
                    
                    
                elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                    frq(3) = frq(3)+1;
                    
                elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                    frq(4) = frq(4)+1;
                end
            end
            
            
            %Extra pixel 8
            if(i-1>0 && j-2>0)
                rr=redChannel(i-1,j-2);
                gg=greenChannel(i-1,j-2);
                bb=blueChannel(i-1,j-2);
                
                if((rr>=99 && rr<=156) && (gg>=214 && gg<=235) && (bb>=104 && bb<=160))
                    frq(1) = frq(1)+1;
                    
                elseif(((rr==255) && (gg>=151 && gg<=229) && (bb>=77 && bb<=211)))
                    frq(2) = frq(2)+1;
                    
                    
                elseif(((rr>=231 && rr<=248) && (gg>=60 && gg<=170) && (bb>=50 && bb<=167)))
                    frq(3) = frq(3)+1;
                    
                elseif(((rr>=129 && rr<=170) && (gg>=31 && gg<=100) && (bb>=31 && bb<=100)))
                    frq(4) = frq(4)+1;
                end
            end
            
            
            [maxVal, index] = max(frq);
            %{
            if(maxVal==0)
                redChannel(i,j)=0;
                greenChannel(i,j)=0;
                blueChannel(i,j)=0;
            %}
            if(index==1)
                redChannel(i,j)=99;
                greenChannel(i,j)=214;
                blueChannel(i,j)=104;
            elseif(index==2)
                redChannel(i,j)=255;
                greenChannel(i,j)=151;
                blueChannel(i,j)=77;
            elseif(index==3)
                redChannel(i,j)=242;
                greenChannel(i,j)=60;
                blueChannel(i,j)=50;
            elseif(index==4)
                redChannel(i,j)=129;
                greenChannel(i,j)=31;
                blueChannel(i,j)=31;
                
            end
            
            
            
            %checking range of rgb of GREEN colored roads and setting exact rgb
            %values to corresponding channel
        elseif((r>=99 && r<=156) && (g>=214 && g<=235) && (b>=104 && b<=160))
            
            redChannel(i,j)=99;
            greenChannel(i,j)=214;
            blueChannel(i,j)=104;
            
            %checking range of rgb of ORANGE colored roads and setting exact rgb
            %values to corresponding channel
        elseif(((r==255) && (g>=151 && g<=229) && (b>=77 && b<=211)))
            
            redChannel(i,j)=255;
            greenChannel(i,j)=151;
            blueChannel(i,j)=77;
            
            
            %checking range of rgb of RED colored roads and setting exact rgb
            %values to corresponding channel
        elseif(((r>=231 && r<=248) && (g>=60 && g<=170) && (b>=50 && b<=167)))
            redChannel(i,j)=242;
            greenChannel(i,j)=60;
            blueChannel(i,j)=50;
            
            %checking range of rgb of GRAY colored roads and setting exact rgb
            %values to corresponding channel
        elseif(((r>=129 && r<=170) && (g>=31 && g<=100) && (b>=31 && b<=100)))
            redChannel(i,j)=129;
            greenChannel(i,j)=31;
            blueChannel(i,j)=31;
            
            %Otherwise black
            
        else
            redChannel(i,j)=0;
            greenChannel(i,j)=0;
            blueChannel(i,j)=0;
            
            
        end
        
        
        
        
    end
end


















% Recombine the individual color channels to create the original RGB image again.
recombinedRGBImage = cat(3, redChannel, greenChannel, blueChannel);
imshow(recombinedRGBImage);
%Creating a copy of output image, you need to change the path according to
%your workspace in you PC
imwrite(recombinedRGBImage,'D:\4-2 4-2 4-2\Thesis Works\Route Data collection\14_03_2019 20_00_08_PM_routeRecoveryBusStopUpdated22.png');
%}
