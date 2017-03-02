
module printer

    implicit none

    ! TODO decide. all the references here in dictionary or just array ID and link to a folder?

contains

    subroutine print_usage

        use, intrinsic :: iso_fortran_env, only: stdout=>output_unit, stderr=>output_unit

        implicit none

        write(stdout, "(a)")
        write(stdout, "(a)") "usage: ppqm [optional] <input file>"
        write(stdout, "(a)")
        write(stdout, "(a)") "optional arguments:"
        write(stdout, "(a)") "-v, --version         show the version number and exit"
        write(stdout, "(a)") "-h, --help            show this help message and exit"
        write(stdout, "(a)") "-d, --debug           enable debug mode"
        write(stdout, "(a)")

        return

    end subroutine print_usage


    subroutine print_version

        use, intrinsic :: iso_fortran_env, only: stdout=>output_unit, stderr=>output_unit

        implicit none

        write(stdout, "(a)") "Psi Phi Quantum Mechanics (PPQM)"
        write(stdout, "(a)")
        write(stdout, "(a)") "Source Code: github.com/ppqm/ppqm"
        write(stdout, "(a,x,a)") "Version Tag:", "1.2.1"
        write(stdout, "(a,x,a)") "Commit Hash:", "4ba674c"
        write(stdout, "(a)")
        write(stdout, "(a)") "Cite:"
        write(stdout, "(a)") "See log file for the calculation specific reference"
        write(stdout, "(a)")
        write(stdout, "(a)") "Anything else? Read more at www.ppqm.org"
        write(stdout, "(a)")

        return

    end subroutine

    subroutine print_headline(level, headline)

        use, intrinsic :: iso_fortran_env, only: stdout=>output_unit, stderr=>output_unit

        implicit none
        character :: headline*(*)
        integer :: level

        write(stdout,*)
        write(stdout, "(a,x,a)") repeat("#", level), headline
        write(stdout,*)

        return

    end subroutine

    subroutine print_hr()

        use, intrinsic :: iso_fortran_env, only: stdout=>output_unit, stderr=>output_unit

        implicit none
        character :: msg(35)

        msg = repeat("-", 35)

        write(stdout, "(4x,35a)") msg

        return

    end subroutine

    subroutine print_br()

        use, intrinsic :: iso_fortran_env, only: stdout=>output_unit, stderr=>output_unit

        implicit none

        write(stdout, "(a)")

        return

    end subroutine

    subroutine print_string(msg)

        use, intrinsic :: iso_fortran_env, only: stdout=>output_unit, stderr=>output_unit

        implicit none
        character :: msg*(*)

        write(stdout, "(a)") msg

        return

    end subroutine

    subroutine print_result(msg, value, unit)

        use, intrinsic :: iso_fortran_env, only: stdout=>output_unit, stderr=>output_unit

        implicit none
        character :: msg*(*)
        character :: unit*(*)
        double precision :: value

        character(len=30) :: prtmsg

        write(prtmsg, '(a20)') msg

        write(stderr, "(4x,a20,f15.6,1x,a)") adjustl(prtmsg), value, unit

        return

    end subroutine


    subroutine print_warning(msg, subrout)

        use, intrinsic :: iso_fortran_env, only: stdout=>output_unit, stderr=>output_unit

        implicit none
        character :: msg*(*)
        character, optional :: subrout*(*)

        write(stderr, "(3a)") 'ppqm warning: ', subrout, msg

        return

    end subroutine

    subroutine print_error(msg, subrout)

        use, intrinsic :: iso_fortran_env, only: stdout=>output_unit, stderr=>output_unit

        implicit none
        character :: msg*(*)
        character, optional :: subrout*(*)

        write(stderr, "(a)") 'ppqm error: ', msg
        write(stdout, "(a)")
        write(stdout, "(a)") 'An error has occured and computation has stopped.'
        write(stdout, "(a)")

        call exit(1)

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

        use, intrinsic :: iso_fortran_env, only: stdout=>output_unit, stderr=>output_unit

        implicit none

        integer :: rows
        integer :: cols

        integer :: i, j

        double precision, dimension(rows,cols) :: matrix

        do i = 1, rows
            write(stdout, "(10f12.6)")  matrix(i,1:cols)
        end do

    end subroutine


    subroutine print_triangular(matrix, rows, accuracy) ! tri-shape, matrix, accuracy

        use, intrinsic :: iso_fortran_env, only: stdout=>output_unit, stderr=>output_unit

        implicit none

        double precision, dimension(:) :: matrix
        integer :: rows
        integer, optional :: accuracy

        integer :: i, j, idx

        do i = 1, rows
            idx = (i*i+i)/2
            do j = idx-i+1, idx
                write(stdout, "(10f12.6)", advance='no')  matrix(j)
            end do
            ! next line
            write(stdout, "(a)")
        end do

    end subroutine


end module printer
