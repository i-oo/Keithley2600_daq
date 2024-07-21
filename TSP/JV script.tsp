-- Configure SMU Channel A
smua.reset()
smua.source.func					= smua.OUTPUT_DCVOLTS
smua.measure.autorangei = smua.AUTORANGE_ON
smua.source.limiti					= 0.1
smua.measure.nplc					= 1

-- Select ASCII data format.
format.data = format.ASCII

-- Configure Buffer.
smua.nvbuffer1.clear()
smua.nvbuffer1.appendmode = 1
smua.nvbuffer1.collectsourcevalues = 1
smua.nvbuffer1.collecttimestamps = 1

-- Set count to 1.
smua.measure.count = 1
step = (0.9-(-0.5))/(75-1)

-- Initialize bias voltage to 0 V.
smua.source.levelv = 0.0

smua.source.output = smua.OUTPUT_ON
-- Loop for voltages from startV to stopV.
for v = -0.5, 0.9, step do
	-- Set source voltage.
	smua.source.levelv = v
	-- Measure current and store in nvbuffer1.
	smua.measure.i(smua.nvbuffer1)
end
smua.source.output = smua.OUTPUT_OFF

-- Output time stamps
printbuffer(1, smua.nvbuffer1.n, smua.nvbuffer1.timestamps)
-- Output voltage source values
printbuffer(1, smua.nvbuffer1.n, smua.nvbuffer1.sourcevalues)
-- Output current readings
printbuffer(1, smua.nvbuffer1.n, smua.nvbuffer1.readings)