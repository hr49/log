#include <cstdio>

#include <random>

int main() {
  std::random_device pseudorandom_integer_generator_seeder;
  std::mt19937 pseudorandom_integer_generator(
      pseudorandom_integer_generator_seeder());
  std::uniform_int_distribution<uint_fast8_t> pseudorandom_boolean_generator(
      0, 1);

  {
    constexpr size_t MAXIMUM_LINE_NUMBER = 1'000'000;

    for (size_t line_number = 0; line_number < MAXIMUM_LINE_NUMBER;
         ++line_number) {
      if (pseudorandom_boolean_generator(pseudorandom_integer_generator))
        std::fprintf(stderr, "%20zu\n", line_number);
      else
        std::fprintf(stdout, "%20zu\n", line_number);
    }
  }
}
