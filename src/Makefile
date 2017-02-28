
all:
	gfortran \
		ini_reader.f90 \
		coordinates.f90 \
		ppqm_constants.f90 \
		ppqm_printer.f90 \
		main.f90 \
		-o ../bin/ppqm

test:
	cd ../test && ./test_all


clean:
	rm *.mod

