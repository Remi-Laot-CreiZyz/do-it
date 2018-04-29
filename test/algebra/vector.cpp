#include "extern/catch.hpp"
#include "src/algebra/vector.hpp"

using namespace algebra;

TEST_CASE("vector equality", "[vector]")
{
  REQUIRE(vector_t(0.f,0.f,0.f) == vector_t(0.f,0.f,0.f));

  REQUIRE(vector_t(1.f,0.f,0.f) != vector_t(0.f,0.f,0.f));
  REQUIRE(vector_t(1.f,1.f,0.f) != vector_t(0.f,0.f,0.f));
  REQUIRE(vector_t(1.f,1.f,1.f) != vector_t(0.f,0.f,0.f));
  REQUIRE(vector_t(0.f,1.f,1.f) != vector_t(0.f,0.f,0.f));
  REQUIRE(vector_t(0.f,0.f,1.f) != vector_t(0.f,0.f,0.f));

  REQUIRE(vector_t(0.f,0.f,0.f) != vector_t(1.f,0.f,0.f));
  REQUIRE(vector_t(0.f,0.f,0.f) != vector_t(1.f,1.f,0.f));
  REQUIRE(vector_t(0.f,0.f,0.f) != vector_t(1.f,1.f,1.f));
  REQUIRE(vector_t(0.f,0.f,0.f) != vector_t(0.f,1.f,1.f));
  REQUIRE(vector_t(0.f,0.f,0.f) != vector_t(0.f,0.f,1.f));
}