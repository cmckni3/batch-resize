#!/bin/bash

function Help()
{
  echo 'Batch Image Resizer'
  echo
  echo 'Usage: batch_resize input_dir output_dir resize_ratios'
  echo
  echo '       input_dir    Directory to find images to be converted'
  echo '       output_dir   Directory to output resized images'
  echo '       resize_ratio Space separated string of integer percentages to resize images'
  echo
  echo 'Example: batch_resize.sh ~/images ~/images-resized "10 30 50"'
}

function GetDirectorySize()
{
  if [ -z "$1" ]
  then
    return 1
  fi
  directory=$1
  find $directory -type f -exec ls -l {} \; | awk '{sum += $5} END {print sum}'
}

function DisplaySummary()
{
  if [ -z "$2" ]
  then
    return 1
  fi
  input_dir=$1
  output_dir=$2
  # (1) the total number of files being processed
  echo "Total images: $(GetImages | wc -l)"
  # (2) the total size of original files
  echo "Total original file size: $(GetDirectorySize $input_dir)"
  # (3) the total size of the resized files.
  echo "Total resized file size: $(GetDirectorySize $output_dir)"
}

function ProcessImages()
{
  for file in $(GetImages); do
    # (1) the name of the original image
    # (2) the original size of the image
    echo "$(basename $file) $(GetFilesize $file)"
    for ratio in $resize_ratios; do
      filename=$(CreateFileName $file)
      destination=$(CreateDestination $output_dir $file $ratio)
      ResizeImage $ratio $file $destination
      # (3) the name of the resized image
      # (4) the size of the resized image.
      echo "$(basename $destination) $(GetFilesize $destination)"
    done
  done
}

function GetImages()
{
  find $input_dir -type f
}

function CreateDestination()
{
  output_dir=$1
  filename=$2
  ratio=$3
  ext=${filename##*.}
  prefix=$(CreateFileName $filename)
  destination_dir="$output_dir/${prefix#*/}"
  mkdir -p $(dirname $destination_dir)
  echo "$destination_dir-r$ratio.$ext"
}

function GetFilesize()
{
  if [ -z "$1" ]
  then
    return 1
  fi
  filename=$1
  wc -c $filename | awk '{print $1}'
}

function CreateFileName()
{
  if [ -z "$1" ]
  then
    return 1
  fi
  filename=$1
  echo $filename | cut -d '.' -f 1
}

function ResizeImage()
{
  if [ -z "$3" ]
  then
    return 1
  fi
  percentage=$1
  input=$2
  output=$3
  convert -resize $percentage $input $output
}

if [ $1 = "help" ] || [ -z "$3" ]
then
  # Display help
  Help
else
  # Resize images
  input_dir=$1
  output_dir=$2
  resize_ratios=$3
  if [ -d $output_dir ]; then
    echo "Directory $output_dir already exists"
    exit 1
  fi
  ProcessImages
  DisplaySummary $input_dir $output_dir
fi
