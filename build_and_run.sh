#!/bin/bash
#
# a dead-simple webserver for viewing the demos locally. 
#
# usage:
#   demo-server <port-number>

# Make sure all packages are installed
echo ""
echo "Installing node packaged..."
npm install .
echo "Node packages installed!"
echo ""

# Make sure all files are build
echo "Compiling SASS"
cd stylesheets/
sass main.scss main.css
cd ..
echo "SASS compiled!"
echo ""

echo "Compiling CoffeeScripts"
cd javascripts/
coffee -m -c .
cd ..
echo "CoffeeScripts compiled!"
echo ""

# use default port if called without args
PORT=2600 
if [[ $1 =~ ^[0-9]+$ ]]
  then PORT=$1
fi

echo "Starting local http server (ctrl-c to exit)"
echo ""
echo "Running at: http://127.0.0.1:$PORT/"
echo ""
open "http://127.0.0.1:$PORT/"
python -m SimpleHTTPServer $PORT