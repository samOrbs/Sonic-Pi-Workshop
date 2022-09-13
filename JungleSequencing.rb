
live_loop :aBreak do
  
  use_bpm 160 # the bpm, we use 160 as that is commonly used in Jungle
  
  theSample = :loop_amen # the sample, we use amen break because it was a very important break for Jungle
  
  a = (ring 0,1,3).tick(:a) # the following three lines are number sequences we send to our sequencer on line 14
  
  b = (ring 2,5,3).tick(:b)
  
  c = (ring 0,1,0,0).tick(:c)
  
  retrigger = (knit 1,15-2,4,2,2,1).tick(:d) # this line creates a knitting sequence that will tell our sequencer on line 14 when to retrigger
  
  rateOfSample = (knit 1,15,-1,2,1,14,-1,1,1.1,16,1.15,14,-1.1,2).tick(:e) # this line creates a knitting sequence that controls the rate(speed) of the sample play back, think of it like a little cassete player, it can also go backwards
  
  onsetValue = (knit 0,32,4,16,2,16).tick(:f) # this line creates a knitting function that chooses and onset value, an onset is a command we pass to the sonic pi sampler that can choose a slice of a percussive sample based on its amplitude peaks 0 is the first onset .. 1,2,3 etc are the next peaks, of loud moments, perfect for cutting up a drum break.
  
  theSequencer = (ring 0,1,2,3,4)[(ring a,b,c,a,b).stretch(retrigger).tick(:g)] # this is the sequencer, we then feed to the sampler on line 16. The first ring is a sequences 0,1,2,3,4 that makes up the amen break onsets, the [] brakets after the ring is a way to choose its values like an array, ie. by index, in this we feed it another sequence that tells it which onset to play based off the a,b,c rings at the top, the stretch command on the end of a ring will retrigger the last value, we use this to emulate the retrigger of hardware sequencer
  
  sample  theSample, onset: theSequencer+onsetValue, rate: rateOfSample # this line calls the sample function and combines all the other lines to enacts its arguments
  
  sleep 0.5 # this is the sleep
  
end
