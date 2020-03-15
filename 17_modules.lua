#!/usr/bin/env lua

print "package.loaded:"
for k, v in pairs(package.loaded) do
    print(k, v)
end

print ""
print "package.loaded.table:"
for k, v in pairs(package.loaded.table) do
    print(k, v)
end
