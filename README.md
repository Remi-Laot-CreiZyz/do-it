# What is do-it ?
*do-it* is a long-term personal project I undertook to improve my (modern) C++ and applied mathematic skills. I aim at developing a Tactical RPG game using Vulkan.

# Build the project

## Makefile rules

I maintain a makefile for the project. You can build or run do-it using :
```
make
```
```
make run
```
Test cases based on CATCH are developed in the 'test' folder and can be built using or run :
```
make tests
```
```
make run-tests
```

## Dependencies
- Catch (https://github.com/catchorg/Catch2) : a header-only unit test framework for C++. As the Catch team provides a packed header, I included it to the repository (lib/catch) for more convenience.
