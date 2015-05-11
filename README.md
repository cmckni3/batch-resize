# Batch Resizer

Bash program that resizes images in a directory and outputs the resized
images to a new directory

## Requirements

* ImageMagick (uses the convert command)

## Setup

* Download face image database from UMass

```bash
wget http://vis-www.cs.umass.edu/lfw/lfw.tgz
```

## Usage

```bash
./batch_resize.sh lfw lfw-resized "10 20 50"
```

## Issues

- Will try to convert files in the input directory even if they aren't images

