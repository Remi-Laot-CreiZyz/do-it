#ifndef _DOIT_ALGEBRA_VECTOR_
#define _DOIT_ALGEBRA_VECTOR_

#include <ostream>

/**
 * Immutable class for vectors
 * Author: Rémi Laot
 * Date: 29/04/2018
 **/

namespace algebra
{
  class vector_t
  {
    public:
      const float x, y, z;

      vector_t();
      vector_t(const float x, const float y, const float z);

      /* Vector operations */
      vector_t operator-() const;
      vector_t operator+(const vector_t & other) const;
      vector_t operator-(const vector_t & other) const;
      bool operator==(const vector_t & other) const;
      bool operator!=(const vector_t & other) const;
      friend vector_t cross(const vector_t & u, const vector_t & v);
      friend float dot(const vector_t & u, const vector_t & v);

      /* Scalar operations */
      vector_t operator*(const float scalar) const;
      vector_t operator/(const float scalar) const;

      /* Tools */
      friend std::ostream & operator<<(std::ostream & stream, const vector_t & vector);
  };

  extern vector_t cross(const vector_t & u, const vector_t & v);
  extern float dot(const vector_t & u, const vector_t & v);
  extern std::ostream & operator<<(std::ostream & stream, const algebra::vector_t & vector);
}
      
#endif