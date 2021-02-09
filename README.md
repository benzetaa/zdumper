# Git Tool 

You can use this tool to find websites with their .git repository available to the public

``` 
###########
# Finder is part of https://github.com/CapuzSec/zdumper
#
# Developed and maintained by @benzetaa 
#
# Use at your own risk. Usage might be illegal in certain circumstances.
# Only for educational purposes!
###########
```

### Dependencies - httpx / jq

The installation is easy. You can download the pre-built binaries for your platform from the [Releases](https://github.com/projectdiscovery/httpx/releases/) page. Extract them using tar, move it to your `$PATH`and you're ready to go.

```sh
Download latest binary from https://github.com/projectdiscovery/httpx/releases

GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx
``` 

To install jq

```
sudo apt install jq
```

To install subfinder 

```
Github: https://github.com/tomnomnom/assetfinder

GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
```

To install assetfinder

```
Github: https://github.com/projectdiscovery/subfinder
go get -u github.com/tomnomnom/assetfinder
```


### Install 

```sh
git clone https://github.com/CapuzSec/zdumper.git
cd zdumper
chmod +x zdumper.sh

```


### Usage 

```
$ ./zdumper.sh -h
```

![Benzeta-Dumper](https://github.com/CapuzSec/Benzeta-Dumper/blob/master/git-dumper.png)
