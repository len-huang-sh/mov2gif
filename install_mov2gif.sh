#!/bin/bash

# Function to create and install the mov2gif script
install_mov2gif_script() {
  echo "Creating and installing the mov2gif script..."
  cat <<EOL > /usr/local/bin/mov2gif
#!/bin/bash

# Usage message
usage() {
  echo "Usage: \$0 [options] <input>"
  echo "Options:"
  echo "  -h, --help     Show this help message"
  echo "Input:"
  echo "  <input>        The input file or directory to convert"
  echo "Description:"
  echo "This script converts screen recordings of .mov types to optimized GIFs, reducing their size."
  echo "You can provide either a single file or an entire folder as input."
  exit 1
}

# Check for help flag
while [[ \$# -gt 0 ]]; do
  case "\$1" in
    -h | --help )
      usage
      ;;
    * )
      break
      ;;
  esac
  shift
done

# Check if the correct number of arguments are provided
if [ \$# -ne 1 ]; then
  usage
fi

# Input path (file or folder)
input_path="\$1"

# Remove trailing slashes from the input path
input_path="\${input_path%/}"

# Path to Homebrew-installed ffmpeg
ffmpeg_path="/opt/homebrew/bin/ffmpeg"

# Path to Homebrew-installed gifsicle
gifsicle_path="/opt/homebrew/bin/gifsicle"

# Function to convert a single .mov file to .gif
convert_mov_to_gif() {
  local input_file="\$1"
  local output_dir="\$2"
  
  # Extract the filename without extension
  local filename_noext="\$(basename "\$input_file" .mov)"
  
  # Output filename for the GIF
  local output_file="\$output_dir/\$filename_noext.gif"
  
  # Check if the GIF file already exists, and if so, skip conversion
  if [ -f "\$output_file" ]; then
    echo "GIF file already exists: \$output_file (Skipping conversion)"
    return
  fi
  
  # Inform the user that the conversion is starting
  echo "Converting \$input_file to \$output_file using ffmpeg..."
  
  # Convert the .mov file to .gif using Homebrew-installed ffmpeg
  "\$ffmpeg_path" -i "\$input_file" -pix_fmt rgb8 -r 10 "\$output_file" > /dev/null 2>&1 && \
  
  # Optimize the GIF using Homebrew-installed gifsicle
  "\$gifsicle_path" -O3 "\$output_file" -o "\$output_file"
  
  # Check if the conversion was successful
  if [ \$? -eq 0 ]; then
    echo "Conversion successful: \$input_file -> \$output_file"
  else
    echo "Conversion failed: \$input_file"
  fi
}

# Function to convert all .mov files in a directory
convert_all_mov_in_directory() {
  local input_dir="\$1"
  local output_dir="\$2"

  # Create the output directory if it doesn't exist
  mkdir -p "\$output_dir"

  # Process all .mov files in the input directory
  for mov_file in "\$input_dir"/*.mov; do
    if [ -f "\$mov_file" ]; then
      convert_mov_to_gif "\$mov_file" "\$output_dir"
    fi
  done
}

# Check if the input path is a directory
if [ -d "\$input_path" ]; then
  # Input is a directory, create a new directory for output GIFs
  output_dir="\${input_path}_gifs"
  convert_all_mov_in_directory "\$input_path" "\$output_dir"
  
  echo "GIFs saved in directory: \$output_dir"
elif [ -f "\$input_path" ]; then
  # Input is a single file
  # Check if the input file has a .mov extension
  if [[ "\$input_path" != *.mov ]]; then
    echo "Input file must have a .mov extension: \$input_path"
    exit 1
  fi
  
  # Extract the directory and filename
  input_dir="\$(dirname "\$input_path")"
  convert_mov_to_gif "\$input_path" "\$input_dir"
else
  echo "Input not found: \$input_path"
  exit 1
fi

EOL
  chmod +x /usr/local/bin/mov2gif
  echo "mov2gif script installed successfully."
}

# Main script
install_mov2gif_script

echo "Installation completed successfully!"
