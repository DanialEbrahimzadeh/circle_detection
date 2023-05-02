function res = fitness(pop,v,a)
temp1=((pop(3)^2)+(pop(4)^2))-((pop(1)^2)+(pop(2)^2));
temp3=((pop(5)^2)+(pop(6)^2))-((pop(1)^2)+(pop(2)^2));
temp2=2*(pop(4)-pop(2));
temp4=2*(pop(6)-pop(2));
mat_temp=[temp1 temp2;temp3 temp4];
det1=det(mat_temp);
temp5=4*(((pop(3)-pop(1))*(pop(6)-pop(2)))-((pop(5)-pop(1))*(pop(4)-pop(2))));
x0=det1/temp5;

temp3=((pop(3)^2)+(pop(4)^2))-((pop(1)^2)+(pop(2)^2));
temp4=((pop(5)^2)+(pop(6)^2))-((pop(1)^2)+(pop(2)^2));
temp1=2*(pop(3)-pop(1));
temp2=2*(pop(5)-pop(1));
mat_temp=[temp1 temp3;temp2 temp4];
det1=det(mat_temp);
y0=det1/temp5;


r=sqrt(((pop(1)-x0)^2)+((pop(2)-y0)^2));
data=[];
ns=250;
for j=1:ns;
    data(1,j)=round(x0+r*cos(2*pi*j/ns));
    if data(1,j)<=0;
        data(1,j)=1;
    end
    data(2,j)=round(y0+r*sin(2*pi*j/ns));
    if data(2,j)<=0;
        data(2,j)=1;
    end
end
res1=0;
for j=1:ns;
    for jj=1:size(v,2);
        if data(1,j)<=size(a,1) && data(2,j)<=size(a,2);
        if data(1,j) == v(1,jj) && data(2,j) == v(2,jj);
            res1=res1+1;
        end
        end
    end
end
res1=res1/ns;
r1=30;
f1=1;
if r<r1;
    f1=r/r1;
end
res=res1*f1;
end