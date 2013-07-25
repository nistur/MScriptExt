if isEditor() then 

editor = {}

local publish_event_table = {}

function editor.publish_event(event)
	publish_event_table[#publish_event_table + 1] = event
end --[[ editor.publish_event ]]

function editor.publish()
	for i=1, #publish_event_table do
		local event_type = type(publish_event_table[i])
		if event_type == "function" then
			publish_event_table[i]()
		elseif event_type == "table" then
			if publish_event_table[i].publish then
				publish_event_table[i]:publish()
			end --[[ event.publish ]]
		end --[[ event_type ]]
	end --[[ publish_event_table loop ]]
end --[[ editor.publish ]]

--[[ load all editor scripts ]]
local editor_scripts = readDirectory("editor")
for i=1, #editor_scripts do
	dofile(editor_scripts[i])
end

end --[[ isEditor() ]]