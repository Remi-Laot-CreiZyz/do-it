CXX       := g++
LD        := g++

# recursive wildcard definition

rwildcard = $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))

# options definition

EXEC      := doit
FLAGS     := -Wall
CXXFLAGS  := $(FLAGS)
CXXFLAGS  += -Wextra -Wwrite-strings -Wno-parentheses
CXXFLAGS  += -Wpedantic -Warray-bounds -Weffc++
LDFLAGS   := $(FLAGS)
INC       := -I inc -I lib
SRC       := $(call, rwildcard, src/, *.cpp)
OBJ       := $(SRC:src/%.cpp=tmp/src/%.o)
DEPENDENCY_LIST := $(EXEC).depend

EXEC_TEST     := test
FLAGS_TEST    := -Wall
CXXFLAGS_TEST := $(FLAGS_TEST)
CXXFLAGS_TEST += -Wextra -Wwrite-strings -Wno-parentheses
LDFLAGS_TEST  := $(FLAGS_TEST)
INC_TEST      := $(INC)
SRC_TEST      := $(wildcard test/*.cpp)
OBJ_TEST      := $(SRC_TEST:test/%.cpp=tmp/test/%.o)
DEPENDENCY_LIST_TEST := $(EXEC_TEST).depend

# auto generate dependencies
# suited for GCC/GXX compilers

depend: $(DEPENDENCY_LIST)

$(DEPENDENCY_LIST): $(SRC)
	echo $(SRC)
	@rm -f ./$(DEPENDENCY_LIST)
	@$(CXX) $(CXXFLAGS) $(INC) -MM $^ -MF ./$(DEPENDENCY_LIST)

include $(DEPENDENCY_LIST)

dependtest: $(DEPENDENCY_LIST_TEST)

$(DEPENDENCY_LIST_TEST): $(SRC_TEST)
	echo $(SRC_TEST)
	@rm -f ./$(DEPENDENCY_LIST_TEST)
	@$(CXX) $(CXXFLAGS_TEST) $(INC_TEST) -MM $^ -MF ./$(DEPENDENCY_LIST_TEST)

include $(DEPENDENCY_LIST_TEST)

clean:
	rm -f *.depend
	rm -Rf tmp/*