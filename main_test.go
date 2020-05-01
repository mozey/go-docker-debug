package main

import (
	"testing"
)

func TestGetResp(t *testing.T) {
	msg := "hello foo!"
	a := 1
	b := 3
	resp := GetResp(msg, a, b)
	compare := "hello foo! 4"
	if resp != compare {
		t.Error("unexpected response")
	}
}
