// https://gobyexample.com/http-servers

package main

import (
	"fmt"
	"net/http"
)

var addr string

func GetResp(msg string, a int, b int) string {
	c := a + b
	return fmt.Sprintf("%v %v\n", msg, c)
}

func hello(w http.ResponseWriter, req *http.Request) {
	resp := GetResp("hello foo!", 1, 1)
	_, _ = fmt.Fprintf(w, resp)
}

func main() {
	http.HandleFunc("/", hello)
	fmt.Printf("Listening on %v", addr)
	fmt.Println(http.ListenAndServe(addr, nil))
}

