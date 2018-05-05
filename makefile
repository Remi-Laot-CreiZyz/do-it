CXX       := g++
LD        := g++

# recursive wildcard definition

rwildcard = $(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

# options definition

OUTDIR	:= out
BUILDDIR	:= build
BUILDDIR_TEST	:= $(BUILDDIR)/test

EXEC      := doit
FLAGS     := -Wall
CXXFLAGS  := $(FLAGS)
CXXFLAGS  += -Wextra -Wwrite-strings -Wno-parentheses
CXXFLAGS  += -Wpedantic -Warray-bounds -Weffc++
LDFLAGS   := $(FLAGS)
INC       := -I inc -I lib
SRC       := $(call rwildcard,src/,*.cpp)
OBJ       := $(SRC:src/%.cpp=$(BUILDDIR)/%.o)
DEPENDENCY_LIST := $(BUILDDIR)/.depend

EXEC_TEST     := all-tests
FLAGS_TEST    := -Wall
CXXFLAGS_TEST := $(FLAGS_TEST)
CXXFLAGS_TEST += -Wextra -Wwrite-strings -Wno-parentheses
LDFLAGS_TEST  := $(FLAGS_TEST)
INC_TEST      := $(INC)
SRC_TEST      := $(wildcard *.cpp)
OBJ_TEST      := $(OBJ) $(SRC_TEST:%.cpp=$(BUILDDIR_TEST)/%.o)
DEPENDENCY_LIST_TEST := $(BUILDDIR_TEST)/.depend

all: dir $(EXEC)

run-all-tests : build_tests
	@$(OUTDIR)/$(EXEC_TEST)

build_tests: dir $(EXEC_TEST)

# auto generate dependencies
# suited for GCC/GXX compilers

# depend: $(DEPENDENCY_LIST)
# 
# $(DEPENDENCY_LIST): $(SRC)
# 	@echo $(SRC)
# 	@rm -f ./$(DEPENDENCY_LIST)
# 	@$(CXX) $(CXXFLAGS) $(INC) -MM $^ -MF ./$(DEPENDENCY_LIST)
# 
# include $(DEPENDENCY_LIST)

# depend: $(DEPENDENCY_LIST_TEST)
# 
# $(DEPENDENCY_LIST_TEST): $(SRC_TEST)
# 	@echo "computing test dependencies :"
# 	$(CXX) $(INC_TEST) -MM -MT $^ -MF $(DEPENDENCY_LIST_TEST)
# 
# include $(DEPENDENCY_LIST_TEST)

# make rules

$(EXEC_TEST): $(BUILDDIR_TEST)/run.o $(OBJ_TEST)
	$(LD) $(LDFLAGS_TEST) -o $(OUTDIR)/$@ $^

$(BUILDDIR_TEST)/%.o: test/%.cpp
	$(CXX) $(CXXFLAGS_TEST) $(INC_TEST) -o $@ -c $<

$(BUILDDIR)/%.o: src/%.cpp
	$(CXX) $(CXXFLAGS) $(INC) -o $@ -c $<

dir:
	@mkdir -p $(BUILDDIR) $(dir $(OBJ)) $(BUILDDIR_TEST) $(dir $(OBJ_TEST)) $(OUTDIR)

.PHONY: clean mrproper

clean:
	@rm -Rf $(BUILDDIR)/* $(BUILDDIR_TEST)/*

mrproper: clean
	@rm -f $(OUTDIR)/*