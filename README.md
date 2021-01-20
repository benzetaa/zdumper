# Git Tool 

You can use this tool to find websites with their .git repository available to the public

``` 
###########
# Finder is part of https://github.com/CapuzSec/Benzeta-Dumper/
#
# Developed and maintained by @CapuzSec 
#
# Use at your own risk. Usage might be illegal in certain circumstances.
# Only for educational purposes!
###########
```

### Dependencies - httpx / jq

The installation is easy. You can download the pre-built binaries for your platform from the [Releases](https://github.com/projectdiscovery/httpx/releases/) page. Extract them using tar, move it to your `$PATH`and you're ready to go.

```sh
Download latest binary from https://github.com/projectdiscovery/httpx/releases

▶ tar -xvf httpx-linux-amd64.tar
▶ mv httpx-linux-amd64 /usr/local/bin/httpx
▶ httpx -h
``` 

To install jq

```
sudo apt install jq
```



### Install 

```sh
git clone https://github.com/CapuzSec/Benzeta-Dumper.git
cd Benzeta-Dumper
chmod +x httpx-domains-git.sh

```


### Usage 

```
$ ./domains-git.sh [TARGET.COM] 
```

![Benzeta-Dumper](https://github.com/CapuzSec/Benzeta-Dumper/blob/master/git-dumper.png)
