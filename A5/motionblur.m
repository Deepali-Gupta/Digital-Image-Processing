function h=motionblur(dirangle,winsize)

h=zeros(winsize); % FIR window
ext=(winsize-1)/2;
% now approximate motion blur with a direction 
% specified in terms of angle (degrees)
if (abs(abs(dirangle)-90) >=45) & (abs(abs(dirangle)-270)>=45),
   slope=tan(dirangle*pi/180); 
   rloc=round(slope*[-ext:ext]);
   for i=1:winsize,
     h(ext-rloc(i)+1,i)=1;
  end
else % if dirangle between 45 and 135, and 225 to 315
   % work from the y axis
   slope=cot(dirangle*pi/180);
   cloc=round(slope*[-ext:ext]);
   for i=1:winsize,
      h(i,ext-cloc(i)+1)=1;
   end
end