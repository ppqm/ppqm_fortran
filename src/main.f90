program main

    use printer, only: &
        print_usage, &
        print_error, &
        print_version, &
        print_result, &
        print_string, &
        print_hr, &
        print_br, &
        print_headline

    use ini_reader, only: &
        ini_set_filename, &
        ini_get_value, &
        ini_get_structure

    use mod_coordinates, only: get_coordinates

    implicit none

    character str*256

    character(len=:), allocatable :: key, val
    character(len=:), allocatable :: filename

    character(len=64) :: arg

    logical :: error
    logical :: debug
    logical :: exists
    logical :: skip

    integer :: i

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

    call print_headline(1, "Psi Phi Quantum Mechanics")

    call print_headline(2, "Calculation details")
    write(*,*) "using method ", method
    write(*,*)


    ! read coordinates
    ! TODO return coordinates, atomtypes (w/ numbers)
    call print_headline(2, "Coordinates")
    call get_coordinates

    ! TODO make all these with nice functions
    ! make R*R matrix
    ! make R^-1 matrix
    ! make R^-2 matrix
    ! make R^-0.5 matrix


    ! TODO Do calculation, and format output
    ! TODO Easily greppable output (pre defined print commands)


    ! TODO print references used in calculation


    ! TODO print energy format
    call print_headline(2,"Energy Calculation")
    call print_result("Nuclear Repulsion", 0.535345123D00, "au")
    call print_result("Electronic Energy", -0.53453123D00, "au")
    call print_result("Solvation Energy", -0.24853123D00, "au")
    call print_result("Dispersion correction", -0.0003123D00, "au")
    call print_result("Hydrogen Bond", -0.1D00, "au")
    call print_hr()
    call print_result("Total Energy", -0.53434123D00, "au")
    call print_result("Total Energy", -0.53434123D00*627.0d0, "kcal/mol")
    call print_br()
    call print_result("Heat of Formation", -235.434123D00, "kcal/mol")
    call print_result("Solvation Surface", 55.0D00, "Square Aangstroem")
    call print_br()


end program
