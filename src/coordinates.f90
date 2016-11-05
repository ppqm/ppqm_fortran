
module mod_coordinates

    use printer, only: print_matrix, print_triangular
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

        call print_matrix(coordinates, num_atoms, 3)
        call set_distance_matrix(coordinates)

    end subroutine get_coordinates


    subroutine set_distance_matrix(coordinates)

        implicit none

        integer :: d
        integer :: lower_size

        double precision, dimension(:, :) :: coordinates
        double precision, dimension(:), allocatable :: distance_matrix

        double precision :: distance
        integer :: i, j, idx

        ! Dimension (num of atoms)
        d = size(coordinates, dim=1)
        lower_size = (d*d+d)/2
        allocate(distance_matrix(lower_size))
        distance_matrix = 0.0d0

        do i = 1, d
            do j = i, d

                idx = (j*j+j)/2 -j +i

                distance = sqrt( &
                    (coordinates(i,1) - coordinates(j,1))**2.0d0 + &
                    (coordinates(i,2) - coordinates(j,2))**2.0d0 + &
                    (coordinates(i,3) - coordinates(j,3))**2.0d0 )

                distance_matrix(idx) = distance

            end do
        end do

        write(*,*)
        call print_triangular(distance_matrix, d)
        write(*,*)

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


