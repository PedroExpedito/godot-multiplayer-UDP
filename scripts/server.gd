extends Node

var PORT_SERVER = 1507
var IP_SERVER = "127.0.0.1"
var socketUDP = PacketPeerUDP.new()

func _ready():
	start_server()

func _process(delta):
	if socketUDP.get_available_packet_count() > 0:
		var array_bytes = socketUDP.get_packet()
		var IP_CLIENT = socketUDP.get_packet_ip()
		var PORT_CLIENT = socketUDP.get_packet_port()
		printt("msg server: " + array_bytes.get_string_from_ascii())
		socketUDP.set_dest_address(IP_CLIENT, PORT_CLIENT)
		var stg = "hi server!"
		var pac = stg.to_ascii()
		socketUDP.put_packet(pac)

func start_server():
	if (socketUDP.listen(PORT_SERVER) != OK):
		printt("Error listening on port: " + str(PORT_SERVER))
	else:
		printt("Listening on port: " + str(PORT_SERVER))

func _exit_tree():
	socketUDP.close()
