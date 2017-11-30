
;FoleVerb  ver 0.1
;A Reverberator based on chapters 22, 23, 24  of the CSound book by Dr. Boulanger; "Designing Multi-Channel Reverberators", John Stautner and Miller Puckette and "A New Approach to Digital Reverberation using Closed Waveguides Networks", Julius O. Smith and "Building the Erbe-Verb: Extending the Feedback Delay Network Reverb for Modular Sythesizer Use" Tom Erbe.
<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 2
;0dbfs = 1.0
				;GLOBAL VARS
gadrysig init 0		;holds the signal
gifbdec    init 0		;decay coefficient 
 garet1 init 0
 garet2 init 0




	instr 1   					;NOISE BURST (for testing purposes)
kenv	linseg 9000, .1, 1000, p3-0.1, 0 	;env
anoiz randi kenv, sr/2, .5 			;noise burst
gadrysig = gadrysig + anoiz 			;add burst
	endin

	instr 8888						;REVERB
afilt3 init 0
afilt4 init 0
idel1 = (2473.000/sr)
idel2 = (2767.000/sr)
idel3 = (3217.000/sr)
idel4 = (3557.000/sr)
  gifbdec = p5							;Decay
  kabs = p4 							;absorption coeff 
  kcf = p6							;Cutoff lpf
  kwd = p7							;Dry/Wet     (0 - 1)
 atemp alpass gadrysig, 1.7, .1
 aleft alpass atemp, 1.01, .07
 aright alpass gadrysig, 1.5, .2
 aright alpass atemp, 1.33, .05
 atemp alpass garet1, 1.3, .3
 aretl alpass atemp, 1.37 , .5
 atemp alpass garet2, 1.29 ,.01
 aretr alpass atemp, 1.41 , .03
 kdel1 randi .01, 1, .666
addl1 delayr .3
afeed1 deltapi idel1 + kdel1
afeed1 = afeed1+gifbdec*aleft
delayw aleft
kdel2	 randi .01, .95, .777
addl2 delayr .3
afeed2 deltapi idel2 + kdel2
afeed2 = afeed2 + gifbdec* aright
delayw aright
 kdel3 randi .01, 0.97, .555
addl3 delayr .3
afeed3 deltapi idel3 + kdel3
afeed3 = afeed3+gifbdec*aretl
delayw aretl
kdel4	 randi .01, .96, .181818
addl4 delayr .3
afeed4 deltapi idel4 + kdel4
afeed4 = afeed4 + gifbdec* aretr
delayw aretr
aout1 = (aleft - aright) - (aretl - aretr)*0.3
aout2 = (aleft + aright) - (aretl + aretr)*0.333
garet2 = ((aleft - aright) + (aretl - aretr))*0.37
garet1 = ((aleft + aright) + (aretl + aretr))*0.4
al tone aout1, kcf
ar tone aout2, kcf 
garet1 tone garet1, kcf
garet2 tone garet2, kcf
outs al*kwd + gadrysig*(1-kwd), ar*kwd + gadrysig * (1-kwd)
gadrysig = 0
endin
</CsInstruments>
<CsScore>
; INS ST DUR				;Noise Burst 
i   1   0    .15	
i   1   1    .15
i   1   2    .15
i   1   3    .15
i   1   6    .15
i   1   9    .15			
i   1  12   .15	
i   1  15  .15	

;ins	  st	  dur	  absorption	decay	   cutofflp	wetdry   ;REVERB
i 8888    0	   3	   0.1		0.5	    10000	0
i 8888    3         3         0.8         	.4            10000	0.5
i 8888    6         2.5       0.3         	.7	    3300	0.6
i 8888    9         2        0.7         	.9	    5000	0.9
i 8888   12        3         0.4         	.1            700		1
i 8888   15        3        0.6         	.5	    12000	0.8			
</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
