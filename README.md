# phpbrew-tool

# setup.sh

`setup.sh` is a simple script to install phpbrew

# phpbrewswitch

By default, `phpbrew switch` will change the CLI PHP version.

To update Apache, you will have to tell it to use the newly generated `.so` file.

On Ubuntu this file will be created like `/usr/lib/apache2/modules/libphp$VERSION.so`.

For this `.so` file to be generated, you have to build PHP with `apxs2`

```
# Ensure your have installed `apache2-dev`
$ sudo apt install apache2-dev

$ phpbrew install php-7.2.12 +default +apxs2
```

then `phpbrewswitch` this simple script can easily switch your Apache PHP version


## Installation

I have cloned the repo in a goofy git directory on my box,
and set a sym-link in my `$PATH`.

```
# my path
$ ~/bin

# my git dir
$ cd ~/Dropbox/Dev

$ git clone git@github.com:watain666/phpbrew-tool.git

# Set symlink to $PATH
# DON'T USE relative path, use absolute path
# otherwise, the symlink will trigger too many level error
$ ln -s /home/USERNAME/Dropbox/Dev/phpbrew-tool/phpbrewswitch /home/USERNAME/bin/
```


## Usage

Now you can simply typing `phpbrewswitch` to switch your Apache PHP version

```
$ phpbrewswich
```


## Troubleshooting

Make sure you have permissions to execute the script

```
chmod +x phpbrewswitch
```
