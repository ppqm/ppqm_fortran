
module printer

    implicit none

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
        write(*,*) "PPQM"
        write(*,*) "Version 2016-08-11"
        write(*,*) "Commit ab48980f31"
        write(*,*)

    end subroutine


    subroutine print_error(msg)

      implicit none
      character msg*256

      write(*,*)
      write(*,*) "error: ", msg
      write(*,*) "An error has occured we are shutting down"
      write(*,*)

    end subroutine print_error


end module printer
