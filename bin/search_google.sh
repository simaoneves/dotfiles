#!/usr/bin/env bash

function search_google() {
    search_term=$(pbpaste)
	open -a Google\ Chrome http://www.google.com/search?q=`echo $search_term | tr " " "+"`
}

search_google

