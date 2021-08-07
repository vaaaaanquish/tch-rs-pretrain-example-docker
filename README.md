# tch-rs-pretrain-example-docker
Docker for PyTorch rust bindings `tch-rs`. Example of pretrain model.

Docker files support the following

 - install libtorch (1.9.0)
 - download pretrain model weight file (resnet18)
 - example script for model predict


# Usage

Please set `./img/example.jpeg`

```
docker build -t tch .
docker run -it tch

# cargo run
```

output example:
```
beagle                                             15.37%
golden retriever                                   11.95%
Labrador retriever                                 10.32%
Cardigan, Cardigan Welsh corgi                      8.50%
Brittany spaniel                                    4.88%
```


# Background

I wanted to do Embedding. But it looks like we need to implement `register_forward_hook` in `tch`.

https://github.com/LaurentMazare/tch-rs/issues/218

So, I'm publishing it as an Example of pretrain model predict.
