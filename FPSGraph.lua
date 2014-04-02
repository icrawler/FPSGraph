local fpsGraph = {}

fpsGraph.fpsFont = love.graphics.newFont(8)

-- creates a graph table (too lazy to make objects and stuff)
function fpsGraph.createGraph(x, y, width, height, delay, draggable)
	local vals = {}
	for i=1, math.floor((width or 50)/2) do
		table.insert(vals, 0)
	end
	return {
		x = x or 0,
		y = y or 0,
		width = width or 50,
		height = height or 30,
		delay = delay or 0.5,
		draggable = draggable or true,
		vals = vals,
		vmax = 0,
		cur_time = 0,
		label = "graph"
	}
end

function fpsGraph.updateFPS(graph, dt)
	local fps = 0.75*1/dt + 0.25*graph.vals[#graph.vals]
	graph.cur_time = graph.cur_time + dt

	while graph.cur_time >= graph.delay do
		graph.cur_time = graph.cur_time - graph.delay

		table.remove(graph.vals, 1)
		table.insert(graph.vals, fps)

		if fps > graph.vmax then
			graph.vmax = fps
		end
		graph.label = "FPS: " .. math.floor(fps*10)/10
	end

	return graph
end

function fpsGraph.updateMem(graph, dt)
	local mem = 0.75*collectgarbage("count") + 0.25*graph.vals[#graph.vals]
	graph.cur_time = graph.cur_time + dt

	while graph.cur_time >= graph.delay do
		graph.cur_time = graph.cur_time - graph.delay

		table.remove(graph.vals, 1)
		table.insert(graph.vals, mem)

		if mem > graph.vmax then
			graph.vmax = mem
		end
		graph.label = "Memory (KB): " .. math.floor(mem*10)/10
	end

	return graph
end

-- draws all the graphs in your list
function fpsGraph.drawGraphs(graphs)
	love.graphics.setFont(fpsGraph.fpsFont)
	for _, v in ipairs(graphs) do
		local maxVal = math.ceil(v.vmax/10)*10+20
		local len = #v.vals
		local step = v.width/len
		for i=2, len do
			local a = v.vals[i-1]
			local b = v.vals[i]
			love.graphics.line(step*(i-2), v.height*(-a/maxVal+1)+v.y,
							   step*(i-1), v.height*(-b/maxVal+1)+v.y)
		end
		love.graphics.print(v.label, v.x, v.height+v.y-8)
	end
end

return fpsGraph