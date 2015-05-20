% save config settings into 'out'
vars = who;
for v = 1:length(vars)
    eval(sprintf('out.config.%s = %s;',vars{v},vars{v}))
end