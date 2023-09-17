local ok, satellite = pcall(require, "satellite")
if not ok then
    return
end

satellite.setup {}
