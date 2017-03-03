
BUILDDIR = build

OBJECTS = \
		  $(BUILDDIR)/ini_reader.o \
		  $(BUILDDIR)/ppqm_constants.o \
		  $(BUILDDIR)/ppqm_printer.o \
		  $(BUILDDIR)/coordinates.o \
		  $(BUILDDIR)/main.o \

FC = gfortran
FCFLAGS =
SRCDIR = src
BINDIR = bin

all: $(OBJECTS)
	$(FC) -o $(BINDIR)/ppqm $(OBJECTS)

$(BUILDDIR)/%.o: $(SRCDIR)/%.f90
	$(FC) ${FCFLAGS} -c $< -o $@

directories:
	mkdir -p $(BUILDDIR)
	mkdir -p $(BINDIR)

python:
	f2py -c -m $(BUILDIR)/ppqm $(SCRDIR)/ppqm_constants.f90

clean:
	rm build/*.o

