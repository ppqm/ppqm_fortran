
module constants

    ! Constants
    double precision, parameter :: bohr2angstroem = 0.52917726d0
    double precision, parameter :: hartree2kcal = 627.509541d0
    double precision, parameter :: hartree2kj = 2625.5d0
    double precision, parameter :: pi = 4.0d0 * atan(1.0d0)

    ! Periodic table
    character(len=2) :: elements(94)
    data elements / &
    'h ',                                                                                'he', &
    'li','be',                                                  'b ','c ','n ','o ','f ','ne', &
    'na','mg',                                                  'al','si','p ','s ','cl','ar', &
    'k ','ca','sc','ti','v ','cr','mn','fe','co','ni','cu','zn','ga','ge','as','se','br','kr', &
    'rb','sr','y ','zr','nb','mo','tc','ru','rh','pd','ag','cd','in','sn','sb','te','i ','xe', &
    'cs','ba', &
         'la','ce','pr','nd','pm','sm','eu','gd','tb','dy','ho','er','tm','yb','lu', &
                   'hf','ta','w ','re','os','ir','pt','au','hg','tl','pb','bi','po','at','rn', &
    'fr','ra', &
         'ac','th','pa','u ','np','pu'/

    contains

        integer function atom_index(element)

            implicit none

            character(len=2) :: element
            integer :: j

            call lower_case(element)

            do j = 1, 94
                if ( element == elements(j) ) then
                    atom_index = j
                    exit
                end if
            end do

        end function atom_index


        subroutine lower_case(word)
            character (len=*) , intent(in out) :: word
            integer :: i, ic, nlen
            nlen = len(word)
            do i = 1, nlen
                ic = ichar(word(i:i))
                if (ic >= 65 .and. ic < 90) word(i:i) = char(ic+32)
            end do
        end subroutine lower_case

end module constants

