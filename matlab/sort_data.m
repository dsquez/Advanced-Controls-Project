function y_sorted = sort_data(t,y)
N = 1;
last_swap = 1;
for i = 1:length(t)-1
    if y(i+1,5) ~= y(i,5)
        y_sorted(N).y = y(last_swap:i,:);
        y_sorted(N).t = t(last_swap:i);
        
        last_swap = i+1;
        N = N+1;
    end
end

y_sorted(N).y = y(last_swap:i,:);
y_sorted(N).t = t(last_swap:i);
