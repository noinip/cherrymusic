#!/bin/bash

if [ -f "/root/.config/cherrymusic/cherrymusic.conf" ]; then 
	exec python3 /opt/cherrymusic/cherrymusic 
  else
	exec python3 /opt/cherrymusic/cherrymusic --setup --port 8070
  fi
fi
