local f = io.open("/tmp/hldump.txt", "w")
if f then
    for k,v in pairs(hl.dsp) do
        f:write(tostring(k) .. "\n")
    end
    if type(hl.dsp.window) == "table" then
        f:write("window:\n")
        for k,v in pairs(hl.dsp.window) do f:write(tostring(k) .. "\n") end
    end
    f:close()
end
