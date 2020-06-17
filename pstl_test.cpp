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
