-- random livecoded sequencer, based on script uploaded to lines with my modifications
-- Input 1: clock
-- Input 2: probability of note replacement (0-5v)
-- Output 1: melody
-- Output 2: envelope

sequence = {}
index = 0
slength = 8
prob = 0

function init()
  rndm()
  input[1].mode('change', 1, 0.05, 'rising')
  input[1].change = handleChangeClock
  print('sequencer script loaded')
end

function handleChangeClock(state)
  math.randomseed(time())
  prob = input[2].volts / 5
  if prob > 1 then prob = 1 end
  if prob < 0 then prob = 0 end
  if math.random > prob then rndm(index + 1) end
  local step = sequence[index + 1]
  output[1].slew = step.slew
  output[1].volts = n2v(step.note)
  output[2].action = step.eg
  output[2]()
  index = ((index + 1) % #sequence)
end

function handleChangeInput2(state)
  rndm(#sequence)
end

-- user functions to invoke from druid below --

function reset(length)
    math.randomseed(time())
    local seq = {}
    local noteOptions = {0, 2, 4, 5, 7, 9, 11, 12, 14, 16, 17, 19, 21, 23}
    for i=1,length do
      local note = noteOptions[math.floor(math.random(1, 14))]
      local step = {note = note, slew = 0, eg = ar()}
      table.insert(seq, step)
    end
    sequence = seq
    index = 0
    show()
  end

function rndm(first, last)
  first = first or 1
  last = last or first
  if last = 0 then last = slength end
  if last < first then print('invalid params') return end
  math.randomseed(time())
  local noteOptions = {0, 2, 4, 5, 7, 9, 11, 12, 14, 16, 17, 19, 21, 23}
  for i=first, last do
    local note = noteOptions[math.floor(math.random(1, 14))]
    if i <= #sequence then
      sequence[i].note = note
    else 
      local step = {note = note, slew = 0, eg = ar()}
      table.insert(sequence, step)
  end
  show()
end

-- change octaves, default 1 octave up entire sequence
function oct(mult, first, last)
  mult = mult or 1
  tp(12 * mult, first, last)
end

-- transpose, default 1 semitone
function tp(value, first, last)
  first = first or 1
  last = last or #sequence
  if last < first then print('invalid params') return end
  for i=first,last do
    sequence[i].note = sequence[i].note + value
  end
  show()
end

-- reverse entire sequence or subsequence if first and last provided
function rev(first, last)
  first = first or 1
  last = last or #sequence
  if last < first then print('invalid params') return end
  local reversed = {}
  local idx = first
  for i=last,first,-1 do
    reversed[idx] = sequence[i]
    idx = idx + 1
  end
  for i=first,last do
    sequence[i] = reversed[i]
  end
  show()
end

-- duplicate entire sequence or subsequence if first and last provided
function cp(first, last)
  first = first or 1
  last = last or #sequence
  if last < first then print('invalid params') return end
  for i=first,last do
    local origStep = sequence[i]
    local newStep = {note = origStep.note, slew = origStep.slew, eg = origStep.eg}
    table.insert(sequence, newStep)
  end
  show()
end

-- slew step with value
function slew(step, value)
  sequence[step].slew = value
end

-- change step envelope - value is ASL function
function eg(step, value)
  sequence[step].eg = value
end

-- print sequence notes
function show()
  local seq = ''
  for i=1,#sequence do
    seq = seq .. sequence[i].note .. ' '
  end
  print(seq)
end
