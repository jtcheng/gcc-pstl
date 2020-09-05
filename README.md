从 `C++17` 开始并行 `STL` 就是标准库的一部分了，但是到目前为止，三大编译器中只有 `MSVC` 实现了并行 `STL`，`GCC` 配合因特尔的 `TBB` 也是可以工作的。为了方便集成与测试，我这里做了个 `pstl` 的 `docker` 镜像。

## 1. Build the pstl docker image

```bash
$ git clone https://github.com/jtcheng/gcc-pstl.git
$ make

# cleanup the docker image
$ make clean
```

## 2. Start a pstl docker container

```bash
$ cat pstl.sh
#!/bin/bash
# startup gcc container with pstl support
set -e

LOCAL_SRC_ROOT=`pwd`
CPSTL_SRC_ROOT=/root/src
IMAGE=jtcheng/pstl:v0.1

docker run -it --rm -h pstl -v $LOCAL_SRC_ROOT:$CPSTL_SRC_ROOT -w $CPSTL_SRC_ROOT $IMAGE /bin/bash

$ ./pstl.sh
```

## 3. Test gcc with tbb to support pstl

```bash
root@pstl:~/src# cat pstl_test.cpp
#include <algorithm>
#include <execution>
#include <vector>
#include <iterator>
#include <iostream>

int main(){
  std::vector<int> vi{3, 2, 1, 5, 4, 0};
  std::sort(std::execution::par, vi.begin(), vi.end());
  std::copy(vi.begin(), vi.end(), std::ostream_iterator<int>(std::cout, " "));
  std::cout << std::endl;

  return 0;
}

root@pstl:~/src# g++ pstl_test.cpp -std=c++17 -ltbb
root@pstl:~/src# ./a.out
0 1 2 3 4 5
root@pstl:~/src#
```
