#!/usr/bin/env python

from getpass import getpass
import json
import re
import subprocess

class Bitwarden:
    session_key = ''
    folders = []

    def __init__(self):
        self.check_bitwarden_login()
        self.unlock_vault()
        self.sync_vault()

    def check_bitwarden_login(self):
        status_string = subprocess.getoutput('bw status')
        status_json = json.loads(status_string)
        if status_json['status'] == 'unauthenticated':
            print('You are not logged into Bitwarden. Please use the "bw login" command to log in and try again.')
            exit(1)

    def unlock_vault(self):
        print('First we need to log into Bitwarden...')
        password = self.get_users_password()
        status = subprocess.getoutput(f"echo {password} | bw unlock")
        substring = re.search(r'"([A-Za-z0-9/+=]*)=="', status)
        self.session_key = substring.group()

    def get_users_password(self):
        return getpass('Please enter your Bitwarden password: ')

    def sync_vault(self):
        print('We have to update the vault, standby...')
        status = subprocess.getstatusoutput(f"bw sync --session {self.session_key}")
        if status[0] != 0:
            print('Unable to sync the vault. Please try again later.')
            exit(1)

        print('Vault update complete.')

    def get_folders(self):
        print('Getting a list of folders...')
        folders_string = subprocess.getoutput(f"bw list folders --session {self.session_key}")
        folders_json = json.loads(folders_string)
        folders = [a_dict['name'] for a_dict in folders_json]
        self.folders = folders

def main():
    bw = Bitwarden()
    bw.get_folders()
    print(bw.folders)

if __name__ == '__main__':
    main()


