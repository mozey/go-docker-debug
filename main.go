// https://gobyexample.com/http-servers

package main

import (
	"fmt"
	"net/http"
)

var addr string

func hello(w http.ResponseWriter, req *http.Request) {
	_, _ = fmt.Fprintf(w, "hello foo!\n")
}

func main() {
	http.HandleFunc("/", hello)
	fmt.Printf("Listening on %v", addr)
	fmt.Println(http.ListenAndServe(addr, nil))
}

