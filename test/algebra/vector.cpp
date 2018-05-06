#include "catch/catch.hpp"
#include "algebra/vector.hpp"

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

  float one = (1.f / 3.f) * 3.f;
  REQUIRE(vector_t(one,one,one) == vector_t(1.f,1.f,1.f));
  
  float notOne = 0.33f * 3.f;
  REQUIRE(vector_t(notOne,notOne,notOne) != vector_t(1.f,1.f,1.f));
}

TEST_CASE("vector inversion", "[vector]")
{
  REQUIRE((-(-vector_t(1.f,1.f,1.f))) == vector_t(1.f,1.f,1.f));
  REQUIRE((-vector_t(1.f,1.f,1.f)) == vector_t(-1.f,-1.f,-1.f));
  REQUIRE((-vector_t(-1.f,-1.f,-1.f)) == vector_t(1.f,1.f,1.f));
}

TEST_CASE("vector addition", "[vector]")
{
  REQUIRE((vector_t(1.f,2.f,3.f) + vector_t(1.f,2.f,3.f)) == vector_t(2.f,4.f,6.f));
  REQUIRE((vector_t(-1.f,-2.f,-3.f) + vector_t(1.f,2.f,3.f)) == vector_t(0.f,0.f,0.f));
  REQUIRE((vector_t(-1.f,-2.f,-3.f) + vector_t(-1.f,-2.f,-3.f)) == vector_t(-2.f,-4.f,-6.f));
}

TEST_CASE("vector substraction", "[vector]")
{
  REQUIRE((vector_t(1.f,2.f,3.f) - vector_t(1.f,2.f,3.f)) == vector_t(0.f,0.f,0.f));
  REQUIRE((vector_t(-1.f,-2.f,-3.f) - vector_t(1.f,2.f,3.f)) == vector_t(-2.f,-4.f,-6.f));
  REQUIRE((vector_t(-1.f,-2.f,-3.f) - vector_t(-1.f,-2.f,-3.f)) == vector_t(0.f,0.f,0.f));
}