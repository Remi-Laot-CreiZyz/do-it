#include "algebra/vector.hpp"

using namespace algebra;

/* Constructors */
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- //
vector_t::vector_t() : x(0.f), y(0.f), z(0.f) { }
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- //
vector_t::vector_t(const float _x, const float _y, const float _z) : x(_x), y(_y), z(_z) { }
/* Vector operations */
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- //
vector_t vector_t::operator-() const
{
  return vector_t(-x, -y, -z);
}
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- //
vector_t vector_t::operator+(const vector_t & other) const
{
  return vector_t(x + other.x, y + other.y, z + other.z);
}
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- //
vector_t vector_t::operator-(const vector_t & other) const
{
  return vector_t(x - other.x, y - other.y, z - other.z);
}
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- //
bool vector_t::operator==(const vector_t & other) const
{
  return (x == other.x) && (y == other.y) && (z == other.z);
}
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- //
bool vector_t::operator!=(const vector_t & other) const
{
  return (x != other.x) || (y != other.y) || (z != other.z);
}
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- //
vector_t algebra::cross(const vector_t & u, const vector_t & v)
{
  float _x = (u.y * v.z) - (u.z * v.y);
  float _y = (u.z * v.x) - (u.x * v.z);
  float _z = (u.x * v.y) - (u.y * v.x);
  return vector_t(_x, _y, _z);
}
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- //
float algebra::dot(const vector_t & u, const vector_t & v)
{
  return (u.x * v.x) + (u.y * v.y) + (u.z * v.z);
}
/* Scalar operations */
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- //
vector_t vector_t::operator*(const float scalar) const
{
  return vector_t(x * scalar, y * scalar, z * scalar);
}
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- //
vector_t vector_t::operator/(const float scalar) const
{
  return vector_t(x / scalar, y / scalar, z / scalar);
}
/* Tools */
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- //
std::ostream & operator<<(std::ostream & stream, const algebra::vector_t & vector)
{
  return stream << "vector_t::(" << vector.x << ", " << vector.y << ", " << vector.z << ")";
}