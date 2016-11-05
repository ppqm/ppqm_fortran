
module printer

    implicit none


    ! TODO /data/ all the references here
    ! dictionary or just array ID?

contains

    subroutine print_usage

        implicit none

        write(*,*) ""
        write(*,*) "usage:"
        write(*,*) "ppqm [-h] [-d] <input file>"
        write(*,*)
        write(*,*) "optional arguments:"
        write(*,*) "-v, --version         show the version number and exit"
        write(*,*) "-h, --help            show this help message and exit"
        write(*,*) "-d, --debug           enable debug mode"
        write(*,*)

    end subroutine print_usage


    subroutine print_version

        implicit none

        write(*,*)
        write(*,*) "Psi Phi Quantum Mechanics (PPQM)"
        write(*,*) "www.ppqm.org"
        write(*,*) "www.github.com/ppqm/ppqm"
        write(*,*)
        write(*,*) "Version: ", "2016-08-11"
        write(*,*) "Tag: ", "0.2"
        write(*,*) "Commit: ", "ab48980f31"
        write(*,*)
        write(*,*) "Cite:"
        write(*,*) "See log file for the specific calculation"
        write(*,*)

    end subroutine


    subroutine print_error(msg)

      implicit none
      character msg*(*)

      print '(a)', ''
      print '(a)', 'ppqm error: ', msg
      print '(a)', ''
      print '(a)', 'An error has occured we are shutting down'
      print '(a)', ''

    end subroutine print_error


    subroutine load_references()

        implicit none
        character lib_path*256

        ! TODO add all references to a dictionary
        ! with
        ! reference('10.7717/peerj.449') =  "Kromann JC, Christensen AS, Steinmann C, Korth M, Jensen JH. (2014) &
        ! A third-generation dispersion and third-generation hydrogen bonding corrected PM6 method: PM6-D3H+. PeerJ 2:e449 &
        ! https://doi.org/10.7717/peerj.449"

    end subroutine load_references


    subroutine add_reference(reference, reason)

        implicit none
        character reference*256
        character reason*256

        ! TODO add reference based on name
        ! TODO make DOI database that prints out all the reference needed

    end subroutine add_reference


    subroutine print_references(syntax)

        !
        ! Usage:
        !     print_references('latex')
        !     print_references('litterature')
        !

        implicit none

        character syntax*256

        ! TODO foreach references
        ! TODO      print doi syntax

    end subroutine


    subroutine print_matrix(matrix, rows, cols)

        implicit none

        integer :: rows
        integer :: cols

        integer :: i, j

        double precision, dimension(rows,cols) :: matrix

        do i = 1, rows
            write(*, "(10f10.5)")  matrix(i,1:cols)
        end do

    end subroutine


    subroutine print_triangular(matrix, rows) ! tri-shape, matrix, accuracy

        implicit none

        double precision, dimension(:) :: matrix
        integer :: rows
        integer :: i, j, idx

        ! write(*, "(10f10.5)", advance='no')  matrix(idx-i+1:idx)

        do i = 1, rows
            idx = (i*i+i)/2
            do j = idx-i+1, idx
                write(*, "(10f10.5)", advance='no')  matrix(j)
            end do
            write(*,*) ! new line
        end do


    end subroutine


end module printer
