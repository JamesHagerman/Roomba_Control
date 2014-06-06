require 'rubygems'  
require 'serialport' # use Kernel::require on windows, works better.  

#params for serial port  
port_str = "/dev/tty.usbserial-A401703W"  #may be different for you  
baud_rate = 19200  
data_bits = 8  
stop_bits = 1  
parity = SerialPort::NONE

puts "Opening serial port..."
@sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

def ctrl (to_write)
	@sp.putc(to_write)
end


puts "Start comms with Roomba..."
ctrl(128)	# Start
ctrl(130)	# Conrtrol

puts "All lights should now be off! We are now in Safe control mode!"
sleep(1)

puts "Turning some lights on..."
ctrl(139)	# light control
ctrl(25)	# which lights
ctrl(255)	# color
ctrl(255)	# intensity

puts "See them lights ova thar?!"
sleep(1)



puts "Entering Full control mode! Now we can control the motors!"
ctrl(132)

puts "Now we're in Full control mode!"
sleep(1)

puts "Turning vaccum on for two seconds"
ctrl(138)
ctrl(7)

sleep(2)

puts "Turning the vaccum off."
ctrl(138)
ctrl(0)

puts "Sleeping to return to Passive control mode (so the buttons work again)"
ctrl(133)	# Power/Sleep/Return to passive
exit 1

