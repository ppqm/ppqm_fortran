
module ini_reader

    implicit none

    character ini_filename*256
    data ini_filename /'input.ini'/

    logical initialized
    data initialized /.false./

    integer num_lines
    data num_lines /0/

    character lines(100)*256

    ! Periodic table
    character(len=2) :: element(94)
    data element /'h ','he', &
    & 'li','be','b ','c ','n ','o ','f ','ne', &
    & 'na','mg','al','si','p ','s ','cl','ar', &
    & 'k ','ca','sc','ti','v ','cr','mn','fe','co','ni','cu', &
    & 'zn','ga','ge','as','se','br','kr', &
    & 'rb','sr','y ','zr','nb','mo','tc','ru','rh','pd','ag', &
    & 'cd','in','sn','sb','te','i ','xe', &
    & 'cs','ba','la','ce','pr','nd','pm','sm','eu','gd','tb','dy', &
    & 'ho','er','tm','yb','lu','hf','ta','w ','re','os','ir','pt', &
    & 'au','hg','tl','pb','bi','po','at','rn', &
    & 'fr','ra','ac','th','pa','u ','np','pu'/

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

            end if

        end do

        if(value .eq. '') then
            error = .true.
        end if

    end subroutine


    subroutine ini_get_structure(section, error, coordinates, atoms, num_atoms)

        implicit none

        logical, intent(out) :: error
        double precision, dimension(:,:), allocatable, intent(out) :: coordinates
        character(len=2), dimension(:), allocatable, intent(out) :: atoms

        character section*(*)

        integer i, j, idx
        logical found_section, found_keyword

        character(len=2) :: label
        double precision :: x, y, z

        integer, intent(out) :: num_atoms
        integer :: idx_coordinates
        integer :: stat

        error = .false.
        found_section = .false.
        num_atoms = 0
        idx_coordinates = -1

        do i=1, num_lines
            if(lines(i)(1:1) .eq. '[') then

                idx = index(lines(i), '[' // trim(section) // ']', .true.)

                if (idx > 0) then
                    found_section = .true.
                    idx_coordinates = i
                end if
            else
                if(found_section .eqv. .false.) cycle
                if(lines(i)(1:1) .eq. ';') cycle
                if(lines(i).eq."") cycle
                num_atoms = num_atoms + 1
            end if
        end do ! num_lines

        if(idx_coordinates.eq.-1.or.num_atoms.eq.0) then
            write(*,*) "Error finding coordinats"
            stop
        end if

        ! allocate coordinates
        allocate(coordinates(num_atoms, 3))
        allocate(atoms(num_atoms))

        do i=1, num_atoms

            j = i + idx_coordinates

            read(lines(j), *, iostat=stat) label, x, y, z

            if (stat.ne.0) then
                write(*,*) "Error reading line:"
                write(*,*) lines(j)
            end if

            atoms(i) = label
            coordinates(i, 1) = x
            coordinates(i, 2) = y
            coordinates(i, 3) = z

        end do

    end subroutine


end module ini_reader

