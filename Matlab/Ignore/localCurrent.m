function I = localCurrent(x,y,k,E,l,phi)
    tan = sin(k)/sqrt(1-(cos(k)+2*E-2).^2);
    gamma = 2/l^2*(x-y*tan);
    I = sin(phi/2-gamma/2)*tanh(cos(phi/2-gamma/2)/2);
end