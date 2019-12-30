This is a Dockerfile setup for CherryMusic - http://www.fomori.org/cherrymusic/

To run:

```
docker run -d --name="cherrymusic" -v /path/to/config:/root/.config/cherrymusic -v /path/to/music:/music -v /etc/localtime:/etc/localtime:ro -p 8070:8070 pinion/cherrymusic
```


