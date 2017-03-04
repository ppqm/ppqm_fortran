
SRC_DIR = src
BUILD_DIR = build
BIN_DIR = bin
BIN = ppqm

# Find all .f90 files and make a .o list
SRC_FILES = $(wildcard $(SRC_DIR)/*.f90)
OBJ_FILES = $(addprefix $(BUILD_DIR)/,$(notdir $(SRC_FILES:.f90=.o)))

TEST_PY_FILES = $(wildcard tests/*.py)
TEST_FILES = $(addprefix tests/,$(notdir $(TEST_PY_FILES:.py=.test)))

FC = gfortran
FCFLAGS =


all: build bin bin/ppqm


# Main fortrain binary

$(BIN_DIR)/$(BIN): $(OBJ_FILES)
	$(FC) -o $@ $(OBJ_FILES)

# Dependencies
$(SRC_DIR)/main.f90: $(BUILD_DIR)/ppqm_printer.o $(BUILD_DIR)/ini_reader.o $(BUILD_DIR)/coordinates.o
$(SRC_DIR)/coordinates.f90: $(BUILD_DIR)/ppqm_printer.o $(BUILD_DIR)/ini_reader.o

# Compiler
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.f90
	cd $(BUILD_DIR) && $(FC) ${FCFLAGS} -c ../$<


# Python bindings

python: $(OBJ_FILES) bin/ppqm.so

bin/ppqm.so:
	cd $(BUILD_DIR) && \
	f2py -c -m ppqm ../$(SRC_DIR)/ppqm_constants.f90
	mv $(BUILD_DIR)/ppqm.so $(BIN_DIR)/ppqm.so


# Testing ppqm


test: $(TEST_FILES)

tests/%.test:
	@python ${@:.test=.py} > ${@:.test=.out}
	@./check_test ${@:.test=.out}


# Administration

clean:
	rm build/*.o
	rm build/*.mod

clean_all:
	rm -r build
	rm -r bin

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)


