syms a1 a2 a3 a4 a5
yi=(((a2-a4*a5^2)/(1-a5^2))+sign(ty-((a2-a4*a5^2)/(1-a5^2)))*sqrt(((sqrt(((a1-a3)^2+(a2-a4)^2)*(a5^2/(1-a5^2)^2)))*((ty-((a2-a4*a5^2)/(1-a5^2)))/(tx-((a1-a3*a5^2)/(1-a5^2)))))^2/(1+((ty-((a2-a4*a5^2)/(1-a5^2)))/(tx-((a1-a3*a5^2)/(1-a5^2))))^2)));
xi=(((a1-a3*a5^2)/(1-a5^2))+sign(tx-((a1-a3*a5^2)/(1-a5^2)))*sqrt((sqrt(((a1-a3)^2+(a2-a4)^2)*(a5^2/(1-a5^2)^2)))^2/(1+((ty-((a2-a4*a5^2)/(1-a5^2)))/(tx-((a1-a3*a5^2)/(1-a5^2))))^2)));

A11=diff(xi,a1);
B11=diff(xi,a2);
C11=diff(xi,a3);
D11=diff(xi,a4);
E11=diff(xi,a5);

A1=double(subs(A11,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
B1=double(subs(B11,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
C1=double(subs(C11,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
D1=double(subs(D11,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
E1=double(subs(E11,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));

A21=diff(yi,a1);
B21=diff(yi,a2);
C21=diff(yi,a3);
D21=diff(yi,a4);
E21=diff(yi,a5);

A2=double(subs(A21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
B2=double(subs(B21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
C2=double(subs(C21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
D2=double(subs(D21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));
E2=double(subs(E21,{a1,a2,a3,a4,a5},{xe,ye,xp,yp,ke}));

%{
syms xe xi xedot yedot xpdot ypdot ye yi

xidot=(1/(ye-yi))*((xe-xi)*(B2-1)*(yedot)+(A2*(xe-xi)+ye-yi)*(xedot)+C2*(xe-xi)*(xpdot)+D1*(xe-xi)*(ypdot));

dxidxi=diff(xidot,xi);
dxidyi=diff(xidot,yi);
dxidxe=diff(xidot,xe);
dxidye=diff(xidot,ye);
dxidxedot=diff(xidot,xedot);
dxidyedot=diff(xidot,yedot);
dxidxpdot=diff(xidot,xpdot);
dxidypdot=diff(xidot,ypdot);

A11=double(subs(dxidxi,{xi,yi,xe,ye,xedot,yedot,xpdot,ypdot},{s(end).xi,s(end).yi,xe,ye,xedot,yedot,xpdot,ypdot}));
A12=double(subs(dxidyi,{xi,yi,xe,ye,xedot,yedot,xpdot,ypdot},{s(end).xi,s(end).yi,xe,ye,xedot,yedot,xpdot,ypdot}));
B11=double(subs(dxidxe,{xi,yi,xe,ye,xedot,yedot,xpdot,ypdot},{s(end).xi,s(end).yi,xe,ye,xedot,yedot,xpdot,ypdot}));
B12=double(subs(dxidxe,{xi,yi,xe,ye,xedot,yedot,xpdot,ypdot},{s(end).xi,s(end).yi,xe,ye,xedot,yedot,xpdot,ypdot}));
B13=double(subs(dxidxe,{xi,yi,xe,ye,xedot,yedot,xpdot,ypdot},{s(end).xi,s(end).yi,xe,ye,xedot,yedot,xpdot,ypdot}));
B14=double(subs(dxidxe,{xi,yi,xe,ye,xedot,yedot,xpdot,ypdot},{s(end).xi,s(end).yi,xe,ye,xedot,yedot,xpdot,ypdot}));
B15=double(subs(dxidxe,{xi,yi,xe,ye,xedot,yedot,xpdot,ypdot},{s(end).xi,s(end).yi,xe,ye,xedot,yedot,xpdot,ypdot}));
B16=double(subs(dxidxe,{xi,yi,xe,ye,xedot,yedot,xpdot,ypdot},{s(end).xi,s(end).yi,xe,ye,xedot,yedot,xpdot,ypdot}));
B17=double(subs(dxidxe,{xi,yi,xe,ye,xedot,yedot,xpdot,ypdot},{s(end).xi,s(end).yi,xe,ye,xedot,yedot,xpdot,ypdot}));
B18=double(subs(dxidxe,{xi,yi,xe,ye,xedot,yedot,xpdot,ypdot},{s(end).xi,s(end).yi,xe,ye,xedot,yedot,xpdot,ypdot}));







yidot=(1/(xe-xi))*((ye-yi)*(A1-1)*(xedot)+(B1*(ye-yi)+xe-xi)*(yedot)+C1*(ye-yi)*(xpdot)+D1*(ye-yi)*(ypdot));

dyidxi=diff(yidot,xi);
dyidyi=diff(yidot,yi);
dyidxe=diff(yidot,xe);
dyidye=diff(yidot,ye);
dyidxedot=diff(yidot,xedot);
dyidyedot=diff(yidot,yedot);
dyidxpdot=diff(yidot,xpdot);
dyidypdot=diff(yidot,ypdot);
%}
