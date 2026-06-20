-- Workspace limits
for i = 1, 10 do
    hl.workspace_rule({ workspace = tostring(i), persistent = true })
end
