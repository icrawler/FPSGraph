fpsGraph = require "FPSGraph"

function love.load()
	testGraph = fpsGraph.createGraph()
	testGraph2 = fpsGraph.createGraph(0, 30)
end

function love.update(dt)
	fpsGraph.updateFPS(testGraph, dt)
	fpsGraph.updateMem(testGraph2, dt)
end

function love.draw()
	fpsGraph.drawGraphs({testGraph, testGraph2}, dt)
end