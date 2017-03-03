
SRC_DIR = src
BUILD_DIR = build
BIN_DIR = bin

SRC_FILES = $(wildcard $(SRC_DIR)/*.f90)
OBJ_FILES = $(addprefix $(BUILD_DIR)/,$(notdir $(SRC_FILES:.f90=.o)))

OBJECTS = \
		  $(BUILDDIR)/ini_reader.o \
		  $(BUILDDIR)/ppqm_constants.o \
		  $(BUILDDIR)/ppqm_printer.o \
		  $(BUILDDIR)/coordinates.o \
		  $(BUILDDIR)/main.o \

FC = gfortran
FCFLAGS =

all: directories bin/ppqm

# Main fortrain binary

bin/ppqm: $(OBJ_FILES)
	$(FC) -o $(BIN_DIR)/ppqm $(OBJ_FILES)

# Dependencies
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

# Administration

clean:
	rm build/*.o
	rm build/*.mod

clean_all:
	rm -r build
	rm -r bin

directories:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(BIN_DIR)

