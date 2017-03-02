program main

    use printer, only: print_usage, &
                    print_error, &
                    print_version, &
                    print_result, &
                    print_string, &
                    print_headline

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

    call print_headline(1, "Psi Phi Quantum Mechanics")

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
    write(*,*) " -----------------------------"
    call print_result("Total Energy", 0.000005123D00, "au")

    write(*,*)

    ! After  8 SCF cycles, final energy is
    !
    ! Nuclear Repulsion          0.535345123 au
    ! Electronic Energy         -5.453453544 au
    ! Solvation Energy          -0.004454532 au
    ! Dispersion Correction     -0.000543523 au
    ! Hydrogen Bond Correction  -0.000043234 au
    ! -----------------------------------------
    ! Total Energy (au)         -5.054354354 au
    ! Total Energy (kcal)    -3171.652846325 kcal/mol

    ! Heat of Formation      -4000.454323423 kcal/mol
    ! Solvation Area           167.37        square angstroms 


end program
