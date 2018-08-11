#include <cstdio>

#include <random>

int main() {
  std::random_device PseudorandomIntegerGeneratorSeeder;
  std::mt19937 PseudorandomIntegerGenerator(
      PseudorandomIntegerGeneratorSeeder());
  std::uniform_int_distribution<uint_fast8_t> PseudorandomBooleanGenerator(0u,
                                                                           1u);

  /*
   * `1'000'000` is inspired by the default of the same value of the argument
   * `number` to Python's `timeit.timeit`.
   */
  constexpr size_t NUMBER_OF_LINES = 1'000'000;

  for (size_t NumberOfRemainingLines = NUMBER_OF_LINES;
       NumberOfRemainingLines > 0u; --NumberOfRemainingLines) {
    if (PseudorandomBooleanGenerator(PseudorandomIntegerGenerator))
      std::fprintf(stderr, "%20zu\n", NumberOfRemainingLines);
    else
      std::fprintf(stdout, "%20zu\n", NumberOfRemainingLines);
  }
}
