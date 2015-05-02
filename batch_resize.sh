#!/bin/bash

function help()
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

# function ReadImageFile()
# {
# }

# function CreateFileName($filename)
# {
#   echo $filename | cut -d ‘.’ -f 1
#   wc -c $filename | awk ‘{print $1;}’
# }

# function ResizeImage($input, $output, $percentage)
# {
#   convert -resize $percentage $input $output
# }

if [ $1 = "help" ]; then
  # Display help
  help
else
  # Resize images
  input_dir=$1
  output_dir=$2
  resize_ratios=$3
  if [ -d $output_dir ]; then
    echo "Directory $output_dir already exists"
    exit 1
  fi
  echo $input_dir
  echo $output_dir
  echo $resize_ratios
fi
