program main

    use ini_reader, only: ini_set_filename, ini_get_value

    implicit none

    character str*256

    character(len=:), allocatable :: key, val
    character(len=:), allocatable :: filename

    logical error

    ! What SQM methods are we using today?
    character(20) :: method

    filename = "input.ini"
    call ini_set_filename(filename)
    call ini_get_value('main', 'method', method, error)

    if(error.eqv..true.) then
        write(*,*) "error reading", filename
        stop
    end if

    write(*,*) "using method ", method

end program
