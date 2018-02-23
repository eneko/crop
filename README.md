# crop
A command line tool to **scale and crop images maintaining aspect ratio**.

From local file:
```
$ crop original.png 1920 1080
🏙 Original image size: 4284x2844
🏙 Resized image size: 1920x1080
📁 Resized image saved to: /Users/enekoalonso/dev/eneko/crop/original_1920x1080.png
```

From web:
```
$ crop http://www.example.com/original.png 1920 1080
```

Custom filename:
```
$ crop http://www.example.com/original.png 1920 1080 -o output.png
```


## Usage

```
OVERVIEW: Resize and Crop images

USAGE: crop <filename|url> <width> <height>

OPTIONS:
  --output, -o
             Output filename
  --help     Display available options

POSITIONAL ARGUMENTS:
  filename   Filename or URL
  height     Output height in pixels
  width      Output width in pixels
```


## Installation

Download the latest release and save in a folder in your executable path,
for example on `/usr/local/bin`:

```
$ curl -O https://github.com/eneko/crop/releases/download/0.0.1/crop.zip
$ unzip crop.zip
$ install -d /usr/local/bin
$ install -C -m 755 crop /usr/local/bin/crop
```


## Scripting

Command line tools are great for scripting. Need to scale and crop an image to
multiple sizes? Say no more!

```
$ vim generate-appletv-images.sh
```

```sh
#!/usr/bin/env sh

ORIGINAL=$1

crop $ORIGINAL 2320  720 -o TopShelf_Wide.jpg
crop $ORIGINAL 4640 1440 -o TopShelf_Wide@2x.jpg
crop $ORIGINAL 1920  720 -o TopShelf.jpg
crop $ORIGINAL 3840 1440 -o TopShelf@2x.jpg
crop $ORIGINAL 1280  768 -o AppIcon_AppStore.jpg
crop $ORIGINAL 2560 1536 -o AppIcon_AppStore@2x.jpg
crop $ORIGINAL  400  240 -o AppIcon_Small.jpg
crop $ORIGINAL  800  480 -o AppIcon_Small@2x.jpg
crop $ORIGINAL 1920 1080 -o Launch_Image.jpg
crop $ORIGINAL 3840 2160 -o Launch_Image@2x.jpg
```

Save with `:wq` and update permissions:
```
$ chmod 755 generate-appletv-images.sh
```

Now, when running the script, it will automatically generate all images at once.

```
$ ./generate-appletv-images.sh original.jpg
🏙 Original image size: 4284x2844
🏙 Resized image size: 2320x720
📁 Resized image saved to: /Users/enekoalonso/dev/eneko/crop/TopShelf_Wide.jpg
🏙 Original image size: 4284x2844
🏙 Resized image size: 4640x1440
📁 Resized image saved to: /Users/enekoalonso/dev/eneko/crop/TopShelf_Wide@2x.jpg
🏙 Original image size: 4284x2844
🏙 Resized image size: 1920x720
📁 Resized image saved to: /Users/enekoalonso/dev/eneko/crop/TopShelf.jpg
🏙 Original image size: 4284x2844
🏙 Resized image size: 3840x1440
📁 Resized image saved to: /Users/enekoalonso/dev/eneko/crop/TopShelf@2x.jpg
🏙 Original image size: 4284x2844
🏙 Resized image size: 1280x768
📁 Resized image saved to: /Users/enekoalonso/dev/eneko/crop/AppIcon_AppStore.jpg
🏙 Original image size: 4284x2844
🏙 Resized image size: 2560x1536
📁 Resized image saved to: /Users/enekoalonso/dev/eneko/crop/AppIcon_AppStore@2x.jpg
🏙 Original image size: 4284x2844
🏙 Resized image size: 400x240
📁 Resized image saved to: /Users/enekoalonso/dev/eneko/crop/AppIcon_Small.jpg
🏙 Original image size: 4284x2844
🏙 Resized image size: 800x480
📁 Resized image saved to: /Users/enekoalonso/dev/eneko/crop/AppIcon_Small@2x.jpg
🏙 Original image size: 4284x2844
🏙 Resized image size: 1920x1080
📁 Resized image saved to: /Users/enekoalonso/dev/eneko/crop/Launch_Image.jpg
🏙 Original image size: 4284x2844
🏙 Resized image size: 3840x2160
📁 Resized image saved to: /Users/enekoalonso/dev/eneko/crop/Launch_Image@2x.jpg
```
