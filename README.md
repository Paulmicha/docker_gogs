docker_gogs
===========

Testing phusion/baseimage:0.9.12 with gogits/gogs:0.4.2

### Simple test :

```
git clone https://github.com/Paulmicha/docker_gogs.git
cd docker_gogs/
docker build -t="paulmicha/docker_gogs" .
```

### Run :
```
docker run --name="gogs" -d -p 3000:3000 paulmicha/docker_gogs
```

### Run + allow ssh-ing inside container :
```
docker run --name="gogs" -d -p 3000:3000 paulmicha/docker_gogs /sbin/my_init --enable-insecure-key
```