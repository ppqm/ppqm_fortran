
import ppqm as pp

if __name__ == "__main__":

    # pp.constants.atom_index.__doc__

    assert pp.constants.atom_index("he") == 2
    assert pp.constants.atom_index("Lu") == 71
    assert pp.constants.atom_index("C") == 6
    assert pp.constants.atom_index("C") == 400

