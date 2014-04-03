fpsGraph = require "FPSGraph"

function love.load()
	-- fps graph
	testGraph = fpsGraph.createGraph()
	-- memory graph
	testGraph2 = fpsGraph.createGraph(0, 30)
	-- random graph
	testGraph3 = fpsGraph.createGraph(0, 60)
end

function randomUpdate(graph, dt, n)
    local val = love.math.random()*n

    fpsGraph.updateGraph(graph, val, "Random: " .. math.floor(val*10)/10, dt)
end
function love.update(dt)
	-- update graphs using the update functions included in fpsGraph
	fpsGraph.updateFPS(testGraph, dt)
	fpsGraph.updateMem(testGraph2, dt)

	-- update this one using a custom update function
	randomUpdate(testGraph3, dt, 100)
end

function love.draw()
	-- draw the graphs
	fpsGraph.drawGraphs({testGraph, testGraph2, testGraph3})
end