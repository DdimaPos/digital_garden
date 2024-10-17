
## This is our knowlede repo

To build a html version of it, you'll need to get deno.

```sh
pacman -Sy deno
```

After that, run the `./maca.sh` script which uses the maca tool
to generate a static website out of the notes and places it
in the gitignored `html/` directory. copy it wherever you need.

## Serving

We plan on hosting this notes on github pages in the near future.

In the mean time, you may use a simple golang server:

```go
package main

import (
	"log"
	"net/http"
)

type FileServer struct {
    notesDir string
    port string
}

func NewFileServer(dir, port string) FileServer {
    return FileServer{dir, port}
}

func (f FileServer) Serve() {
	fs := http.FileServer(http.Dir(f.notesDir))
	mux := http.NewServeMux()
	mux.Handle("/notes/", http.StripPrefix("/notes", fs))

	log.Println("Serving on http://localhost+"+f.port)
	if err := http.ListenAndServe(f.port, mux); err != nil {
		log.Fatal(err)
	}
}

func main() {
  server := NewFileServer("/your_path/html/", ":8080")
  server.Serve()
}
```
