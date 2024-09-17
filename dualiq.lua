-- quantize both inputs and drive a single output
s1 = {0,2,7,9}
s2 = {-5,0,5,7}
v1 = 0
v2 = 0

function init()
	input[1].mode('scale', s1)
	input[2].mode('scale', s2)
	input[1].scale = function(n) i1go(n) end
	input[2].scale = function(n) v2 = n.volts end
	output[2].action = ar(0.05, 1, 7, 'log')
	output[4].action = ar(0.05, 2, 7, 'lin')
end

function nn(i,sc) --helper function to modify scale
	input[i].mode('scale', sc)
end

function i1go(n)
	output[1].volts = n.volts + v2 
	output[2]()
	if math.random()> .75 then
		output[3].volts = n.volts
		output[4]() 
	end
end
	