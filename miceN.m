%parameters
n=8;
d=0.01;
alpha=pi;

%init vectors with coordinates of the polygon
x=zeros(1,n);
y=x;

for i = 1:n
  fi=alpha+2*(i-1)*pi/n; %change angle for the next vertex
  x(i)= -sin(fi); %initial x coordinates
  y(i)= cos(fi);  %initial y coordinates
end
    
%draw polygon
shapex=x(1:n);
shapex(n+1)=x(1);

shapey=y(1:n);
shapey(n+1)=y(1);

plot(shapex,shapey)
hold on %hold plot for the future n curves
    
fileID = fopen('mice.txt','w'); %file for the all points saving 

while (y(2)-y(1))^2 + (x(2)-x(1))^2 > d*d %loop breaks when the distance reaches d
   for i = 1:n		 
         fprintf(fileID,'%f %f\n', x(i), y(i)); %printing to the txt file
    end
   for i = 1:n
        ind=mod(i, n)+1;
        denom=sqrt((x(ind)-x(i))^2+(y(ind)-y(i))^2);
        x(i)=x(i)+0.01*(x(ind)-x(i)/denom); %new position of x in the direction of the neighboring mouse
        y(i)=y(i)+0.01*(y(ind)-y(i)/denom); %new position of y in the direction of the neighboring mouse
   end
end
	
 fclose(fileID);%closing the txt file

%extract 2 vectors from the file
data=dlmread('mice.txt');
x=data(:,1);
y=data(:,2);

l=length(x);

for j=n:n:l %from short curve (1 point) to long curve (l/n points)
    for i = 1:n	%for each vertex
       %extract and draw the curve for the vertex #i
       indexes = i:n:j;
       curvex = x(indexes);
       curvey = y(indexes);
       plot(curvex,curvey)
    end
    pause(0.01) %for animation
end

hold off