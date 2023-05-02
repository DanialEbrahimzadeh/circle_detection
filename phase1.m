clc
clear all
close all

a=imread('image5.png');
a=a(:,:,1);
imshow(a,[]);
% a1=rgb2gray(a);
% figure;
% imshow(a1);
a_edge=edge(a,'sobel');
figure;
imshow(a_edge);
v=[];
k=1;
for i=1:size(a_edge,1);
    for j=1:size(a_edge,2);
        if a_edge(i,j)==1;
            v(1,k)=i;
            v(2,k)=j;
            k=k+1;
        end
    end
end

pop=[];
for i=1:70;
    rnd=randi(size(v,2));
    pop(i,1)=v(1,rnd);
    pop(i,2)=v(2,rnd);
    rnd=randi(size(v,2));
    pop(i,3)=v(1,rnd);
    pop(i,4)=v(2,rnd);
    rnd=randi(size(v,2));
    pop(i,5)=v(1,rnd);
    pop(i,6)=v(2,rnd);
end
for epoch=1:50;
fit=[];
for i=1:70;
    fit(i)=fitness(pop(i,:),v,a);
end
sum_fit=sum(fit);
prob=[];
temp=(fit(1)*1000)/sum_fit;
prob(1)=temp;
for i=2:70;
    temp=(fit(i)*1000)/sum_fit;
    prob(i)=prob(i-1)+temp;
end
i=1;
newpop=[];
while i<=70;
    rnd1=1000*unifrnd(0,1);
    rnd2=1000*unifrnd(0,1);
    ind1=1;
    ind2=1;
    while rnd1>prob(ind1);
        ind1=ind1+1;
    end
    while rnd2>prob(ind2);
        ind2=ind2+1;
    end
    cross_prob=100*unifrnd(0,1);
    data1=pop(ind1,:);
    data2=pop(ind2,:);
    if cross_prob <=70;
        cross_point=randi(1,5);
        for j=cross_point+1:6;
            temp=data1(j);
            data1(j)=data2(j);
            data2(j)=temp;
        end
    end
    min_size=min(size(a,1),size(a,2));
    mut1_prob=100*unifrnd(0,1);
    if mut1_prob <=20;
        mut_point=randi(1,6);
        data1(mut_point)=min_size-data1(mut_point);
    end
    mut2_prob=100*unifrnd(0,1);
    if mut2_prob <=20;
        mut_point=randi(1,6);
        data2(mut_point)=min_size-data2(mut_point);
    end
    new_pop(i,:)=data1;
    i=i+1;
    new_pop(i,:)=data2;
    i=i+1;
end

pop2=[pop;new_pop];
fit2=[];
for i=1:140;
    fit2(i)=fitness(pop2(i,:),v,a);
end
sum_fit2=sum(fit2);
prob2=[];
temp=(fit2(1)*1000)/sum_fit2;
prob2(1)=temp;
for i=2:140;
    temp=(fit2(i)*1000)/sum_fit2;
    prob2(i)=prob2(i-1)+temp;
end
newpop2=[];
[max_fit,max_ind]=max(fit2);
newpop2(1,:)=pop2(max_ind,:);
fit2(max_ind)=-1000;
[max_fit2,max_ind2]=max(fit2);
newpop2(2,:)=pop2(max_ind2,:);
fit2(max_ind)=max_fit;



newpop=[];
for i=3:70;
    rnd1=1000*unifrnd(0,1);
    ind1=1;
    while rnd1>prob2(ind1);
        ind1=ind1+1;
    end
    
    newpop2(i,:)=pop2(ind1,:);
    pop=newpop2;
end
    
end
[max_fit,max_ind]=max(fit2);
max_data=pop2(max_ind,:);


temp1=((max_data(3)^2)+(max_data(4)^2))-((max_data(1)^2)+(max_data(2)^2));
temp3=((max_data(5)^2)+(max_data(6)^2))-((max_data(1)^2)+(max_data(2)^2));
temp2=2*(max_data(4)-max_data(2));
temp4=2*(max_data(6)-max_data(2));
mat_temp=[temp1 temp2;temp3 temp4];
det1=det(mat_temp);
temp5=4*(((max_data(3)-max_data(1))*(max_data(6)-max_data(2)))-((max_data(5)-max_data(1))*(max_data(4)-max_data(2))));
x0=det1/temp5;

temp3=((max_data(3)^2)+(max_data(4)^2))-((max_data(1)^2)+(max_data(2)^2));
temp4=((max_data(5)^2)+(max_data(6)^2))-((max_data(1)^2)+(max_data(2)^2));
temp1=2*(max_data(3)-max_data(1));
temp2=2*(max_data(5)-max_data(1));
mat_temp=[temp1 temp3;temp2 temp4];
det1=det(mat_temp);
y0=det1/temp5;


r=sqrt(((max_data(1)-x0)^2)+((max_data(2)-y0)^2));
r=r+2;
data_res=[];
ns=500;
for j=1:ns;
    data_res(1,j)=round(x0+r*cos(2*pi*j/ns));
    if data_res(1,j)<=0;
        data_res(1,j)=1;
    end
    data_res(2,j)=round(y0+r*sin(2*pi*j/ns));
    if data_res(2,j)<=0;
        data_res(2,j)=1;
    end
end
result=a;
for i=1:ns;
    if data_res(1,i)<=size(a,1) && data_res(2,i)<=size(a,2);
        result(data_res(1,i),data_res(2,i))=40;
    end
end
fit2(max_ind)=-10;


% [max_fit,max_ind]=max(fit);
%max_data=pop(25,:);

[max_fit,max_ind]=max(fit2);
max_data=pop2(max_ind,:);


temp1=((max_data(3)^2)+(max_data(4)^2))-((max_data(1)^2)+(max_data(2)^2));
temp3=((max_data(5)^2)+(max_data(6)^2))-((max_data(1)^2)+(max_data(2)^2));
temp2=2*(max_data(4)-max_data(2));
temp4=2*(max_data(6)-max_data(2));
mat_temp=[temp1 temp2;temp3 temp4];
det1=det(mat_temp);
temp5=4*(((max_data(3)-max_data(1))*(max_data(6)-max_data(2)))-((max_data(5)-max_data(1))*(max_data(4)-max_data(2))));
x0=det1/temp5;

temp3=((max_data(3)^2)+(max_data(4)^2))-((max_data(1)^2)+(max_data(2)^2));
temp4=((max_data(5)^2)+(max_data(6)^2))-((max_data(1)^2)+(max_data(2)^2));
temp1=2*(max_data(3)-max_data(1));
temp2=2*(max_data(5)-max_data(1));
mat_temp=[temp1 temp3;temp2 temp4];
det1=det(mat_temp);
y0=det1/temp5;


r=sqrt(((max_data(1)-x0)^2)+((max_data(2)-y0)^2));
r=r+4;
data_res=[];
ns=500;
for j=1:ns;
    data_res(1,j)=round(x0+r*cos(2*pi*j/ns));
    if data_res(1,j)<=0;
        data_res(1,j)=1;
    end
    data_res(2,j)=round(y0+r*sin(2*pi*j/ns));
    if data_res(2,j)<=0;
        data_res(2,j)=1;
    end
end
for i=1:ns;
    if data_res(1,i)<=size(a,1) && data_res(2,i)<=size(a,2);
        result(data_res(1,i),data_res(2,i))=30;
    end
end

fit2(max_ind)=-10;


[max_fit,max_ind]=max(fit2);
max_data=pop2(max_ind,:);


temp1=((max_data(3)^2)+(max_data(4)^2))-((max_data(1)^2)+(max_data(2)^2));
temp3=((max_data(5)^2)+(max_data(6)^2))-((max_data(1)^2)+(max_data(2)^2));
temp2=2*(max_data(4)-max_data(2));
temp4=2*(max_data(6)-max_data(2));
mat_temp=[temp1 temp2;temp3 temp4];
det1=det(mat_temp);
temp5=4*(((max_data(3)-max_data(1))*(max_data(6)-max_data(2)))-((max_data(5)-max_data(1))*(max_data(4)-max_data(2))));
x0=det1/temp5;

temp3=((max_data(3)^2)+(max_data(4)^2))-((max_data(1)^2)+(max_data(2)^2));
temp4=((max_data(5)^2)+(max_data(6)^2))-((max_data(1)^2)+(max_data(2)^2));
temp1=2*(max_data(3)-max_data(1));
temp2=2*(max_data(5)-max_data(1));
mat_temp=[temp1 temp3;temp2 temp4];
det1=det(mat_temp);
y0=det1/temp5;


r=sqrt(((max_data(1)-x0)^2)+((max_data(2)-y0)^2));
r=r+6;
data_res=[];
ns=500;
for j=1:ns;
    data_res(1,j)=round(x0+r*cos(2*pi*j/ns));
    if data_res(1,j)<=0;
        data_res(1,j)=1;
    end
    data_res(2,j)=round(y0+r*sin(2*pi*j/ns));
    if data_res(2,j)<=0;
        data_res(2,j)=1;
    end
end

for i=1:ns;
    if data_res(1,i)<=size(a,1) && data_res(2,i)<=size(a,2);
        result(data_res(1,i),data_res(2,i))=20;
    end
end

figure;
imshow(result,[]);