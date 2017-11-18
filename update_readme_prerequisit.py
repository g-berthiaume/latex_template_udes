#!/usr/bin/env python
# -*- coding=utf-8 -*-
"""
This script will parses the .cls documents and find all the package required.
It will update the README.md consequently.
"""
import sys
import pathlib
import re


def update_readme(packages):
    """Will update the read me content at the appropriate places.
    Args:
        packages: a list of package name
    Raise:
        Exception: if it didn't find a needed readme sectiom
        FileExistsError: if more than one readme as been found
    """
    readme = get_file("README.md")

    # Get the index and the file content
    with readme.open('r', encoding='utf-8') as f:
        rm_file = f.readlines()
        prequisit_ind = [
            i for i, elem in enumerate(rm_file) if '## Prérequis' in elem
        ]
        prequisit_ind = prequisit_ind.pop()

        nextsection_ind = [
            i for i, elem in enumerate(rm_file) if '## Pourquoi LaTeX' in elem
        ]
        nextsection_ind = nextsection_ind.pop()

        if prequisit_ind is None or nextsection_ind is None:
            raise Exception(
                "No '## Prérequis' or '## Pourquoi LaTeX' found in {}".format(
                    readme))

    # Delete previous content
    del rm_file[prequisit_ind + 2:nextsection_ind]

    # Update the content
    header = "Pour utiliser cette classe, les packages suivant sont nécessaires:\n\n"
    footer = "\n\n"
    rm_file.insert(prequisit_ind + 2, header)
    rm_file.insert(prequisit_ind + 3, footer)
    for pack in packages:
        pack_str = "  - {}\n".format(pack)
        rm_file.insert(prequisit_ind + 3, pack_str)

    # Update the file
    with readme.open("w", encoding='utf-8') as f:
        f.writelines(rm_file)

    print("Success: Updated {} packages.".format(len(packages)))


def get_file(pattern):
    """Find a file in this dir
    Args:
        A string with the pattern to find
    Returns:
        A pathlib.Path to the found file
    Raise:
        FileExistsError if not 1 file found
    """
    p = pathlib.Path('.')
    files = [f for f in p.rglob(pattern)]

    if len(files) != 1:
        raise FileExistsError(
            "More or less than one file found: {}".format(files))
    return pathlib.Path(files[0])


def get_packages():
    """Will find the cls file and parse it to find included package.
    Returns:
        a packages name list
    Raise:
        Exception if no package found
        FileExistsError: if more than one .cls as been found
    """
    packages = []

    template_cls = get_file("*.cls")
    with template_cls.open('r', encoding='utf-8') as f:
        myfile = f.read()

        # This regex will build a list of tuple.
        # The tuple will be bult as followed:
        #   0. RequiredPackage or usepackage
        #   1. The arguments pass to the package
        #   2. The package name
        includes = re.findall(r"\\(RequirePackage|usepackage)(\[.+\])?{(\w+)}",
                              myfile)
        for package in includes:
            if package != ('', '', ''):
                packages.append(package[-1])  # only get the name

        if len(packages) == 0:
            raise Exception("No package found in {}".format(template_cls))

    return packages


def main():
    """This script will parses the .cls documents and find all the package required.
    It will update the README.md consequently.
    """
    print("Updating packages list...")
    packages = get_packages()
    print("Updating the readme...")
    update_readme(packages)
    return 0


if __name__ == '__main__':
    sys.exit(main())
