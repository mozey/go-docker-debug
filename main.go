// https://gobyexample.com/http-servers

package main

import (
	"fmt"
	"net/http"
)

var addr string

func getResp() string {
	a := 1
	b := 1
	c := a + b
	resp := "hello foo!"
	return fmt.Sprintf("%v %v\n", resp, c)
}

func hello(w http.ResponseWriter, req *http.Request) {
	resp := getResp()
	_, _ = fmt.Fprintf(w, resp)
}

func main() {
	http.HandleFunc("/", hello)
	fmt.Printf("Listening on %v", addr)
	fmt.Println(http.ListenAndServe(addr, nil))
}

