#include "algebra/tools.hpp"

bool algebra::fequals(const float a, const float b)
{
  return (a - DOIT_ALGEBRA_FLOAT_PRECISION) < b && (a + DOIT_ALGEBRA_FLOAT_PRECISION) > b;
}