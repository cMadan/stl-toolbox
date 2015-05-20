function cmap = dhsv(n)

n1 = round(n/2);
n2 = n - n1;
cmap = [hsv(n1); hsv(n2)];
    