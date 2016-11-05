program main

    use printer, only: print_usage, print_error, print_version
    use ini_reader, only: ini_set_filename, ini_get_value, ini_get_structure
    use mod_coordinates, only: get_coordinates

    implicit none

    character str*256

    character(len=:), allocatable :: key, val
    character(len=:), allocatable :: filename

    character(len=64) :: arg

    logical error
    logical debug
    logical exists
    logical skip

    integer i

    character(20) :: method

    ! Arguments
    if(command_argument_count() == 0) then
        call print_usage
        stop
    endif

    do i = 1, command_argument_count()

        if(skip) then
            skip=.False.
            cycle
        endif

        call get_command_argument(i, arg)

        select case (arg)

        case ('-d', '--debug')
            debug = .True.

        case ('-v', '--version')
            call print_version
            stop

        case ('-h', '--help')
            call print_usage
            stop

        case default
            inquire(file=arg, exist=exists)
            if(.not.exists) then
                call print_error("Unrecognized option or file: " // arg)
                stop
            else
                filename = arg
            endif

        end select
    enddo

    if(filename=='')then
        call print_error("No input file given")
    endif

    ! Read input file

    call ini_set_filename(filename)
    call ini_get_value('main', 'method', method, error)

    if(error .eqv. .true.) then
        write(*,*) "error reading", filename
        stop
    end if

    ! write(*,*) "using method ", method


    ! read coordinates
    call get_coordinates

    ! TODO make all these with nice functions
    ! make R*R matrix
    ! make R^-1 matrix
    ! make R^-2 matrix
    ! make R^-0.5 matrix


    ! TODO Do calculation, and format output
    ! TODO Easily greppable output (pre defined print commands)


    ! TODO print references used in calculation


end program
