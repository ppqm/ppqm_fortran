
module mod_coordinates

    use printer, only: print_matrix
    use ini_reader, only: ini_get_structure

    implicit none

    integer :: num_atoms

    double precision, dimension(:,:), allocatable :: coordinates
    character(len=2), dimension(:), allocatable :: atoms

    logical :: error

contains

    subroutine get_coordinates

        implicit none

        call ini_get_structure('coordinates', error, coordinates, atoms, num_atoms)

        write(*,*) "Coordinates:"

        call print_matrix(coordinates, num_atoms, 3)

    end subroutine get_coordinates


    subroutine set_distance_matrix(coordinates, num_atoms, distance_matrix)

        implicit none

        integer :: num_atoms
        integer :: lower_tri_size

        double precision, dimension(num_atoms, 3) :: coordinates
        double precision, dimension(:), allocatable :: distance_matrix

        ! sizex = size(M, dim=1)

        lower_tri_size = (num_atoms*num_atoms+num_atoms)/2

        allocate(distance_matrix(lower_tri_size))



    end subroutine set_distance_matrix


    subroutine del_distance_matrix()

        implicit none

    end subroutine del_distance_matrix


    subroutine del_coordinates()

        implicit none

        deallocate(coordinates)
        deallocate(atoms)

    end subroutine del_coordinates


end module mod_coordinates


