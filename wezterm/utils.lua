local M = {}

function M.split_pane(window, pane)
    local tab = pane:tab()
    local direction = "Bottom"
    local percent = 50
    local panes = tab:panes_with_info()
    local number_of_panes = #panes
    local current_pane = nil
    local is_main = false

    for _, pane_info in ipairs(panes) do
        if pane_info.pane:pane_id() == pane:pane_id() then
            current_pane = pane_info
        end
    end

    if current_pane.left == 0 and current_pane.top == 0 then
        direction = "Right"
        percent = 33

        if number_of_panes > 1 then
            local closest_pane = nil
            for _, pane_info in ipairs(panes) do
                if pane_info.top == 0 then
                    closest_pane = pane_info
                end
            end
            pane = closest_pane.pane
            direction = "Top"
            percent = 50
        end
    end

    pane:split({direction = direction, size = percent / 100})
end

return M;
