
import ppqm as pp

# print pp.constants.atom_index.__doc__
# print pp.constants.atom_index("he") == 2
# print pp.constants.atom_index("C") == 6
# print pp.constants.atom_index("Lu") == 71



if __name__ == "__main__":

    try:
        assert pp.constants.atom_index("C") == 5

    except AssertionError:

        print "Failed"

