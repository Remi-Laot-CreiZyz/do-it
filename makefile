CXX	:= g++
LD	:= g++
BUILDDIR	:= build

# recursive wildcard definition
rwildcard = $(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

# program build configuration
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
BUILDSUBDIR 	:= $(BUILDDIR)/doit
OBJDIR				:= $(BUILDSUBDIR)/obj
OUTDIR				:= $(BUILDSUBDIR)/bin

EXEC			:= $(OUTDIR)/doit
FLAGS			:= -Wall
CXXFLAGS	:= $(FLAGS)
CXXFLAGS	+= -Wextra -Wwrite-strings -Wno-parentheses
CXXFLAGS	+= -Wpedantic -Warray-bounds -Weffc++
LDFLAGS		:= $(FLAGS)

INC				:= -I inc -I lib
SRC				:= $(call rwildcard,src/,*.cpp)
OBJ				:= $(SRC:src/%.cpp=$(OBJDIR)/%.o)
DEP				:= $(SRC:src/%.cpp=$(OBJDIR)/%.d)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

# test build configuration
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
BUILDSUBDIR_TEST	:= $(BUILDDIR)/test
OBJDIR_TEST 			:= $(BUILDSUBDIR_TEST)/obj
OUTDIR_TEST 			:= $(BUILDSUBDIR_TEST)/bin

EXEC_TEST			:= $(OUTDIR_TEST)/all-tests
FLAGS_TEST		:= -Wall
CXXFLAGS_TEST	:= $(FLAGS_TEST)
CXXFLAGS_TEST	+= -Wextra -Wwrite-strings -Wno-parentheses
LDFLAGS_TEST	:= $(FLAGS_TEST)

INC_TEST			:= $(INC)
SRC_TEST			:= $(wildcard test/*.cpp)
OBJ_TEST			:= $(OBJ) $(SRC_TEST:test/%.cpp=$(OBJDIR_TEST)/%.o)
DEP_TEST			:= $(SRC_TEST:test/%.cpp=$(OBJDIR_TEST)/%.d)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

.PHONY: all tests dir run run-tests clean mrproper

# Commands
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #	
all: dir $(EXEC)

tests: dir $(EXEC_TEST)

run: all
	$(EXEC)

run-tests: tests
	$(EXEC_TEST)

clean:
	@rm -Rf $(OBJDIR)/* $(OBJDIR_TEST)/*

mrproper: clean
	@rm -Rf $(OUTDIR)/* $(OUTDIR_TEST)/*
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #	

# Make rules
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #
$(EXEC_TEST): $(OBJDIR_TEST)/run.o $(OBJ_TEST)
	@mkdir -p $(dir $@)
	$(LD) $(LDFLAGS_TEST) -o $@ $^

$(OBJDIR)/%.o: src/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(INC) -o $@ -c $<

$(OBJDIR)/%.d : src/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(INC) $(CXXFLAGS) -MM -MF $@ -MT $(@:%.d=%.o) $<

$(OBJDIR_TEST)/%.o: test/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS_TEST) $(INC_TEST) -o $@ -c $<

$(OBJDIR_TEST)/%.d : test/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(INC_TEST) $(CXXFLAGS_TEST) -MM -MF $@ -MT $(@:%.d=%.o) $<
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - #

MAKEFILE_TARGETS_WITHOUT_INCLUDE := clean mrproper

ifeq ($(filter $(MAKECMDGOALS),$(MAKEFILE_TARGETS_WITHOUT_INCLUDE)),)
  -include $(DEP) $(DEP_TEST)
endif