#!/usr/bin/env python
# -*- coding=utf-8 -*-
"""
This script will parses the .cls documents in this directory and 
find all the latex package included.
This scrips assume that you have an internet connection.

g-berthiaume
april 2018
"""
#----------------- Includes -----------------
import sys
import pathlib
import re
import requests
from bs4 import BeautifulSoup


#----------------- Regex pattern -----------------
# This regex will build a tuple of 3. 
LATEX_PACKAGE = r"""
\\(
    RequirePackage|usepackage  # \RequiredPackage or \usepackage
)
(
    \[.+\]                     # Latex package arguments e.g [5]
)?                             # 0 or 1 i.e. package can be w/o args.
{(
    \w+                        # package name e.g {babel}
)}                       
"""

#----------------- Script -----------------
def get_package_description(package_name):
    """Will parse the ctan website to get a description of the 
    package. 
    Args:
        packlatex_name: A string with the name of the package
    Return:
        A string with "{package_name} - {description}"
    """
    # get data from CTAN webstite
    ctan_url = "https://ctan.org/pkg/{}".format(package_name)
    ctan_page = requests.get(ctan_url)

    # parse to find description
    soup = BeautifulSoup(ctan_page.text, "html.parser")
    description = soup.find("h1").text
    
    if description == "Not Found":
        description = "{} - CTAN package not found".format(package_name)
    return description


def get_files(pattern):
    """Find a file in this dir
    Args:
        pattern: A string with the pattern to find
    Returns:
        A pathlib.Path list of file found
    """
    p = pathlib.Path('.')
    files = [f for f in p.rglob(pattern)]
    return files


def remove_doublon(this_list):
    """ Helper function """
    return list(set(this_list)) 


def get_packages_names(latex_file):
    """Find all the package name in a file
    Args:
        latex_file: A pathlib file
    Returns:
        A list of all the package name found in the latex_file
    """
    with latex_file.open('r', encoding='utf-8') as f:
        data = f.read()
        packages_info = re.findall(LATEX_PACKAGE, data, re.VERBOSE)
    
    # only get the name of the package
    package_names = [package_info[2] for package_info in packages_info]
    return package_names


def main():
    """Entry point for this script.
    """   
    # Find packages in project
    found_packages_names = []
    for cls_file in get_files("*.cls"):
        found_packages_names += (get_packages_names(cls_file))
    found_packages_names = remove_doublon(found_packages_names)

    # Find short desciption online
    found_packages_description = []
    for package_name in found_packages_names:
        found_packages_description.append(get_package_description(package_name))
        
    # Display
    print("Packages:")
    for package in sorted(found_packages_description, key=str.lower):
        print("- {desc}".format(desc=package))
    return 0


if __name__ == '__main__':
    sys.exit(main())
