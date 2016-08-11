program main

    use ini_reader, only: ini_set_filename, ini_get_value

    implicit none

    character str*256

    character(len=:), allocatable :: key, val
    character(len=:), allocatable :: filename

    logical error

    character(20) :: method



    ! Arguments
    if(command_argument_count() == 0) then
        call print_help()
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
            print '(a)', ''
            print '(2a)', 'version ', 0
            stop

        case ('-h', '--help')
            call "heeeelp"
            stop

        case default
            inquire(file=arg, exist=exists)
            if(.not.exists) then
                print '(a)', ''
                print '(2a)', 'Unrecognized option or file: ', arg
                print '(a)', ''
                stop
            else
                filename = arg
            endif

        end select
    enddo

    if(filename=='')then
        call print_error('No input file')
    endif


    !
    ! Input file
    !

    filename = "input.ini"
    call ini_set_filename(filename)
    call ini_get_value('main', 'method', method, error)

    if(error.eqv..true.) then
        write(*,*) "error reading", filename
        stop
    end if

    write(*,*) "using method ", method

end program
