bufferForward=50;%Packets forwarded each tick
bufferSizeTotal=500;
%Initial conditions
N=3;% # of src
windowSize1=1;
windowSize2=1;
windowSize3=1;
src1Flag=0;
src2Flag=0;
src3Flag=0;
bufferSize=bufferSizeTotal;
t=0;
Z=0;
packetsLost=0;
jcounter=1;
buffer=zeros(1,200);%Ensure there are zeros in the buffer for later checks



while(1) %Infinite loop
       r=randi(3,1);%Generate random number between 1 and 3
       if(r==1)%Randomly choose which order the sources send in (generates an array of windowSizeX numbers where the numbers signify which source sent it)
           buffer=[sources(windowSize1,1) buffer];%Adds the generated array to the buffer before the current buffer values
           r=randi(2,1);
           if(r==1)
               buffer=[sources(windowSize2,2) buffer]; 
               buffer=[sources(windowSize3,3) buffer];
           else
               buffer=[sources(windowSize3,3) buffer];
               buffer=[sources(windowSize2,2) buffer];
           end
       elseif (r==2)
              buffer=[sources(windowSize2,2) buffer]; 
              r=randi(2,1);
           if(r==1)
               buffer=[sources(windowSize1,1) buffer]; 
               buffer=[sources(windowSize3,3) buffer];
           else
               buffer=[sources(windowSize3,3) buffer];
               buffer=[sources(windowSize1,1) buffer];
           end
             
       else
           buffer=[sources(windowSize3,3) buffer];
           r=randi(2,1);
            if(r==1)
               buffer=[sources(windowSize1,1) buffer]; 
               buffer=[sources(windowSize2,2) buffer];
           else
               buffer=[sources(windowSize2,2) buffer];
               buffer=[sources(windowSize1,1) buffer];
           end
       end 
       
       
   
   W=windowSize1+windowSize2+windowSize3;
   R = W/1; %each time corresponds to 1 sec
   X = bufferSizeTotal;
   C=bufferForward;
   jcc=X*(R/W)*(1/(R-C));
   k=floor(jcc)+1;
   PPC=(k*W*(1+k))/2;
   Z=k*(W/R)*(R-C)-X;
   
   a=find(buffer==0);%Find the locations of all the zeros in buffer
   bufferSize=bufferSizeTotal-a(1)+1;%use the location of the first zero to calculate the buffer size%counts how many extra packets if less than zero
   ufferSize<0)%If the buffer is less than zero - packet loss has occured   
      
       packetsLost=-bufferSize+packetsLost;
       %Z=-bufferSize;
       for i=(a(1)-bufferSizeTotal-1):-1:1;%Go through the dropped packets and half the window size for whichever sources had a dropped packet
       if(buffer(i)==1 && src1Flag==0)%srcXFlag ensures window size only halved once for source X
           windowSize1=floor(windowSize1/2);
           src1Flag=1;
       elseif (buffer(i)==2 && src2Flag==
   if(b0) 
           windowSize2=floor(windowSize2/2);
           src2Flag=1;
       elseif(buffer(i)==3 && src3Flag==0)  
           windowSize3=floor(windowSize3/2);
           src3Flag=1;
       end 
    end   
    buffer=buffer((a(1)-bufferSizeTotal):a(1));%Drop the packets and leave 1 zero %%all the packets outside the buffer has been dropped
   else
       jcounter=jcounter+1; % makes it one if a packet drop happen 
   end
    if(src1Flag==0)%If no packets dropped in src X increase windowSizeX
        windowSize1=windowSize1+1; %randi(5,1); add a rand value between 5 and 1
    end
    if(src2Flag==0)
        windowSize2=windowSize2+1;
    end
    if(src3Flag==0) 
        windowSize3=windowSize3+1;
    end
    PLP=max(0,Z/PPC);
    %Reset flags for next iteration 
    src1Flag=0;
    src2Flag=0;
    src3Flag=0;
    
    buffer= buffer(buffer~=0);%removes zeros to ensure array doesnt get too large
    buffer=[buffer zeros(1,200)];%Adds 200 zeros
    
    
    
    
    b=find(buffer==0);%Find the locations of all the zeros in buffer
    bufferSize1=bufferSizeTotal-b(1)+1;%use the location of the first zero to calculate the buffer size
    
    
    
    if(bufferSize1>500-bufferForward-1)%All packets to be forwarded - buffer will only be zeros
        buffer=buffer(buffer==0);
    else
        for j=(500-bufferSize1-bufferForward+1): b(1) %Forward 50 packets, leaving the non forwarded in buffer
            buffer(j)=0;
        end
    end
    buffer=0;
     c=find(buffer==0);%Find the locations of all the zeros in buffer
    bufferSize2=bufferSizeTotal;%use the location of the first zero to calculate the buff
    
    %Plot bufferSize and windowSizes
    subplot(3,1,1)
    stem(t,bufferSize)
    hold on
    subplot(3,1,2)
    stem(t,windowSize1,'r')
    hold on
    stem(t,windowSize2,'g')
    hold on
    stem(t,windowSize3,'b')
    hold on
    legend('W1','W2','W3')
    subplot(3,1,3)
    stem (t, PLP)
    hold on
    t=t+1;%Increment time
    
    
    
   pause(1)%Wait for 1 second
end

