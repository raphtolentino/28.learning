#!/bin/bash

ip a         # interface info
ip r         # default routes
ping         # Layer 3 test
traceroute   # layer 3 + route trace
ss -tuln     # listening ports (Layer 4)