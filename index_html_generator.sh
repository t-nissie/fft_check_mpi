#!/bin/sh
##
cat > index.html <<- HEAD
	<!DOCTYPE html>
	<html lang="en">
	<head>
	  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	  <title>fft_check_mpi.F</title>
	  <meta name="author" content="Takeshi Nishimatsu" />
	  <meta name="copyright" content="Copyright &#169; 2013 Takeshi Nishimatsu" />
	  <link rel="stylesheet" href="style.css" type="text/css" />
	  <link rel="shortcut icon" href="favicon.ico" />
	</head>
	<body>
HEAD

~/gems/github-markdown-0.6.3/bin/gfm --readme $* >> index.html

cat >> index.html <<- TAIL
	</body>
	</html>
TAIL
