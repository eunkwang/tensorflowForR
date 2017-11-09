# 이미지 파일 읽기 함수 생성
# 엔디언 참고 https://ko.wikipedia.org/wiki/엔디언
# MNIST 파일 다운로드 경로 : "MNIST-data"


load_image_file <- function(filename) {
  ret <- list()
  f <- gzfile(filename, "rb")  # 바이너리 파일로 읽기
  readBin(f, "integer", n = 1, size = 4, endian = "big")
  ret$n <- readBin(f, "integer", n = 1, size = 4, endian = "big")
  nrow <- readBin(f, "integer", n = 1, size = 4, endian = "big")
  ncol <- readBin(f, "integer", n = 1, size = 4, endian = "big")
  x <- readBin(f, "integer", n = ret$n * nrow * ncol, size = 1, signed = F)
  ret$x <- matrix(x, ncol = nrow * ncol, byrow = T)
  close(f)
  return(ret)
}

load_label_file <- function(filename) {
  f <- gzfile(filename, "rb")
  readBin(f, "integer", n = 1, size = 4, endian = "big")
  n <- readBin(f, "integer", n = 1, size = 4, endian = "big")
  y <- readBin(f, "integer", n = n, size = 1, signed = F)
  close(f)
  return(y)
}

path <- "MNIST-data"  # MNIST-data 가 저장되어 있는 패스 지정


# 이미지 읽어오기
tr <- file.path(path, "train-images-idx3-ubyte.gz")
ts <- file.path(path, "t10k-images-idx3-ubyte.gz")
tr_l <- file.path(path, "train-labels-idx1-ubyte.gz")
ts_l <- file.path(path, "t10k-labels-idx1-ubyte.gz")


mnist <- list()
mnist$train$x <- load_image_file(tr)
mnist$test$x <- load_image_file(ts)
mnist$train$y <- load_label_file(tr_l)
mnist$test$y <- load_label_file(ts_l)


# 이미지가 뒤집혀 있어서 바로 역정렬
show_digit <- function(arr784, col = gray(12:1 / 12), ...) {
  image(matrix(arr784, nrow = 28)[, 28:1], col = col, ...)
}

for(i in 1:100){
  im_numbers <- mnist$train$x$x[i,]
  show_digit(im_numbers)  
}

