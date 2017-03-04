
SRC_DIR = src
BUILD_DIR = build
BIN_DIR = bin
BIN = ppqm

# Find all .f90 files and make a .o list
SRC_FILES = $(wildcard $(SRC_DIR)/*.f90)
OBJ_FILES = $(addprefix $(BUILD_DIR)/,$(notdir $(SRC_FILES:.f90=.o)))

TEST_PY_FILES = $(wildcard tests/*.py)
TEST_FILES = $(notdir $(TEST_PY_FILES:.py=.test))

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

python: ${BIN_DIR} ${BUILD_DIR} $(OBJ_FILES) bin/ppqm.so tests/ppqm.so

bin/ppqm.so:
	cd $(BUILD_DIR) && \
	f2py -c -m ppqm ../$(SRC_DIR)/ppqm_constants.f90
	mv $(BUILD_DIR)/ppqm.so $(BIN_DIR)/ppqm.so

tests/ppqm.so:
	ln -rs $(BIN_DIR)/ppqm.so tests/ppqm.so


# Testing ppqm


test: $(TEST_FILES)

%.test:
	@./tests/check_test tests/${@}


# Administration

clean:
	rm -f build/*.o
	rm -f build/*.mod
	rm -f tests/*.out

clean_all:
	rm -fr build
	rm -fr bin
	rm -f tests/*.out

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)


