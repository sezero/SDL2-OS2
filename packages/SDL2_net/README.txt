
SDL_net 2.0

The latest version of this library is available from GitHub:
https://github.com/libsdl-org/SDL_net/releases

This is an example portable network library for use with SDL.
It is available under the zlib license, found in the file LICENSE.txt.
The API can be found in the file SDL_net.h and online at https://wiki.libsdl.org/SDL2_net
This library supports UNIX, Windows, MacOS Classic, MacOS X,
BeOS and QNX.

The demo program is a chat client and server.

The chat client connects to the server via TCP, registering itself.
The server sends back a list of connected clients, and keeps the
client updated with the status of other clients.
Every line of text from a client is sent via UDP to every other client.

Note that this isn't necessarily how you would want to write a chat
program, but it demonstrates how to use the basic features of the 
network library.

Enjoy!
	-Sam Lantinga and Roy Wood

