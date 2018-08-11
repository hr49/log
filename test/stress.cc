#include <cstdio>

#include <limits>
#include <random>
#include <string>

int main() {
  std::random_device PseudorandomIntegerGeneratorSeeder;
  std::mt19937 PseudorandomIntegerGenerator{
      PseudorandomIntegerGeneratorSeeder()};
  std::uniform_int_distribution<uint_fast8_t> PseudorandomBooleanGenerator{0u,
                                                                           1u};
  typedef size_t LineIndexType;
  const auto Format{
      "%" + std::to_string(std::numeric_limits<LineIndexType>::digits10) +
      "zu\n"};
  const auto FormatCStr{Format.c_str()};

  /*
   * `1'000'000` is inspired by the default of the same value of the parameter
   * `number` to Python's function `timeit.timeit`.
   */
  constexpr LineIndexType NUMBER_OF_LINES{1'000'000};

  for (LineIndexType LineIndex{0u}; LineIndex < NUMBER_OF_LINES; ++LineIndex) {
    if (PseudorandomBooleanGenerator(PseudorandomIntegerGenerator))
      std::fprintf(stderr, FormatCStr, LineIndex);
    else
      std::fprintf(stdout, FormatCStr, LineIndex);
  }
}
