#!/usr/bin/env python3

from getpass import getpass
import json
import re
import subprocess

class Bitwarden:
    main_menu_options = {
        1: 'Create new item',
        2: 'Cancel',
    }
    item_types = {
        1: 'Login',
        2: 'Secure Note',
        3: 'Card',
        4: 'Identity',
        5: 'Cancel',
    }
    session_key = ''
    folders = []

    def __init__(self):
        self.check_bitwarden_login()
        self.unlock_vault()
        self.sync_vault()

    def process_request(self):
        while(True):
            print('What would you like to do?')
            self.print_menu(self.main_menu_options)
            option = ''
            try:
                option = int(input('Enter your choice: '))
            except:
                print('Wrong input. Please enter a number...')

            if option == 1:
                self.process_new_item_request()

            if option == 2:
                print('User aborted.')
                exit(0)

    def check_bitwarden_login(self):
        status_string = subprocess.getoutput('bw status')
        status_json = json.loads(status_string)
        if status_json['status'] == 'unauthenticated':
            print('You are not logged into Bitwarden. Please use the "bw login" command to log in and try again.')
            exit(1)

    def unlock_vault(self):
        password = self.get_users_password()
        status = subprocess.getoutput(f"echo {password} | bw unlock")
        substring = re.search(r'"([A-Za-z0-9/+=]*)=="', status)
        self.session_key = substring.group()

    def get_users_password(self):
        return getpass('Please enter your Bitwarden password: ')

    def sync_vault(self):
        status = subprocess.getstatusoutput(f"bw sync --session {self.session_key}")
        if status[0] != 0:
            print('Unable to sync the vault. Please try again later.')
            exit(1)

    def process_new_item_request(self):
        while(True):
            print('Please select which kind of item you want to create:')
            self.print_menu(self.item_types)
            option = ''
            try:
                option = int(input('Enter your choice: '))
            except:
                print('Wrong input. Please enter a number...')

            if option == 5:
                print('User aborted.')
                exit(0)

    def print_menu(self, list):
        for key in list.keys():
            print(key, '--', list[key])

    def get_folders(self):
        folders_string = subprocess.getoutput(f"bw list folders --session {self.session_key}")
        folders_json = json.loads(folders_string)
        folders = [a_dict['name'] for a_dict in folders_json]
        self.folders = folders

def main():
    bw = Bitwarden()
    bw.process_request()

if __name__ == '__main__':
    main()


