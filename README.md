# Mathematics

## Introduction

Code for algorithms in mathematics

## About Macaulay2

There is Macaulay2 code in this repository. Here we briefly mention how Macaulay2 can be installed and run, if your machine is Ubuntu 18.04 and you have root access.

The details are in this webpage: `http://www2.macaulay2.com/Macaulay2/Downloads/GNU-Linux/Ubuntu/index.html` but we will extract the most important pieces here.

### Step 1: Add a line to the file `/etc/apt/sources.list`

In a terminal, do

```
sudo gedit /etc/apt/sources.list
```

and add the line

```
deb http://www.math.uiuc.edu/Macaulay2/Repositories/Ubuntu bionic main
```

to the text file and then save.

### Step 2: Download and install Macaulay2-key

In a terminal, do

```
sudo apt-key adv --keyserver hkp://keys.gnupg.net --recv-key CD9C0E09B0C780943A1AD85553F8BD99F40DCB31
```

### Step 3: Install Macaulay2

In a terminal, do

```
sudo apt-get update -q
sudo apt-get install -y -q macaulay2
```

### Step 4: Start Macaulay2

Type `M2` in a terminal.

To leave Macaulay2, type `exit` and press Enter.

### Step 5: Run a Macaulay2 script

Assume that `script.m2` is the script.

In a terminal, do

```
M2 <path-to-folder-containing-script>/script.m2
```
