
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

all: bin/ppqm

# Main fortrain binary

bin/ppqm: $(OBJECTS)
	$(FC) -o $(BINDIR)/ppqm $(OBJECTS)

$(BUILDDIR)/%.o: $(SRCDIR)/%.f90
	cd $(BUILDDIR) && $(FC) ${FCFLAGS} -c ../$<

directories:
	mkdir -p $(BUILDDIR)
	mkdir -p $(BINDIR)

# Python bindings

python-binding: bin/ppqm.so

bin/ppqm.so:
	cd $(BUILDDIR) && \
	f2py -c -m ppqm ../$(SRCDIR)/ppqm_constants.f90
	mv $(BUILDDIR)/ppqm.so $(BINDIR)/ppqm.so

# Administration

clean:
	rm build/*.o
	rm build/*.mod

