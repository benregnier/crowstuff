This is a place for me to keep modified crow scripts, feel free to use as you see fit. Currently featured:

# dualiq

dualiq is a sequence combiner; it pre-quantizes two input values and then adds them together, also providing some envelopes.
  
# live

live is a live code sequencer modifiable thru druid, based upon [this script uploaded to lines](https://llllllll.co/t/crow-druid-scripts/25974/21?u=q_ben).  

I have added Turing Machine-style progressive mutation to the sequencer, controlled by input 2.  

Per that post's instructions here are some sample actions:  
- set step 4 slew to 1: **slew(4, 1)**
- transpose whole sequence up an octave: **oct()**
- transpose steps 5-6 down 1 octave: **oct(-1, 5, 6)**
- set step 6 envelope to ASL function: **eg(6, adsr())**
- duplicate sequence: **cp()**
- reverse steps 9-16: **rev(9, 16)**
- transpose steps 5-9 up 7 semitones: **tp(7, 5, 9)**
- burn it all, randomize notes and start over: **rndm()**
