
module ini_reader

    implicit none

    REAL, PARAMETER :: Pi = 3.1415927
    REAL :: radius

    character ini_filename*256
    data ini_filename /'input.ini'/

    logical initialized
    data initialized /.false./

    integer num_lines
    data num_lines /0/

    character lines(100)*256

contains

    subroutine ini_load_file()
        implicit none

        character line*256
        integer io

        num_lines = 0
        open(33, file=ini_filename)

        do
            read(33, '(A)', iostat=io) line
            if (io<0) exit
            if (io>0) stop 'Problem reading INI file'
            ! Add to lines
            num_lines = num_lines + 1
            lines(num_lines) = line
        end do

        close(unit=33)
        initialized = .true.

        write(*,*) "init"

    end subroutine


    subroutine ini_set_filename(filename)
        implicit none
        character filename*(*)

        if(initialized .eqv. .true.) then
            if(ini_filename .ne. filename) then
                ini_filename = filename
                call ini_load_file()
            end if
        else
            ini_filename = filename
            call ini_load_file()
        end if


    end subroutine ini_set_filename


    subroutine ini_get_value(section, keyword, value, error)
        implicit none

        logical, intent(out) :: error

        character section*(*)
        character keyword*(*)
        character value*(*)

        integer i, idx
        logical found_section, found_keyword

        error = .false.
        found_section = .false.

        value = ""

        ! Look for section
        do i=1, num_lines

            if(lines(i)(1:1) .eq. '[') then

                idx = index(lines(i), '[' // trim(section) // ']', .true.)

                if (idx > 0) then
                    found_section = .true.
                else
                    found_section = .false.
                end if

            else

                ! TODO ignore all comments
                ! - beginning of line
                ! - after variables

                ! TODO right now it will also response if value = keyword

                ! TODO trim so it is possible to do
                ! method=pm6
                ! method = pm6

                if(found_section .eqv. .false.) then
                    cycle
                end if

                if(lines(i)(1:1) .eq. ';') then
                    cycle
                end if

                idx = index(lines(i), keyword, .true.)

                if (idx > 0) then
                    idx = index(lines(i), '=')
                    value = lines(i)(idx+1:)
                    exit
                end if

                write(*,*) value

            end if

        end do

        if(value .eq. '') then
            error = .true.
        end if

    end subroutine

end module ini_reader

